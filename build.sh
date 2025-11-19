#!/bin/bash

set -e

echo "=========================================="
echo "Keycloak Extension 빌드 스크립트"
echo "=========================================="
echo ""

# 색상 정의
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 1단계: Keycloak 소스 빌드
echo -e "${YELLOW}[1/2] Keycloak 소스 빌드 중...${NC}"
echo "버전: 19.0.3"
echo "시간: 첫 빌드 시 20-30분 소요 (이후 스킵됨)"
echo ""

docker-compose run --rm keycloak-builder

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Keycloak 빌드 완료${NC}"
    echo ""
else
    echo -e "${RED}Keycloak 빌드 실패${NC}"
    exit 1
fi

# 2단계: Extension 빌드
echo -e "${YELLOW}[2/2] Extension 빌드 중...${NC}"
echo ""

docker-compose run --rm extension-builder

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}=========================================="
    echo "빌드 완료!"
    echo "==========================================${NC}"
    echo ""
    echo "빌드된 파일 위치:"
    find . -name "*.jar" -path "*/target/*" -not -path "*/keycloak/*" | head -20
else
    echo -e "${RED}Extension 빌드 실패${NC}"
    exit 1
fi

