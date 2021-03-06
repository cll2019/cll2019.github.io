#!/bin/bash
set -ev

git clone --recursive https://${GH_REF} .deploy_git
cd .deploy_git
git checkout master

cd ../
mv .deploy_git/.git/ ./public/

cd ./public
git config user.name  "chenlingling"
git config user.email "562179151@qq.com"

# add commit timestamp
git add .
git commit -m "Travis CI Auto Builder at `date +"%Y-%m-%d %H:%M"`"
git push --force --quiet "https://${Token}@${GH_REF}" master:master
