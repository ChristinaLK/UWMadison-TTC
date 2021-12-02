#!/bin/bash

# convert raw xlsx file to csv
python3 scripts/xls_to_csv.py data/All\ Faculty\ and\ Staff\ Title\ and\ Salary\ Information\ -\ Post-TTC\ and\ Pre-TTC.xlsx
# convert hand copied salary ranges to CSV file
python3 scripts/create_salary_csv.py data/salary_ranges_raw.txt
