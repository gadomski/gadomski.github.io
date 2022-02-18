#!/usr/bin/env sh

set -ex

if [[ -d _site ]]; then
    cd _site
else
    mkdir -p _site
    cd _site
    git init
    git remote add origin git@github.com:gadomski/gadomski.github.io
    git fetch origin
fi

git checkout gh-pages
git pull origin gh-pages
cd ..
bundle exec jekyll build
cd _site
git add .
git commit -m "publish.sh"
git push origin gh-pages
cd ..
