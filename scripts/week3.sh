#!/usr/bin/env bash
# ---------------------------------------------------------------
# 3주차 · POST /summarize (DB 저장)
#         GET  /summaries  |  GET /summaries/{id}
# 사용법: ./scripts/week3.sh
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
# echo -e "${BOLD}║        3주차 API 테스트               ║${RESET}"
# echo -e "${BOLD}╚══════════════════════════════════════╝${RESET}"
#
# # [1] POST /summarize — 요약 생성 + DB 저장
# header "[1] POST /summarize  (요약 생성 + DB 저장)"
# label  "→ 응답에 id 필드가 추가됩니다"
# divider
# curl -s -X POST "$BASE_URL/summarize" \
#   -H "Content-Type: application/json" \
#   -d '{
#     "content_text": "FastAPI는 Python의 타입 힌트를 활용해 빠르고 안전한 API를 작성할 수 있는 프레임워크입니다.",
#     "title": "FastAPI 완벽 가이드",
#     "output_format": "json"
#   }' | jq .
#
# # [2] GET /summaries — 전체 목록 (최신순)
# header "[2] GET /summaries  (전체 목록)"
# label  "→ 저장된 요약을 최신순으로 반환합니다"
# divider
# curl -s "$BASE_URL/summaries" | jq .
#
# # [3] GET /summaries/1 — 단건 조회
# header "[3] GET /summaries/1  (단건 조회)"
# label  "→ id=1 인 요약 전체 필드를 반환합니다"
# divider
# curl -s "$BASE_URL/summaries/1" | jq .
#
# # [4] GET /summaries/9999 — 없는 id (404)
# header "[4] GET /summaries/9999  (없는 id)"
# note   "  예상 응답: 404 Not Found"
# divider
# curl -s "$BASE_URL/summaries/9999" | jq .
#
# echo -e "\n${DIM}────────────────────────────────────────────────────${RESET}"
# echo -e "${BOLD}  완료${RESET}\n"
