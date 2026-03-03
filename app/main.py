"""
1주차: HTTP 요청/응답 구조 확인 (에코 서버)

기능은 없습니다. "요청이 들어오고 응답이 나간다"는 흐름 자체를 확인하는 단계입니다.

이 단계에서 확인하셔야 할 것:
- 보낸 JSON이 서버 함수 입력으로 들어왔는지
- 서버가 JSON을 만들어서 돌려 주었는지
- 상태 코드가 200으로 왔는지

실습 순서: 서버를 실행하신 뒤(uvicorn app.main:app --reload), 브라우저에서
http://localhost:8000/docs 에 접속하세요. /health 에서 Try it out → Execute 로
응답을 확인하시고, 이어서 /summarize 에서 임의 JSON을 보내 보시면 됩니다.
body 내용을 바꿔 보면서 received 필드가 함께 바뀌는지 확인해 보시면 좋습니다.

다음 주로 넘어가는 이유: 지금 /summarize 는 아무 JSON이나 받습니다. 이건 "우연히
돌아가는 함수"에 가깝습니다. 2주차에서 Pydantic 스키마를 붙이면 규격 외 입력이
422로 차단됩니다.
"""

from fastapi import FastAPI

# TODO [1] -----------------------------------------------
# FastAPI 인스턴스를 생성하세요.
#
# 힌트:
#   app = FastAPI(
#       title=...,          # Swagger UI 상단에 표시될 앱 이름
#       description=...,    # 앱 설명
#       version=...,        # 앱 버전
#   )
#
# 사용할 값:
#   title       = "AIE_hands-on"
#   description = "테크 블로그 요약 서버 - 5주 커리큘럼"
#   version     = "0.1.0"
# --------------------------------------------------------
app = ...


# TODO [2] -----------------------------------------------
# GET /health 엔드포인트를 구현하세요.
#
# 역할: 서버가 살아 있음을 확인하는 기준 API입니다.
#       로직 없이 200 응답만 돌려 주면 됩니다.
#
# 응답 예시:
#   {"status": "ok"}
#
# 확인 방법:
#   /docs → GET /health → Try it out → Execute
#   → 응답 body와 상태 코드 200을 확인하세요.
# --------------------------------------------------------
@app.get("/health")
def health():
    pass  # TODO: 구현하세요


# TODO [3] -----------------------------------------------
# POST /summarize 엔드포인트를 구현하세요. (1주차: 에코)
#
# 역할: 받은 JSON을 그대로 되돌려 주는 에코입니다.
#       body: dict → 어떤 JSON이든 허용합니다.
#
# 응답 예시 ({"title": "FastAPI 입문", "content": "..."} 을 보냈을 때):
#   {
#     "received": {"title": "FastAPI 입문", "content": "..."},
#     "message": "echo ok"
#   }
#
# 힌트:
#   - status_code=200 을 데코레이터에 명시하세요.
#   - 반환값은 Python dict 로 만들면 FastAPI가 JSON으로 변환해 줍니다.
#
# 확인 방법:
#   /docs → POST /summarize → Try it out → Request body에 임의 JSON 입력 → Execute
#   → received 필드가 보낸 값과 동일한지 확인하세요.
# --------------------------------------------------------
@app.post("/summarize", status_code=200)
def summarize(body: dict):
    pass  # TODO: 구현하세요
