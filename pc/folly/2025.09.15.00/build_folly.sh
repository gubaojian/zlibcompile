#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_MODE=release
LIB_NAME=folly
VERSION=2025.09.15.00
INSTALL_DIR=$HOME/cdeps/${LIB_MODE}/${LIB_NAME}/${VERSION}
CDEPS_ZIP_FILE=cdeps_${LIB_NAME}_${VERSION}.zip
UNZIP_DIR=folly
uname -a
echo "Script directory: $SCRIPT_DIR"
echo "INSTALL directory: $INSTALL_DIR"
echo "CDEPS_ZIP_FILE: $CDEPS_ZIP_FILE"
echo "DOWNLOAD_URL: $DOWNLOAD_URL"
echo "UNZIP_DIR: $UNZIP_DIR"

rm -rf ${CDEPS_ZIP_FILE}

## rm -rf ${UNZIP_DIR}

rm -rf ${INSTALL_DIR}
mkdir -p ${INSTALL_DIR}
mkdir -p ${SCRIPT_DIR}/scratch

cd ${UNZIP_DIR}

export CFLAGS="${CFLAGS} -O3 "
export CXXFLAGS="${CXXFLAGS} -O3 "

./build/fbcode_builder/getdeps.py --no-facebook-internal --scratch-path ${SCRIPT_DIR}/scratch install-system-deps --recursive

./build/fbcode_builder/getdeps.py --no-facebook-internal --install-prefix ${INSTALL_DIR} --scratch-path ${SCRIPT_DIR}/scratch  --allow-system-packages build



cd ..
rm -rf ${CDEPS_ZIP_FILE}
cd $HOME/cdeps/${LIB_MODE}/${LIB_NAME}/
rm -rf ${CDEPS_ZIP_FILE}
zip -r ${CDEPS_ZIP_FILE} ${VERSION}
echo "${CDEPS_ZIP_FILE} packaging completed."
mv ${CDEPS_ZIP_FILE} "$SCRIPT_DIR/${CDEPS_ZIP_FILE}"
echo "Package moved to script directory: $SCRIPT_DIR/${CDEPS_ZIP_FILE}"
echo "${LIB_NAME} Build script completed successfully."


## https://github.com/facebook/folly

