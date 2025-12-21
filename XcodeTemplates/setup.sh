#!/bin/bash

# create-feature 명령어 전역 설치 스크립트

# 색상 정의
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== create-feature 명령어 설치 ===${NC}\n"

# 1. 스크립트 존재 확인
if [ ! -f "create-feature" ]; then
    echo -e "${RED}오류: create-feature 스크립트를 찾을 수 없습니다${NC}"
    echo "현재 디렉토리: $(pwd)"
    exit 1
fi

# 2. 설치 위치 선택
INSTALL_DIR="/usr/local/bin"

# sudo 권한 확인
if [ ! -w "$INSTALL_DIR" ]; then
    echo -e "${BLUE}설치 위치: $INSTALL_DIR${NC}"
    echo "관리자 권한이 필요합니다."
    echo ""

    # sudo로 복사 및 권한 설정
    sudo cp create-feature "$INSTALL_DIR/create-feature"
    sudo chmod 755 "$INSTALL_DIR/create-feature"
else
    cp create-feature "$INSTALL_DIR/create-feature"
    chmod +x "$INSTALL_DIR/create-feature"
fi

# 3. 설치 확인
if [ -f "$INSTALL_DIR/create-feature" ]; then
    echo -e "\n${GREEN}✓ 설치 완료!${NC}\n"
    echo -e "${BLUE}이제 어디서든 다음 명령어로 Feature Module을 생성할 수 있습니다:${NC}"
    echo ""
    echo "  create-feature FeatureName"
    echo "  create-feature FeatureName --path Features/Home/Feature"
    echo "  create-feature FeatureName --api /rest/v1/YourEndpoint"
    echo ""
    echo -e "${BLUE}도움말 보기:${NC}"
    echo "  create-feature --help"
    echo ""
else
    echo -e "\n${RED}✗ 설치 실패${NC}"
    exit 1
fi

# Xcode 템플릿도 설치할지 물어보기
echo -e "${BLUE}Xcode File Template도 함께 설치하시겠습니까? (y/N)${NC}"
read -p "> " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -f "install.sh" ]; then
        ./install.sh
    else
        echo -e "${RED}install.sh를 찾을 수 없습니다${NC}"
    fi
fi

echo -e "\n${GREEN}행복한 코딩 되세요! 🚀${NC}"
