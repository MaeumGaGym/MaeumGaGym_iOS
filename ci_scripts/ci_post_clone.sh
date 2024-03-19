#!/bin/sh

GITHUB_TOKEN=${GITHUB_TOKEN}

git clone https://$GITHUB_TOKEN@github.com/MaeumGaGym/MaeumagGym-iOS-ignoreds.git

cp -R MaeumagGym-iOS-ignoreds/xcconfigs ../

curl -Ls https://install.tuist.io | bash

tuist fetch

tuist generate
