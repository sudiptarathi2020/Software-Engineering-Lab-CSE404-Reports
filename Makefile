# Makefile for compiling all .tex files in the directory structure

# Command to check for pdflatex
LATEX = pdflatex
LATEX_CHECK = $(shell command -v $(LATEX) 2>/dev/null)

# Install pdflatex if not found
check-latex:
ifndef LATEX_CHECK
	@echo "pdflatex is not installed. Installing..."
	@sudo apt-get update && sudo apt-get install -y texlive-latex-base
else
	@echo "pdflatex is already installed."
endif

# Find all .tex files in the directory structure
TEX_FILES := $(shell find . -type f -name '*.tex')

# Generate PDF files from .tex files
PDFS := $(TEX_FILES:.tex=.pdf)

# Rule to build all PDFs
all: check-latex $(PDFS)

# Rule for each PDF
%.pdf: %.tex	
	@echo "Compiling $< to $@ (1st pass)"
	@$(LATEX) -output-directory $(dir $<) $<
	@echo "Compiling $< to $@ (2nd pass)"
	@$(LATEX) -output-directory $(dir $<) $<

# Clean up all generated files
clean:
	@echo "Cleaning up..."
	@find . -type f -name '*.aux' -delete
	@find . -type f -name '*.log' -delete
	@find . -type f -name '*.pdf' -delete
	@find . -type f -name '*.out' -delete
	@find . -type f -name '*.toc' -delete
	@echo "Clean complete."

.PHONY: all clean check-latex
