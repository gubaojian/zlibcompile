#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
file_path="$SCRIPT_DIR/lmdb"
if [ -d "$file_path" ]; then
  echo "$file_path file already exists, skipping clone."
else
  echo "$file_path not exist, try clone file"
  git clone https://github.com/LMDB/lmdb.git
fi

