
# ----------------------------extract the .rar file if downloaded from website-------------------------------
# if you are using the dataset directly from this folder, ignore this chunk

# in Terminal

# brew install unar                                               --if not installed

# unar -o /path/to/extract/folder/ /path/to/yourfile.rar          -- extract .rar file to selected folder
# ex: unar -o /Users/zianshang/Downloads/chronic+kidney+disease /Users/zianshang/Downloads/chronic+kidney+disease/Chronic_Kidney_Disease.rar

# ls /path/to/extract/folder/                                     --check whether extraction is successful
# ex: /Users/zianshang/Downloads/chronic+kidney+disease



# ----------------------------Extract Info from .aff file-------------------------------
# if you are using the dataset directly from this folder, ignore this chunk

# ** NOTE: I used file "chronic_kidney_disease.arff" **
# ** chronic_kidney_disease_full.arff is also fine, but one need to make sure the extracted data is correct **

# change to your own file path
file_path <- "/Users/zianshang/Downloads/chronic+kidney+disease/Chronic_Kidney_Disease/chronic_kidney_disease.arff"
lines <- readLines(file_path)

data_start <- which(grepl("^@data", lines, ignore.case = TRUE)) + 2
data_lines <- lines[data_start:length(lines)-1]
data_lines



# ----------------------------debug: there is 1 row with 26 values----------------------------
# if you are using the dataset directly from this folder, ignore this chunk

row_lengths <- sapply(strsplit(data_lines, ","), length)
row_lengths
table(row_lengths)  # 399 rows with 25 values, 1 row with 26 values, 1 row with 1 value

which(row_lengths == 26)       # row 371
data_lines[371]
data_lines[372]
data_lines[373]
# there is an extra "," in row 371, I have deleted it in both .arff files I uploaded. 
# If you downloaded the dataset from the website, look for "no,,no" in file "chronic_kidney_disease.arff" & delete 1 comma


# match with the file, check
data_lines[1]
# "48,80,1.020,1,0,?,normal,notpresent,notpresent,121,36,1.2,?,?,15.4,44,7800,5.2,yes,yes,no,good,no,no,ckd"
data_lines[length(data_lines)]
# "58,80,1.025,0,0,normal,normal,notpresent,notpresent,131,18,1.1,141,3.5,15.8,53,6800,6.1,no,no,no,good,no,no,notckd"



# ----------------------------convert lines to a dataframe----------------------------

data <- read.table(text = data_lines, sep = ",", header = FALSE, stringsAsFactors = FALSE, na.strings = "?")

# check data--has no column names
head(data)
dim(data)



# ----------------------------look for column names----------------------------

# get lines that start with "@attribute"
attribute_lines <- grep("^@attribute", lines, value = TRUE)
# attribute_lines

# Extract col names in between ''
column_names <- gsub("^@attribute '([^']+)'.*", "\\1", attribute_lines)
column_names
length(column_names)

# assign column names to data
colnames(data) <- column_names

# check data
head(data)
View(data)








