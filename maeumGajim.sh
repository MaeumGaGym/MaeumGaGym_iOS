#!/bin/bash

# maeumGajim.sh

if [ "$1" = "generate" ]; then
    echo "프로젝트를 준비 중입니다. (헬스장 입장 중...💪)"
    tuist fetch
    if tuist generate; then
        echo "프로젝트 실행 준비가 완료되었습니다...!(운동 시작...😁)"
    else
        echo "프로젝트 실행 준비에 실패하였습니다...!(빨간날...🙁)"
        echo "⚠️ ↑↑↑↑↑ 위 에러를 고려해주세요 ↑↑↑↑↑ ⚠️"
    fi
elif [ "$1" = "clean" ]; then
    echo "프로젝트를 초기화 중 (마치 웨이트를 들듯 힘을 모으고 있어요! 💪💼)"
    tuist clean
    rm -rf **/*.xcodeproj
    rm -rf *.xcworkspace
    echo "프로젝트 초기화가 완료되었습니다...!(새 마음, 새 뜻으로 운동할 준비가 되었습니다 🎉)"
    
elif [ "$1" = "edit" ]; then
    echo "프로젝트 수정 준비 중입니다. (닭가슴살 요리중...🐓)"
    tuist edit
    echo "프로젝트 수정 준비가 완료되었습니다! (닭가슴살 요리 완료! 🍗)"
elif [ "$1" = "fetch" ]; then
    echo "프로젝트 라이브러리 적용 중입니다. (프로틴 쉐이크 가루 예쁘게 넣는 중...🥛)"
    tuist fetch
    if [ $? -eq 0 ]; then
        echo "프로젝트 라이브러리 적용을 성공적으로 끝냈습니다! (프로틴 쉐이크가 예쁘게 타졌습니다! 🧋)"
    else
        echo "프로젝트 라이브러리 적용 중에 문제가 발생했습니다... (프로틴 쉐이크가 맛있지 않다...🤢)"
        echo "⚠️ ↑↑↑↑↑ 위 에러를 고려해주세요 ↑↑↑↑↑ ⚠️"
    fi
else
    echo "사용법: ./maeumGajim.sh generate 또는 ./maeumGajim.sh clean 또는 ./maeumGajim.sh edit 또는 ./maeumGajim.sh fetch"
fi
