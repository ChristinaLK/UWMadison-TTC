import sys
import csv
from pathlib import Path

if (len(sys.argv) < 2):
	print("Usage: python create_salary_csv.py <path_to_rawtext>")
	exit(1)
script = sys.argv[0]
file_src = sys.argv[1]

p = Path(file_src)
identifier = p.stem
data_path = p.parents[0]
outfile = data_path / "salary_ranges.csv"

def listify(src):
  data = []
  #open file
  f = open(src,'r')
  for line in f: 
    bucket = [line.split('$')[0].strip()]
    salary_range = line.split('$')[1].replace(',','').strip().split('–')
    bucket.extend(salary_range)
    data.append(bucket)
  f.close()
  return(data)

def write_csv_file(data_list, outfilepath):
  with open(outfilepath, 'w', newline='') as csvfile:
    filewriter = csv.writer(csvfile, delimiter=',',
                            quotechar='|', quoting=csv.QUOTE_MINIMAL)
    for row in data_list:
      filewriter.writerow(row)

def main():
  listified_data = listify(file_src)
  write_csv_file(listified_data, outfile)

main()
