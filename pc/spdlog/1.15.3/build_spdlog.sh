#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_MODE=release
LIB_NAME=spdlog
VERSION=1.15.3
INSTALL_DIR=$HOME/cdeps/${LIB_MODE}/${LIB_NAME}/${VERSION}
CDEPS_ZIP_FILE=cdeps_${LIB_NAME}_${VERSION}.zip
DOWNLOAD_FILE=v${VERSION}.tar.gz
DOWNLOAD_URL="https://github.com/gabime/spdlog/archive/refs/tags/v${VERSION}.tar.gz"
UNZIP_DIR=${LIB_NAME}-${VERSION}
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
rm -rf ${UNZIP_DIR}
echo "Extracting ${LIB_NAME} source code to ${UNZIP_DIR} ..."
tar -zxvf ${DOWNLOAD_FILE}
cd ${UNZIP_DIR}
rm -rf ${INSTALL_DIR}
mkdir -p ${INSTALL_DIR}
export CFLAGS="${CFLAGS} -O3 "
export CXXFLAGS="${CXXFLAGS} -O3 "

##  -DBUILD_TESTING=OFF
 mkdir build
 cd build
 cmake  -DCMAKE_BUILD_TYPE=Release -DSPDLOG_BUILD_EXAMPLE=OFF -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR  ..
 make -j4
 make install
 cd ..

cd ..
rm -rf ${CDEPS_ZIP_FILE}
cd $HOME/cdeps/${LIB_MODE}/${LIB_NAME}/
rm -rf ${CDEPS_ZIP_FILE}
zip -r ${CDEPS_ZIP_FILE} ${VERSION}
echo "${CDEPS_ZIP_FILE} packaging completed."
mv ${CDEPS_ZIP_FILE} "$SCRIPT_DIR/${CDEPS_ZIP_FILE}"
echo "Package moved to script directory: $SCRIPT_DIR/${CDEPS_ZIP_FILE}"
echo "${LIB_NAME} Build script completed successfully."


## https://github.com/ashvardanian/fork_union

