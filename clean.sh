#!/bin/bash

echo "=========================================="
echo "Docker 빌드 캐시 정리"
echo "=========================================="
echo ""

read -p "Maven 저장소와 Keycloak 소스를 삭제하시겠습니까? (y/N): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "볼륨 삭제 중..."
    docker-compose down -v
    echo "완료!"
else
    echo "취소됨"
fi

