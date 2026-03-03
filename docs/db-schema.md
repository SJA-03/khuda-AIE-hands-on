# DB 스키마

> 이 문서는 3주차부터 적용됩니다. 1~2주차에는 DB를 사용하지 않습니다.

> **DB(데이터베이스)란?** 데이터를 구조적으로 저장하고 다시 꺼낼 수 있도록 해 주는 레포지토리입니다. 서버가 꺼져도 데이터가 사라지지 않도록 하는 역할을 합니다.

---

## 설계 원칙

DB는 AI 내부 상태를 저장하는 것이 아닙니다. **API의 입력과 출력, 즉 계약을 그대로 저장합니다.**

이유는 다음과 같습니다. DB에 저장된 레코드를 꺼냈을 때, 그 시점의 요청과 응답이 완전히 재현되어야 합니다. "이 글로 요약을 요청했고, 이런 결과가 나왔다"가 하나의 레코드에 담겨야 합니다.

---

## DB 선택: SQLite

SQLite는 Python에 기본 내장되어 있습니다. 별도 설치 없이 파일 하나(`summary.db`)로 DB 전체가 동작합니다. 서버를 처음 실행하면 프로젝트 폴더에 `summary.db` 파일이 자동으로 생성됩니다.

> 나중에 MySQL 같은 다른 DB로 교체하더라도, SQLAlchemy를 쓰면 연결 주소 한 줄만 바꾸면 됩니다.

---

## 테이블: `summaries`

> **테이블이란?** DB 안에서 데이터를 담는 구조입니다. 엑셀 시트처럼 행(row)과 열(column)로 이루어져 있습니다. 하나의 요약 결과 = 하나의 행입니다.

아래 DDL로 테이블을 생성합니다.

> **DDL(Data Definition Language)이란?** 테이블의 구조를 정의하는 SQL 문입니다. "이런 컬럼을 가진 테이블을 만들어라"는 명령입니다.

```sql
CREATE TABLE summaries (
    id             INTEGER  PRIMARY KEY AUTOINCREMENT,
    title          TEXT,
    content_text   TEXT     NOT NULL,
    output_json    TEXT     NOT NULL,
    prompt_version TEXT     NOT NULL,
    created_at     TEXT     NOT NULL DEFAULT (datetime('now'))
);
```

> SQLite에는 JSON 전용 타입이 없습니다. `output_json` 컬럼은 `TEXT`로 저장하고, Python에서 `json.dumps()` (저장 시) / `json.loads()` (조회 시) 로 변환합니다.

---

## 컬럼 설명

> **컬럼(Column)이란?** 테이블의 열입니다. 각 컬럼은 저장할 데이터의 종류와 규칙을 정의합니다.

각 컬럼이 왜 있는지만 정리해 두었습니다.


| 컬럼               | 타입      | 제약                                | 역할                                                                               |
| ---------------- | ------- | --------------------------------- | -------------------------------------------------------------------------------- |
| `id`             | INTEGER | PRIMARY KEY AUTOINCREMENT         | 각 레코드의 고유 번호입니다. 저장할 때마다 1씩 자동으로 증가합니다. `GET /summaries/{id}` 의 `{id}` 가 이 값입니다. |
| `title`          | TEXT    | NULL 허용                           | 요청의 `title` 필드입니다. 선택 필드라 비어 있을 수 있습니다.                                          |
| `content_text`   | TEXT    | NOT NULL                          | 요약 요청의 본문입니다. 반드시 있어야 합니다.                                                       |
| `output_json`    | TEXT    | NOT NULL                          | 요약 결과(SummaryResponse) 전체를 JSON 문자열로 저장합니다.                                      |
| `prompt_version` | TEXT    | NOT NULL                          | 어떤 버전의 프롬프트로 만든 결과인지 기록합니다. 프롬프트를 수정했을 때 이전 결과와 구분하는 데 필요합니다.                    |
| `created_at`     | TEXT    | NOT NULL, DEFAULT datetime('now') | 저장된 시각입니다. 목록 조회 시 최신순 정렬 기준이 됩니다.                                               |


> **NOT NULL이란?** 해당 컬럼이 반드시 값을 가져야 한다는 제약 조건입니다. 비어 있으면 저장 자체가 거부됩니다.

---

## 저장 흐름

`POST /summarize` 요청이 들어왔을 때 DB 저장까지의 흐름입니다.

```
요청 수신
    ↓
SummaryRequest 스키마 검증 → 실패 시 422 반환 (여기서 끝)
    ↓
LLM 호출 → 결과 텍스트 반환
    ↓
결과를 SummaryResponse 스키마로 파싱·검증 → 실패 시 저장 안 함
    ↓
검증 통과한 경우에만 summaries 테이블에 저장
    ↓
저장된 레코드의 id 포함해서 응답 반환
```

DB에는 항상 유효한 계약만 들어가도록 보장합니다.

---

## 조회 쿼리

> **SQL이란?** DB에 데이터를 넣고 꺼낼 때 쓰는 언어입니다. `SELECT` 는 조회, `FROM` 은 어떤 테이블에서, `WHERE` 는 어떤 조건으로 꺼낼지를 의미합니다.

### 목록 조회 (`GET /summaries`)

```sql
SELECT id, title, created_at
FROM summaries
ORDER BY created_at DESC;  -- 최신순 정렬
```

### 단건 조회 (`GET /summaries/{id}`)

```sql
SELECT id, title, content_text, output_json, prompt_version, created_at
FROM summaries
WHERE id = :id;  -- :id 자리에 실제 숫자가 들어갑니다
```

---

## 인덱스

> **인덱스란?** 특정 컬럼을 기준으로 빠르게 검색할 수 있도록 미리 만들어 두는 색인입니다. 책의 목차와 비슷합니다. 데이터가 적을 때는 없어도 무방하지만, 많아질수록 조회 속도 차이가 납니다.

```sql
-- 생성 시간 기준 정렬이 느려질 때 추가합니다
CREATE INDEX idx_summaries_created_at ON summaries (created_at DESC);
```

---

## 4주차: SQLAlchemy ORM 모델

> **ORM(Object-Relational Mapping)이란?** SQL을 직접 쓰는 대신, Python 클래스로 DB를 다룰 수 있게 해 주는 도구입니다. `SELECT * FROM summaries` 대신 `session.query(Summary).all()` 처럼 쓸 수 있습니다.

4주차에서 레이어를 나눌 때 아래 모델을 사용합니다. 위의 DDL 테이블과 컬럼이 1:1로 대응합니다.

```python
from sqlalchemy import Column, Integer, Text, func
from database import Base

class Summary(Base):
    __tablename__ = "summaries"

    id             = Column(Integer, primary_key=True, autoincrement=True)
    title          = Column(Text, nullable=True)
    content_text   = Column(Text, nullable=False)
    output_json    = Column(Text, nullable=False)   # json.dumps()로 저장
    prompt_version = Column(Text, nullable=False)
    created_at     = Column(Text, server_default=func.now(), nullable=False)
```

DB 연결 설정은 아래와 같습니다.

```python
# database.py (3주차에서 추가)
from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker

DATABASE_URL = "sqlite:///./summary.db"   # 프로젝트 루트에 summary.db 파일 생성

engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(bind=engine)
Base = declarative_base()
```

> `check_same_thread=False` 는 SQLite 전용 설정입니다. SQLite는 기본적으로 같은 스레드에서만 연결을 쓰도록 제한하는데, FastAPI는 요청마다 다른 스레드를 쓸 수 있어서 이 제한을 풀어 주어야 합니다.

