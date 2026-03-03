#!/usr/bin/env bash
# ---------------------------------------------------------------
# 4주차 · 엔드포인트·스키마는 3주차와 동일
#         내부 구조만 레이어드 아키텍처로 분리 (Router / Service / Repository)
# 사용법: ./scripts/week4.sh
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
# echo -e "${BOLD}║   4주차 API 테스트 (외부 동작 = 3주차)║${RESET}"
# echo -e "${BOLD}╚══════════════════════════════════════╝${RESET}"
#
# # [1] POST /summarize
# header "[1] POST /summarize"
# label  "→ Service 레이어에서 LLM 호출, Repository 레이어에서 DB 저장"
# divider
# curl -s -X POST "$BASE_URL/summarize" \
#   -H "Content-Type: application/json" \
#   -d '{
#     "content_text": "LangChain은 LLM 기반 애플리케이션 개발을 돕는 프레임워크입니다.",
#     "title": "LangChain 소개",
#     "output_format": "json"
#   }' | jq .
#
# # [2] GET /summaries
# header "[2] GET /summaries  (전체 목록)"
# label  "→ Repository 레이어를 통해 조회합니다"
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
