## LIBRARIES

import sys
import pandas
from pathlib import Path

## GLOBAL VARIABLES

if (len(sys.argv) < 2):
	print("Usage: python xls_v2.py <path_to_xls>")
	exit(1)
script = sys.argv[0]
file_src = sys.argv[1]
#file_out = sys.argv[2]

p = Path(file_src)
identifier = p.stem
data_path = p.parents[0]

sheets = {
  "Post-Nov.7, 2021 (Post-TTC)":"TTC_All_FacultyStaff.csv",
  "Pre-Nov. 7, 2021 (Pre-TTC)":"PreTTC_All_FacultyStaff.csv"}

## FUNCTIONS

def convert(src, sh, fout):
	data_xls = pandas.read_excel(src, sheet_name=sh, index_col=None, header=0)
	file_dest = data_path / fout
	data_xls.to_csv(str(file_dest), index=False)

## MAIN

def main():
  for sheet in sheets:
    convert(file_src, sheet, sheets[sheet])

main()
