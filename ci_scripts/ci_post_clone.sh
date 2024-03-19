#!/bin/sh

GITHUB_TOKEN=${GITHUB_TOKEN}

git clone https://$GITHUB_TOKEN@github.com/MaeumGaGym/MaeumagGym-iOS-ignoreds.git
pwd
cp -R MaeumagGym-iOS-ignoreds/xcconfigs ../
rm -rf MaeumagGym-iOS-ignoreds

cd ..

curl https://mise.jdx.dev/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"

mise install

mise exec tuist@3.23.1 fetch

mise exec tuist@3.23.1 generate
