#!/bin/sh

GITHUB_TOKEN=${GITHUB_TOKEN}

git clone https://$GITHUB_TOKEN@github.com/MaeumGaGym/MaeumagGym-iOS-ignoreds.git

cp -R MaeumagGym-iOS-ignoreds/xcconfigs ../

.tuist-bin/tuist fetch

.tuist-bin/tuist generate
