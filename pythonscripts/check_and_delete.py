import glob
import os
from acdh_tei_pyutils.tei import TeiReader
from bs4 import BeautifulSoup
from tqdm import tqdm


print("remove broken files")
broken = []
files = sorted(glob.glob("./data/editions/*.xml"))
for x in tqdm(files):
    with open(x, 'r', encoding='utf-8') as file:
        soup = BeautifulSoup(file, 'xml')
        for tag in soup.find_all(True):
            if tag.has_attr('xml:id'):
                del tag['xml:id']
            if tag.has_attr('id'):
                del tag['id']
        for name in soup.find_all('author'):
            for direct_name in name.find_all('name', recursive=False):
                direct_name.name = 'persName'
    with open(x, 'w', encoding='utf-8') as output:
        output.write(str(soup))
    try:
        doc = TeiReader(x)
    except Exception as e:
        broken.append([x, e])
        os.remove(x)

if broken:
    for x in broken:
        print(x[0], x[1])
else:
    print("no broken files found")
print("file checks done")
