import glob
import os
import lxml.etree as ET
from acdh_tei_pyutils.tei import TeiReader
from acdh_tei_pyutils.utils import normalize_string
from tqdm import tqdm

print("harmonize titles")
files = sorted(glob.glob("./data/editions/*.xml"))

for x in tqdm(files, total=len(files)):
    doc = TeiReader(x)
    title = normalize_string(
        " ".join(doc.any_xpath(".//tei:titleStmt//tei:title//text()"))
    )
    for bad in doc.any_xpath(".//tei:titleStmt//tei:title"):
        bad.getparent().remove(bad)
    title_stmt = doc.any_xpath(".//tei:titleStmt")[0]
    new_title = ET.Element("{http://www.tei-c.org/ns/1.0}title")
    new_title.attrib["n"] = os.path.split(x)[-1].split("-")[1]
    new_title.text = title
    title_stmt.insert(0, new_title)
    doc.tree_to_file(x)
