BUILD_DIR=./.build
TEMPLATES_DIR=templates
BIN_NAME=Iconic
DEBUG_DIR=${BUILD_DIR}/debug
RELEASE_DIR=${BUILD_DIR}/release
ARTEFACT=${BIN_NAME}-${VERSION}

release: clean dependencies
	swift build --configuration release
	cp -Rf ${TEMPLATES_DIR}/. ${RELEASE_DIR}/${TEMPLATES_DIR}
	mkdir ${ARTEFACT}
	cp -Rf ${TEMPLATES_DIR}/. ${ARTEFACT}/${TEMPLATES_DIR}
	cp -Rf LICENSE README.md ${RELEASE_DIR}/${BIN_NAME} ${ARTEFACT}
	(cd ${ARTEFACT}; zip -r - *) > ./${ARTEFACT}.zip

build: clean dependencies
	swift build
	cp -Rf ${TEMPLATES_DIR}/. ${DEBUG_DIR}/${TEMPLATES_DIR}

dependencies:
	swift package fetch

clean:
	swift package clean
	rm -rf Iconic-*
