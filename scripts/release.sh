#!/usr/bin/env bash

GREEN="\x1b[32m"
RESET="\x1b[0m"

BUMP=$(git cliff --bump -o CHANGELOG.md 2>&1)

if echo "$BUMP" | grep -q "There is nothing to bump."; then
    echo "nothing to release"
    exit 1
fi

echo -e "${GREEN}updated changelog ✅${RESET}"

VERSION=$(git cliff --bumped-version)
TAG="v${VERSION}"

git add CHANGELOG.md
git commit -m "chore(release): prepare for $VERSION"
git tag $TAG

echo -e "${GREEN}tagged version ✅${RESET}"

REMOTE=$(git remote)

git push $REMOTE main
git push $REMOTE $TAG

echo -e "${GREEN}pushed main + tag ✅${RESET}"

