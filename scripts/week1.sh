#!/usr/bin/env bash
# ---------------------------------------------------------------
# 1주차 · GET /health  |  POST /summarize (에코)
# 사용법: ./scripts/week1.sh
# 서버 실행 후 사용: uvicorn app.main:app --reload
# ---------------------------------------------------------------

BASE_URL="http://localhost:8000"

# ── 출력 헬퍼 ──────────────────────────────────────────────────
BOLD="\033[1m"; RESET="\033[0m"
GREEN="\033[32m"; CYAN="\033[36m"; DIM="\033[2m"

header() { echo -e "\n${BOLD}${GREEN}▶ $1${RESET}"; }
label()  { echo -e "  ${CYAN}$1${RESET}"; }
divider(){ echo -e "  ${DIM}$(printf '─%.0s' {1..52})${RESET}"; }
# ───────────────────────────────────────────────────────────────

echo -e "\n${BOLD}╔══════════════════════════════════════╗${RESET}"
echo -e "${BOLD}║        1주차 API 테스트               ║${RESET}"
echo -e "${BOLD}╚══════════════════════════════════════╝${RESET}"

# [1] GET /health
header "[1] GET /health"
label  "→ 서버가 살아 있는지 확인합니다"
divider
curl -s "$BASE_URL/health" | jq .

# [2] POST /summarize — 에코
header "[2] POST /summarize  (에코)"
label  "→ 보낸 JSON이 received 필드로 그대로 돌아옵니다"
divider
curl -s -X POST "$BASE_URL/summarize" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "FastAPI 입문",
    "content": "FastAPI는 Python의 타입 힌트를 활용한 빠른 웹 프레임워크입니다."
  }' | jq .

echo -e "\n${DIM}────────────────────────────────────────────────────${RESET}"
echo -e "${BOLD}  완료${RESET}\n"
