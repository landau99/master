install.packages("pdftools")
install.packages("writexl")

library(pdftools)
library(writexl)

# Read the PDF file
text <- pdf_text('/Users/landau/Downloads/Humberstone, Paul - Mot à mot_ new advanced french vocabulary (2010) - libgen.li.pdf')

french_words <- c()
english_words <- c()

pattern <- "\\s{2,}"

# Iterate through each page in the PDF
for (page in text) {
  # Split the text into lines
  lines <- strsplit(page, split = "\n")[[1]]
  
  # Iterate through each line
  for (line in lines) {
    # Split the line into French and English parts
    parts <- strsplit(line, pattern)[[1]]
    # Check if both parts exist
    if (length(parts) == 2) {
      french_words <- c(french_words, parts[1])
      english_words <- c(english_words, parts[2])
    }
  }
}

# Create a data frame from the lists
df <- data.frame(French = french_words, English = english_words)

# Remove rows with blank values in any column
df <- df[apply(df != "", 1, all), ]

# Write the data frame to an Excel file
  write_xlsx(df, 'translations.xlsx')
