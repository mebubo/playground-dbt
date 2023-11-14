from pprint import pprint
import duckdb

def date_range(y1, m1, y2, m2) -> list[tuple[int, int]]:
    return [(y, m) for y in range(y1, y2+1) for m in range(1, 13) if (y, m) >= (y1, m1) and (y, m) < (y2, m2)]

# FHVHV_ALL = date_range(2019, 2, 2023, 9)
FHVHV_ALL = date_range(2019, 4, 2023, 9)

def urls() -> list[str]:
    return [ f"https://d37ci6vzurychx.cloudfront.net/trip-data/fhvhv_tripdata_{year}-{month:02d}.parquet" for year, month in FHVHV_ALL ]

def format_list(l: list[str]):
    quoted = [f"'{x}'" for x in l]
    return f"[{', '.join(quoted)}]"

def curl_script(urls: list[str]) -> str:
    cmds = [f"curl -LO -C - {url}" for url in urls]
    newline = "\n"
    return f"""#!/bin/bash
set -e

mkdir -p data
cd data

{newline.join(cmds)}
"""

def write_curl_script(name: str, urls: list[str]) -> None:
    with open(name, "w") as f:
        f.write(curl_script(urls))

sample_url = "https://d37ci6vzurychx.cloudfront.net/trip-data/fhvhv_tripdata_2020-01.parquet"

def load_data(urls: list[str]):
    connection = "./taxis/taxis.db"
    con = duckdb.connect(database=connection, read_only=False)
    con.execute(
        """
        create schema if not exists raw;
        create or replace table raw.taxis as (select * from read_parquet(?))
        """,
        [urls]
    )
    con.close()

if __name__ == '__main__':
    u = urls()
    pprint(u)
    # load_data(u)
    write_curl_script("dl.sh", u)
