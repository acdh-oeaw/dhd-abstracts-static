# bin/bash

echo "fetching transkriptions from data_repo"
rm -rf data/
curl -LO https://github.com/acdh-oeaw/dhd-abstracts-data/archive/refs/heads/main.zip
unzip main

mv ./dhd-abstracts-data-main/data/ .

rm main.zip
rm -rf ./dhd-abstracts-data-main

echo "fetch imprint"
./shellscripts/dl_imprint.sh

python pythonscripts/check_and_delete.py
add-attributes -g "./data/editions/*.xml" -b "https://dhd-abstracts.acdh.oeaw.ac.at"
add-attributes -g "./data/meta/*.xml" -b "https://dhd-abstracts.acdh.oeaw.ac.at"
python pythonscripts/harmonize_title.py
