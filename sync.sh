#!/bin/bash
deployDir=$(pwd)/_deploy
siteDir=$(pwd)/_site
siteUrl=https://github.com/skyscribe/skyscribe.github.io.git

function setup() {
    rm -fr $deployDir
    mkdir -p $deployDir
    cd "$deployDir"
    git init
    echo "dummy content" > index.html
    git add .
    git commit -m "dummy script init"
    git branch -m gh-pages
    git remote add origin "$siteUrl"
    echo "Setup complete for $deployDir"
}

function deploy() {
    cd "$deployDir"
    cp -r "$siteDir/*" "$deployDir/"
    git pull origin gh-pages
    git add -A
    now=$(date "+%Y-%m-%d_%H:%M:%S")
    git commit -m "site updated at $now"
    git push origin gh-pages --force
    echo "deploy completed"
}

case $1 in
  setup)
	    setup
        ;;

    * )
        deploy
        ;;
esac
