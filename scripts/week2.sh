#!/usr/bin/env bash
# ---------------------------------------------------------------
# 2주차 · POST /summarize (스키마 적용 — 정상 요청 / 422 유발)
# 사용법: ./scripts/week2.sh
# ---------------------------------------------------------------

# BASE_URL="http://localhost:8000"
#
# # ── 출력 헬퍼 ──────────────────────────────────────────────────
# BOLD="\033[1m"; RESET="\033[0m"
# GREEN="\033[32m"; CYAN="\033[36m"; DIM="\033[2m"; YELLOW="\033[33m"
#
# header() { echo -e "\n${BOLD}${GREEN}▶ $1${RESET}"; }
# label()  { echo -e "  ${CYAN}$1${RESET}"; }
# note()   { echo -e "  ${YELLOW}$1${RESET}"; }
# divider(){ echo -e "  ${DIM}$(printf '─%.0s' {1..52})${RESET}"; }
# # ───────────────────────────────────────────────────────────────
#
# echo -e "\n${BOLD}╔══════════════════════════════════════╗${RESET}"
# echo -e "${BOLD}║        2주차 API 테스트               ║${RESET}"
# echo -e "${BOLD}╚══════════════════════════════════════╝${RESET}"
#
# # [1] POST /summarize — 정상 요청
# header "[1] POST /summarize  (정상 요청)"
# label  "→ 스키마를 충족하면 200 + SummaryResponse가 반환됩니다"
# divider
# curl -s -X POST "$BASE_URL/summarize" \
#   -H "Content-Type: application/json" \
#   -d '{
#     "content_text": "FastAPI는 Python의 타입 힌트를 활용해 빠르고 안전한 API를 작성할 수 있는 프레임워크입니다.",
#     "title": "FastAPI 완벽 가이드",
#     "output_format": "json"
#   }' | jq .
#
# # [2] POST /summarize — 잘못된 요청 (422 유발)
# header "[2] POST /summarize  (잘못된 요청)"
# label  "→ content_text 누락 + output_format 허용값 위반"
# note   "  예상 응답: 422 Unprocessable Entity"
# divider
# curl -s -X POST "$BASE_URL/summarize" \
#   -H "Content-Type: application/json" \
#   -d '{
#     "output_format": "xml"
#   }' | jq .
#
# echo -e "\n${DIM}────────────────────────────────────────────────────${RESET}"
# echo -e "${BOLD}  완료${RESET}\n"
