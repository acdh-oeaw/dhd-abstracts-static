import glob
import os

from typesense.api_call import ObjectNotFound
from acdh_cfts_pyutils import TYPESENSE_CLIENT as client, CFTS_COLLECTION
from acdh_tei_pyutils.tei import TeiReader
from acdh_tei_pyutils.utils import (
    extract_fulltext,
    check_for_hash,
    get_xmlid,
    make_entity_label,
)
from tqdm import tqdm


files = glob.glob("./data/editions/*.xml")
tag_blacklist = ["{http://www.tei-c.org/ns/1.0}abbr"]

COLLECTION_NAME = "dhd-abstracts"


try:
    client.collections[COLLECTION_NAME].delete()
except ObjectNotFound:
    pass

current_schema = {
    "name": COLLECTION_NAME,
    "enable_nested_fields": True,
    "fields": [
        {"name": "id", "type": "string", "sort": True},
        {"name": "rec_id", "type": "string", "sort": True},
        {"name": "title", "type": "string", "sort": True},
        {"name": "full_text", "type": "string", "sort": True},
        {
            "name": "year",
            "type": "int32",
            "optional": True,
            "facet": True,
            "sort": True,
        },
        {
            "name": "category",
            "type": "string",
            "optional": True,
            "facet": True,
            "sort": True,
        },
        {
            "name": "subcategory",
            "type": "string",
            "optional": True,
            "facet": True,
            "sort": True,
        },
        {
            "name": "topics",
            "type": "string[]",
            "optional": True,
            "facet": True,
        },
        {
            "name": "keywords",
            "type": "string[]",
            "optional": True,
            "facet": True,
        },
    ],
}

client.collections.create(current_schema)
dates = set()
records = []
cfts_records = []
for x in tqdm(files, total=len(files)):
    record = {}

    doc = TeiReader(x)
    try:
        body = doc.any_xpath(".//tei:body")[0]
    except IndexError:
        continue
    doc_id = os.path.split(x)[-1].replace(".xml", "")
    record["id"] = os.path.split(x)[-1].replace(".xml", "")
    record["rec_id"] = os.path.split(x)[-1].replace(".xml", "")
    record["year"] = int(doc_id.split("-")[1])
    try:
        record["category"] = doc.any_xpath(".//tei:keywords[@n='category']/tei:term")[0].text
    except IndexError:
        pass
    try:
        record["subcategory"] = doc.any_xpath(".//tei:keywords[@n='subcategory']/tei:term")[0].text
    except IndexError:
        pass
    record["topics"] = []
    for x in doc.any_xpath(".//tei:keywords[@n='topics']/tei:term"):
        record["topics"].append(x.text)
    record["keywords"] = []
    for x in doc.any_xpath(".//tei:keywords[@n='keywords']/tei:term"):
        record["keywords"].append(x.text)
    record["title"] = extract_fulltext(
        doc.any_xpath(".//tei:titleStmt/tei:title[1]")[0]
    )

    record["full_text"] = extract_fulltext(body, tag_blacklist=tag_blacklist)
    records.append(record)

make_index = client.collections[COLLECTION_NAME].documents.import_(records)
print(make_index)
print(f"done with indexing {COLLECTION_NAME}")
