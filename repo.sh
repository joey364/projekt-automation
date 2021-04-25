#!/usr/bin/sh

mkdir $1 
cd  $1
git init
gh repo create $1 --public -y
echo 'README' >> README
git add . 
git ci -m 'Initial commit'
git remote set-url origin git@github.com:joey364/$1.git
git push -u origin master
