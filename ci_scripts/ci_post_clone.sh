#!/bin/sh

GITHUB_TOKEN=${GITHUB_TOKEN}

git clone https://$GITHUB_TOKEN@github.com/MaeumGaGym/MaeumagGym-iOS-ignoreds.git
pwd
cp -R MaeumagGym-iOS-ignoreds/xcconfigs ../
cp -R MaeumagGym-iOS-ignoreds/master.key ../Tuist
cp -R MaeumagGym-iOS-ignoreds/Config.swift ../Projects/Core/Sources
rm -rf MaeumagGym-iOS-ignoreds

cd ..

curl https://mise.jdx.dev/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"

mise install

mise exec -- tuist fetch

mise exec -- tuist generate