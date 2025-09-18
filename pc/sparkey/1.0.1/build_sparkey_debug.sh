#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_MODE=debug
LIB_NAME=sparkey
VERSION=1.1.10
INSTALL_DIR=$HOME/cdeps/${LIB_MODE}/${LIB_NAME}/${VERSION}
CDEPS_ZIP_FILE=cdeps_${LIB_NAME}_${VERSION}.zip
UNZIP_DIR=sparkey
uname -a
eecho "Script directory: $SCRIPT_DIR"
echo "INSTALL directory: $INSTALL_DIR"
echo "CDEPS_ZIP_FILE: $CDEPS_ZIP_FILE"
echo "UNZIP_DIR: $UNZIP_DIR"

rm -rf ${CDEPS_ZIP_FILE}
rm -rf ${INSTALL_DIR}
mkdir -p ${INSTALL_DIR}


cd ${UNZIP_DIR}

## or see /opt/homebrew/Cellar/snappy/1.2.2
export CFLAGS="${CFLAGS} -g -O0  -Wall -Wno-error -Wno-strict-prototypes -I/opt/homebrew/include "
export CXXFLAGS="${CXXFLAGS} -g -O0 -Wall -Wno-error -Wno-strict-prototypes -I/opt/homebrew/include "
export LDFLAGS="${LDFLAGS} -L/opt/homebrew/lib"

autoreconf --install
 ./configure  --prefix=$INSTALL_DIR

 make -j12 CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}"
 make install


cd ..
rm -rf ${CDEPS_ZIP_FILE}
cd $HOME/cdeps/${LIB_MODE}/${LIB_NAME}/
rm -rf ${CDEPS_ZIP_FILE}
zip -r ${CDEPS_ZIP_FILE} ${VERSION}
echo "${CDEPS_ZIP_FILE} packaging completed."
mv ${CDEPS_ZIP_FILE} "$SCRIPT_DIR/${CDEPS_ZIP_FILE}"
echo "Package moved to script directory: $SCRIPT_DIR/${CDEPS_ZIP_FILE}"
echo "${LIB_NAME} Build script completed successfully."





