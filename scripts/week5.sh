#!/usr/bin/env bash
# ---------------------------------------------------------------
# 5주차 · 엔드포인트·스키마는 4주차와 동일
#         처리 방식만 async/await 비동기로 전환
# 사용법: ./scripts/week5.sh
# ---------------------------------------------------------------

# BASE_URL="http://localhost:8000"
#
# # ── 출력 헬퍼 ──────────────────────────────────────────────────
# BOLD="\033[1m"; RESET="\033[0m"
# GREEN="\033[32m"; CYAN="\033[36m"; DIM="\033[2m"
#
# header() { echo -e "\n${BOLD}${GREEN}▶ $1${RESET}"; }
# label()  { echo -e "  ${CYAN}$1${RESET}"; }
# divider(){ echo -e "  ${DIM}$(printf '─%.0s' {1..52})${RESET}"; }
# # ───────────────────────────────────────────────────────────────
#
# echo -e "\n${BOLD}╔══════════════════════════════════════╗${RESET}"
# echo -e "${BOLD}║   5주차 API 테스트 (외부 동작 = 4주차)║${RESET}"
# echo -e "${BOLD}╚══════════════════════════════════════╝${RESET}"
#
# # [1] POST /summarize — 비동기 처리
# header "[1] POST /summarize"
# label  "→ async def 라우터 + await LLM 호출 + aiosqlite DB 저장"
# divider
# curl -s -X POST "$BASE_URL/summarize" \
#   -H "Content-Type: application/json" \
#   -d '{
#     "content_text": "async/await는 I/O 대기 시간 동안 다른 요청을 처리할 수 있게 해주는 비동기 패턴입니다.",
#     "title": "Python 비동기 프로그래밍",
#     "output_format": "json"
#   }' | jq .
#
# # [2] GET /summaries — 비동기 조회
# header "[2] GET /summaries  (전체 목록)"
# label  "→ await session.execute() 로 비동기 DB 조회"
# divider
# curl -s "$BASE_URL/summaries" | jq .
#
# # [3] GET /summaries/1
# header "[3] GET /summaries/1  (단건 조회)"
# divider
# curl -s "$BASE_URL/summaries/1" | jq .
#
# echo -e "\n${DIM}────────────────────────────────────────────────────${RESET}"
# echo -e "${BOLD}  완료${RESET}\n"
