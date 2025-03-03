# Set the date as the current date in the format YYYY-MM-DD
DATE := $(shell date +'%Y-%m-%d')

# Define the PDF target name with the date appended
PDF_TARGET = vestnik_$(DATE)

# Define the build directory
BUILD_DIR = build

# Define the full path to the PDF file
PDF_FILE := $(BUILD_DIR)/$(PDF_TARGET).pdf

.PHONY: pdf clean

# Define the pdf target rule
pdf: $(PDF_FILE)

# Rule to generate the PDF
$(PDF_FILE): src/main.tex
	latexmk -xelatex -pvc -view=pdf -time -output-directory=$(BUILD_DIR) -jobname=$(PDF_TARGET) src/main.tex

# Clean the build directory
clean:
	latexmk -C src/main.tex
	rm -rf $(BUILD_DIR)/*
