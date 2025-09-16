#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_MODE=debug
LIB_NAME=sqlite
VERSION=3.50.4
INSTALL_DIR=$HOME/cdeps/${LIB_MODE}/${LIB_NAME}/${VERSION}
CDEPS_ZIP_FILE=cdeps_${LIB_NAME}_${VERSION}.zip
DOWNLOAD_FILE=sqlite-src-3500400.zip
DOWNLOAD_URL="https://sqlite.org/2025/sqlite-src-3500400.zip"
UNZIP_DIR=sqlite-src-3500400
uname -a
echo "Script directory: $SCRIPT_DIR"
echo "INSTALL directory: $INSTALL_DIR"
echo "CDEPS_ZIP_FILE: $CDEPS_ZIP_FILE"
echo "DOWNLOAD_URL: $DOWNLOAD_URL"
echo "UNZIP_DIR: $UNZIP_DIR"

rm -rf ${CDEPS_ZIP_FILE}

echo "Checking download file: ${DOWNLOAD_FILE}"
file_path="$SCRIPT_DIR/${DOWNLOAD_FILE}"
if [ -f "$file_path" ]; then
  echo "$file_path file already exists, skipping download."
else
  echo "$file_path not exist, try download file"
  rm -rf ${DOWNLOAD_FILE}
  curl -OL ${DOWNLOAD_URL}
fi
rm -rf UNZIP_DIR
echo "Extracting ${LIB_NAME} source code..."
tar -zxvf ${DOWNLOAD_FILE}
cd ${UNZIP_DIR}
rm -rf ${INSTALL_DIR}
mkdir -p ${INSTALL_DIR}
export CFLAGS="${CFLAGS} -g -O0 "
export CXXFLAGS="${CXXFLAGS} -g -O0 "
 ./configure --prefix=$INSTALL_DIR
 make -j12
 make install
 
cd ..
rm -rf ${CDEPS_ZIP_FILE}
cd $HOME/cdeps/${LIB_MODE}/${LIB_NAME}/
rm -rf ${CDEPS_ZIP_FILE}
zip -r ${CDEPS_ZIP_FILE} ${VERSION}
echo "${CDEPS_ZIP_FILE} packaging completed."
mv ${CDEPS_ZIP_FILE} "$SCRIPT_DIR/${CDEPS_ZIP_FILE}"
echo "Package moved to script directory: $SCRIPT_DIR/${CDEPS_ZIP_FILE}"

cd $SCRIPT_DIR
rm -rf $HOME/cdeps/src/${LIB_NAME}/${VERSION}/
mkdir -p $HOME/cdeps/src/${LIB_NAME}/${VERSION}/
mv ${UNZIP_DIR} $HOME/cdeps/src/${LIB_NAME}/${VERSION}/
echo "move compile source code to $HOME/cdeps/src/${LIB_NAME}/${VERSION}/ "
echo "you can recompile it later, in this folder $HOME/cdeps/src/${LIB_NAME}/${VERSION}/ "

echo "${LIB_NAME} Build script completed successfully."





