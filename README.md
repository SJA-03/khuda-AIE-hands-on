# AI 엔지니어링 트랙 실습 세션 안내

AI 엔지니어링 트랙 실습에 오신 것을 환영합니다!

1~5주차는 백엔드의 기초에 대해서 공부합니다.
하나의 주제로 매 주차별로 코드를 추가, 수정하면서 실습이 진행됩니다.
따라서, 이전 주차의 내용을 놓치면 다음 주차의 내용에 대한 이해가 어렵습니다.
**이 점 반드시 유의하여 실습에 적극적으로 참여 해주시길 바랍니다.**

실습에서는 파이썬과 FastAPI를 사용하여 테크 블로그 요약 챗봇 서버를 구현해보려고 합니다.  
여러분은 5주 동안 "요청을 받고 응답을 돌려준다"에서 시작해서 "동시에 여러 요청을 처리하는 구조화된 시스템"까지 단계별로 디벨롭 해보는 과정을 경험합니다.

---

## 서버 기본 세팅 명령어

```bash
# 가상환경 생성 및 활성화
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# 패키지 설치
pip install -r requirements.txt

# 서버 실행
uvicorn app.main:app --reload
```

서버가 뜨면 브라우저에서 [http://localhost:8000/docs](http://localhost:8000/docs) 접속 → Swagger UI 확인.

---

## 현재 구현 상태


| 주차  | 핵심                             | 상태    |
| --- | ------------------------------ | ----- |
| 1주차 | HTTP 요청/응답 구조 확인 (에코 서버)       | ✅ 구현  |
| 2주차 | Pydantic 스키마로 입력/출력 계약 고정      | 🔜 예정 |
| 3주차 | DB 저장/조회 (SQLite + SQLAlchemy) | 🔜 예정 |
| 4주차 | 레이어드 아키텍처 + LangChain 연동       | 🔜 예정 |
| 5주차 | async 처리로 동시 요청 대응             | 🔜 예정 |


---

## 문서


| 문서                            | 설명               |
| ----------------------------- | ---------------- |
| [개발 환경 세팅 가이드](docs/setup.md) | 환경 구성 및 실행 방법    |
| [5주 개발 로드맵](docs/roadmap.md)  | 주차별 학습·구현 계획     |
| [API 명세](docs/api-spec.md)    | 엔드포인트 및 요청/응답 스펙 |
| [DB 스키마](docs/db-schema.md)   | 데이터베이스 테이블 정의    |


---

## 프로젝트 구조

```
AIE/
├── app/
│   └── main.py          
├── docs/
│   ├── setup.md
│   ├── roadmap.md
│   ├── api-spec.md
│   └── db-schema.md
├── scripts/
│   ├── week1.sh
│   ├── week2.sh
│   ├── week3.sh
│   ├── week4.sh
│   └── week5.sh
├── requirements.txt
└── README.md
```

