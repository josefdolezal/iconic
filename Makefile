build: dependencies
	swift build
	cp -Rf ./templates/. ./.build/debug/templates

dependencies:
	swift package fetch

clean:
	swift package clean