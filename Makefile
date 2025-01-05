# Makefile for compiling all .tex files in the directory structure

# Command to use for pdflatex
LATEX = pdflatex

# Find all .tex files in the directory structure
TEX_FILES := $(shell find . -type f -name '*.tex')


# Command to use for combining PDFs
PDFUNITE = pdfunite

# Generate PDF files from .tex files
PDFS := $(TEX_FILES:.tex=.pdf)

# Rule to build all PDFs
all: $(PDFS)

# Rule for each PDF
%.pdf: %.tex	
	@echo "Compiling $< to $@ (1st pass)"
	@$(LATEX) -output-directory $(dir $<) $<
	@echo "Compiling $< to $@ (2nd pass)"
	@$(LATEX) -output-directory $(dir $<) $<

# Combine all generated PDFs into a single file
combine: $(PDFS)
	@echo "Combining all PDFs into combined_output.pdf"
	@$(PDFUNITE) $(PDFS) combined_output.pdf
	@echo "Combined PDF created: combined_output.pdf"

# Clean up all generated files
clean:
	@echo "Cleaning up..."
	@find . -type f -name '*.aux' -delete
	@find . -type f -name '*.log' -delete
	@find . -type f -name '*.out' -delete
	@find . -type f -name '*.toc' -delete
	@echo "Clean complete."

.PHONY: all clean
