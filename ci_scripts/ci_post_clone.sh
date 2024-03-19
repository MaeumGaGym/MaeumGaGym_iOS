#!/bin/sh

GITHUB_TOKEN=${GITHUB_TOKEN}

git clone https://$GITHUB_TOKEN@github.com/MaeumGaGym/MaeumagGym-iOS-ignoreds.git
pwd
cp -R MaeumagGym-iOS-ignoreds/xcconfigs ../
rm -rf MaeumagGym-iOS-ignoreds

cd ..

curl https://mise.jdx.dev/install.sh | sh
mise install

mise x tuist fetch

mise x tuist generate
