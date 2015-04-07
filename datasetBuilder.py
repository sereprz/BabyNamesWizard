import glob
import sys
import csv

path = sys.argv[1] + "/*.txt"
all = []

for fname in glob.glob(path):
	with open(fname, 'r') as inputfile:
		f_csv = csv.reader(inputfile)
		yob = fname[-8:-4]
		for row in f_csv:
			row.insert(0, yob)
			all.append(row)
			
with open('namesDataset.csv', 'w') as outputfile:
	writer = csv.writer(outputfile, lineterminator = '\n')
	writer.writerows(all)