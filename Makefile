build: dependencies
	swift build

dependencies:
	swift package fetch

clean:
	swift package clean