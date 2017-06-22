deployDir=$(shell pwd)/_deploy
siteDir=$(shell pwd)/_site
siteUrl=https://github.com/skyscribe/skyscribe.github.io.git
now=$(shell date "+%Y-%m-%d_%H:%M:%S")

.PNONY: setup deploy

setup: 
	rm -fr $(deployDir)
	mkdir $(deployDir) 
	cd $(deployDir)
	git init
	echo "Dummy content" > index.html
	git add .
	git commit -m "dummy script init"
	git remote add origin $(siteUrl)
	echo "setup completed for $(deployDir)"

deploy:
	cd $(deployDir)
	git pull
	cp -r $(siteDir) $(deployDir)
	git add -A
	git commit -m "site updated at $(now)"
	git push origin github-pages --force 
	echo "deploy complete"
