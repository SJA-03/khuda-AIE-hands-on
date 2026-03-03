# 개발 환경 세팅 가이드

명령어만 외우려고 하지 마시고, **왜 이걸 하는지**만 이해하시면 됩니다. 그렇게 해두시면 나중에 에러가 나도 "아, 여기서 막혔구나" 스스로 찾으실 수 있습니다.

---

## 0. GitHub에서 코드 가져오기 (Fork & Clone)

> GitHub를 처음 접하시는 분도 아래 순서대로만 따라 하시면 됩니다.

### 0-1. GitHub 계정 만들기

아직 계정이 없으시다면 먼저 만들어 주세요.

1. [https://github.com](https://github.com) 접속
2. 우측 상단 **Sign up** 클릭
3. 이메일, 비밀번호, 사용자명 입력 후 가입 완료

이미 계정이 있으시면 이 단계는 건너뛰세요.

---

### 0-2. 레포지토리 Fork하기

**Fork**란 트랙장의 레포지토리를 **내 GitHub 계정으로 복사**하는 것입니다.
Fork한 뒤에는 내 계정 아래에 똑같은 레포지토리가 생기고, 거기에 자유롭게 코드를 올릴 수 있습니다.

1. 트랙장이 공유한 GitHub 레포지토리 주소로 접속합니다
2. 페이지 우측 상단의 **Fork** 버튼을 클릭합니다
3. **Owner**가 내 계정으로 선택되어 있는지 확인한 뒤 **Create fork** 클릭

Fork가 완료되면 주소창이 `https://github.com/내-아이디/레포지토리이름` 으로 바뀝니다.

---

### 0-3. 내 컴퓨터로 Clone하기

**Clone**이란 GitHub에 있는 레포지토리를 **내 컴퓨터로 내려받는** 것입니다.

먼저 터미널(Mac: Terminal, Windows: Git Bash 또는 PowerShell)을 열어 주세요.

```bash
# Git이 설치되어 있는지 확인
git --version
```

`git version 2.x.x` 형태로 출력되면 됩니다.
Git이 없으면 [https://git-scm.com/downloads](https://git-scm.com/downloads) 에서 설치하세요.

---

Git이 준비됐으면 아래 명령어로 Clone합니다.
`**내-아이디**` 부분은 본인의 GitHub 사용자명으로 바꿔 주세요.

```bash
git clone https://github.com/내-아이디/레포지토리이름.git
```

Clone이 완료되면 현재 폴더에 `레포지토리이름/` 폴더가 생깁니다. 그 안으로 이동합니다.

```bash
cd 레포지토리이름
```

---

### 0-4. 트랙장 레포지토리를 upstream으로 등록하기

강사가 코드를 업데이트하면 내 Fork에도 반영할 수 있어야 합니다.  
그러려면 트랙장 레포지토리를 **upstream** 이라는 이름으로 등록해 두면 됩니다.

```bash
git remote add upstream https://github.com/강사-아이디/레포지토리이름.git
```

잘 등록됐는지 확인해 보세요.

```bash
git remote -v
```

아래처럼 두 줄씩 보이면 정상입니다.

```
origin    https://github.com/내-아이디/레포지토리이름.git (fetch)
origin    https://github.com/내-아이디/레포지토리이름.git (push)
upstream  https://github.com/강사-아이디/레포지토리이름.git (fetch)
upstream  https://github.com/강사-아이디/레포지토리이름.git (push)
```

**왜 등록하느냐면,** 주차가 지날수록 트랙장 레포지토리에 새 코드가 추가됩니다. upstream을 등록해 두면 아래 명령어 한 줄로 최신 내용을 받아올 수 있습니다.

```bash
# 트랙장 레포지토리의 최신 내용을 내 로컬에 가져오기
git pull upstream main
```

---

### 0-5. 세팅 완료 확인

여기까지 하셨으면 내 컴퓨터에 프로젝트 폴더가 생겼을 겁니다.
아래 명령어로 파일이 제대로 있는지 확인해 보세요.

```bash
ls
```

`app/`, `docs/`, `scripts/`, `requirements.txt`, `README.md` 가 보이면 성공입니다.
이제 아래 **1번 사전 도구 설치**부터 이어서 진행하시면 됩니다.

---

## 1. 사전 도구 설치

### jq

`jq`는 터미널에서 JSON 응답을 보기 좋게 출력해 주는 도구입니다. `scripts/` 폴더의 curl 스크립트가 이 도구를 사용하므로 먼저 설치해 주세요.

```bash
# macOS
brew install jq

# Ubuntu / Debian (WSL 포함)
sudo apt-get update && sudo apt-get install -y jq

# Windows (winget)
winget install jqlang.jq
```

설치 확인:

```bash
jq --version
```

`jq-1.x` 형태로 버전이 출력되면 됩니다.

---

## 2. Python 버전 확인

먼저 아래 명령어를 한 번 실행해 보세요.

```bash
python --version
```

3.10 이상이면 됩니다. 안 되시면 `python3 --version` 으로 시도해 보세요.

**왜 확인하느냐면,** 이 프로젝트는 `str | None` 같은 문법을 쓰는데, 이건 Python 3.10부터 지원됩니다. 버전이 낮으면 코드가 아예 실행되지 않습니다.

---

## 3. 가상환경(venv) 만들기

이제 가상환경을 하나 만들어 봅시다.

```bash
python -m venv venv
```

**가상환경이 뭐냐면,** `pip install` 을 하면 기본적으로 컴퓨터 전체에 패키지가 설치됩니다. 그러면 프로젝트 A에서 쓴 버전이 프로젝트 B를 깨뜨릴 수 있습니다. 가상환경은 "이 프로젝트만 쓰는 공간"이라고 생각하시면 됩니다. `venv` 폴더 안에 Python과 패키지가 따로 들어갑니다.

---

## 4. 가상환경 활성화

만들기만 하면 아직 적용되지 않습니다. **활성화**를 해 주셔야 합니다.

```bash
# macOS / Linux
source venv/bin/activate

# Windows
venv\Scripts\activate
```

잘 되셨다면 터미널 맨 앞에 `(venv)` 가 붙어 있을 겁니다.

**활성화가 뭐냐면,** "지금 이 터미널에서는 venv 안의 Python을 쓸게"라고 알려 주는 것입니다. 이걸 안 하시면 `pip install` 해도 시스템 Python 쪽에 설치되어서, 우리가 만든 venv와는 상관없어집니다.

---

## 5. 패키지 설치

이제 필요한 패키지를 설치해 봅시다.

```bash
pip install -r requirements.txt
```

`-r requirements.txt` 는 "requirements.txt에 적힌 것을 한 줄씩 읽어서 모두 설치해라"는 뜻입니다. 버전까지 적혀 있기 때문에, 누가 하셔도 같은 환경이 만들어집니다.

설치가 끝나셨으면 아래로 확인해 보세요.

```bash
pip list
```

`fastapi` 와 `uvicorn` 이 목록에 보이시면 된 겁니다.

---

## 6. 서버 실행

이제 서버를 켜 보겠습니다.

```bash
uvicorn app.main:app --reload
```

**이 명령어가 무엇을 하는지만 정리해 보겠습니다.**


| 부분         | 의미                                            |
| ---------- | --------------------------------------------- |
| `uvicorn`  | FastAPI 앱을 실제 HTTP 포트에 올려 주는 서버 프로그램입니다       |
| `app.main` | `app/` 폴더 안의 `main.py` 파일입니다                  |
| `:app`     | `main.py` 안에 있는 `app = FastAPI(...)` 그 변수입니다  |
| `--reload` | 코드를 저장할 때마다 서버가 자동으로 다시 켜집니다 (개발할 때만 쓰시면 됩니다) |


**uvicorn이 왜 필요하냐면,** FastAPI는 "요청이 오면 이렇게 처리한다"는 **규칙**만 정해 둔 것이고, 스스로 네트워크 포트를 열지는 않습니다. uvicorn이 8000번 포트를 열고, 들어오는 요청을 FastAPI에게 넘겨 주는 역할을 합니다.

정상적으로 켜지면 아래와 비슷하게 출력됩니다.

```
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
INFO:     Started reloader process
```

---

## 7. 동작 확인

### Swagger UI (브라우저)

브라우저 주소창에 아래 주소를 입력해 보세요.

```
http://localhost:8000/docs
```

FastAPI가 우리 코드를 읽어서 API 문서와 테스트 화면을 자동으로 만들어 둔 것입니다. 여기서 요청을 보내 보시고, 응답이 어떻게 오는지 바로 확인하실 수 있습니다.

**Swagger가 왜 저절로 생기느냐면,** FastAPI가 라우터 함수의 타입과 Pydantic 모델을 보고 OpenAPI 스펙을 만들고, `/docs` 는 그걸 보기 좋게 보여 주는 주소입니다.

### curl로 직접 확인

터미널에서 아래처럼 실행해 보셔도 됩니다.

```bash
# 서버가 살아 있는지 확인
curl http://localhost:8000/health

# 요약 요청 (에코)
curl -X POST http://localhost:8000/summarize \
  -H "Content-Type: application/json" \
  -d '{"title": "테스트 글", "content": "FastAPI는 빠르다."}'
```

또는 `scripts/` 폴더에 준비된 주차별 스크립트를 사용하실 수 있습니다.

```bash
# 1주차 스크립트 실행 (서버가 켜진 상태에서 실행하세요)
./scripts/week1.sh
```

`scripts/week1.sh` 는 바로 실행 가능하고, `week2.sh` ~ `week5.sh` 는 해당 주차가 되면 주석을 해제해서 사용하시면 됩니다.

---

## 8. 서버 종료

서버를 끄려면 터미널에서 다음을 입력하시면 됩니다.

```bash
CTRL + C
```

---

## 정리: 세팅 전체 흐름

흐름만 다시 보겠습니다.

```
GitHub Fork & Clone (git clone ...)
    ↓
Python 버전 확인
    ↓
가상환경 생성 (python -m venv venv)
    ↓
가상환경 활성화 (source venv/bin/activate)
    ↓
패키지 설치 (pip install -r requirements.txt)
    ↓
서버 실행 (uvicorn app.main:app --reload)
    ↓
http://localhost:8000/docs 에서 확인
```

다음 주차에서 패키지가 추가되면 **5단계(패키지 설치)** 만 다시 실행하시면 됩니다.