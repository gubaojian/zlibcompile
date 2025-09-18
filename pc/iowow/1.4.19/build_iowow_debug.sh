#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_MODE=debug
LIB_NAME=iowow
VERSION=1.1.10
INSTALL_DIR=$HOME/cdeps/${LIB_MODE}/${LIB_NAME}/${VERSION}
CDEPS_ZIP_FILE=cdeps_${LIB_NAME}_${VERSION}.zip
UNZIP_DIR=iowow
uname -a
echo "Script directory: $SCRIPT_DIR"
echo "INSTALL directory: $INSTALL_DIR"
echo "CDEPS_ZIP_FILE: $CDEPS_ZIP_FILE"
echo "UNZIP_DIR: $UNZIP_DIR"

rm -rf ${CDEPS_ZIP_FILE}
rm -rf ${INSTALL_DIR}
mkdir -p ${INSTALL_DIR}


cd ${UNZIP_DIR}



export CFLAGS="${CFLAGS} -g -O0 "
export CXXFLAGS="${CXXFLAGS} -g -O0 "


export BUILD_TYPE=Debug
export IOWOW_RUN_TESTS=0
make clean
./build.sh
./build.sh --prefix=${INSTALL_DIR}
 

cd ..
rm -rf ${CDEPS_ZIP_FILE}
cd $HOME/cdeps/${LIB_MODE}/${LIB_NAME}/
rm -rf ${CDEPS_ZIP_FILE}
zip -r ${CDEPS_ZIP_FILE} ${VERSION}
echo "${CDEPS_ZIP_FILE} packaging completed."
mv ${CDEPS_ZIP_FILE} "$SCRIPT_DIR/${CDEPS_ZIP_FILE}"
echo "Package moved to script directory: $SCRIPT_DIR/${CDEPS_ZIP_FILE}"
echo "${LIB_NAME} Build script completed successfully."


