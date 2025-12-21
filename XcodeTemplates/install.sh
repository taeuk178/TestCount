#!/bin/bash

# Xcode 템플릿 설치 스크립트

# 색상 정의
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Xcode Feature Module Template 설치 ===${NC}\n"

# 템플릿 디렉토리 경로
TEMPLATE_NAME="Feature Module.xctemplate"
TEMPLATE_SOURCE="$(pwd)/$TEMPLATE_NAME"
XCODE_TEMPLATE_DIR="$HOME/Library/Developer/Xcode/Templates/File Templates/Custom"

# 1. Xcode 템플릿 디렉토리 생성
echo -e "${BLUE}1. Xcode 템플릿 디렉토리 확인 중...${NC}"
if [ ! -d "$XCODE_TEMPLATE_DIR" ]; then
    echo "   템플릿 디렉토리 생성 중..."
    mkdir -p "$XCODE_TEMPLATE_DIR"
    echo -e "   ${GREEN}✓ 디렉토리 생성 완료${NC}"
else
    echo -e "   ${GREEN}✓ 디렉토리 존재함${NC}"
fi

# 2. 템플릿 파일 존재 확인
echo -e "\n${BLUE}2. 템플릿 파일 확인 중...${NC}"
if [ ! -d "$TEMPLATE_SOURCE" ]; then
    echo -e "   ${RED}✗ 오류: 템플릿 파일을 찾을 수 없습니다${NC}"
    echo "   경로: $TEMPLATE_SOURCE"
    exit 1
else
    echo -e "   ${GREEN}✓ 템플릿 파일 발견${NC}"
fi

# 3. 기존 템플릿 백업 (있는 경우)
TEMPLATE_DEST="$XCODE_TEMPLATE_DIR/$TEMPLATE_NAME"
if [ -d "$TEMPLATE_DEST" ]; then
    echo -e "\n${BLUE}3. 기존 템플릿 백업 중...${NC}"
    BACKUP_NAME="$TEMPLATE_NAME.backup.$(date +%Y%m%d_%H%M%S)"
    mv "$TEMPLATE_DEST" "$XCODE_TEMPLATE_DIR/$BACKUP_NAME"
    echo -e "   ${GREEN}✓ 백업 완료: $BACKUP_NAME${NC}"
else
    echo -e "\n${BLUE}3. 기존 템플릿 없음 (신규 설치)${NC}"
fi

# 4. 템플릿 복사
echo -e "\n${BLUE}4. 템플릿 설치 중...${NC}"
cp -R "$TEMPLATE_SOURCE" "$TEMPLATE_DEST"

if [ $? -eq 0 ]; then
    echo -e "   ${GREEN}✓ 템플릿 설치 완료${NC}"
else
    echo -e "   ${RED}✗ 템플릿 설치 실패${NC}"
    exit 1
fi

# 5. 설치 확인
echo -e "\n${BLUE}5. 설치 확인${NC}"
if [ -d "$TEMPLATE_DEST" ]; then
    echo -e "   ${GREEN}✓ 템플릿이 성공적으로 설치되었습니다${NC}"
    echo -e "   설치 위치: ${GREEN}$TEMPLATE_DEST${NC}"
else
    echo -e "   ${RED}✗ 설치 확인 실패${NC}"
    exit 1
fi

# 사용 방법 안내
echo -e "\n${GREEN}=== 설치 완료 ===${NC}\n"
echo -e "${BLUE}사용 방법:${NC}"
echo "1. Xcode를 재시작합니다 (이미 실행 중인 경우)"
echo "2. 프로젝트에서 File > New > File... (⌘N) 선택"
echo "3. 스크롤하여 'Custom' 섹션 찾기"
echo "4. 'Feature Module' 템플릿 선택"
echo "5. Feature Name 입력 (예: UserProfile, ExerciseList)"
echo "6. API Endpoint 입력 (예: /rest/v1/UserProfile)"
echo "7. 저장 위치 선택하고 Create"
echo ""
echo -e "${BLUE}생성되는 파일:${NC}"
echo "- {FeatureName}View.swift"
echo "- {FeatureName}ViewModel.swift"
echo "- {FeatureName}UseCase.swift"
echo "- {FeatureName}Model.swift"
echo "- {FeatureName}API.swift"
echo ""
echo -e "${GREEN}행복한 코딩 되세요! 🚀${NC}\n"
