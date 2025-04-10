#!/bin/bash 
rm -rf build
python parser.py
echo "yes" >> build/somefile.html
python -m http.server --directory build

