#!/bin/bash

BUILD_NAME=1.0.0
BUILD_NUMBER=1
APK_NAME=hirevire

flutter build apk --build-name=${BUILD_NAME} --build-number=${BUILD_NUMBER}
mv build/app/outputs/flutter-apk/app-release.apk ./${APK_NAME}.apk

# Add colors to the echo output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "======================================================================"
echo -e "🗂️   ${GREEN}${APK_NAME}.apk created at project root${NC}"
echo "======================================================================"