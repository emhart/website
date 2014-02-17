
#usr/bin/bash

cd $1
rsync --compress --recursive --checksum --delete . emhartin@emhart.info:public_html
cd ..