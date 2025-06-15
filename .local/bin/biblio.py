#!/usr/bin/env python3

import fitz  # PyMuPDF
import sys

def extract_bibliography(pdf_path):
    # Open the PDF
    doc = fitz.open(pdf_path)
    
    full_text = ""
    for page in doc:
        full_text += page.get_text()

    # Normalize text for consistent matching
    normalized_text = full_text.lower()

    # Try to locate common bibliography headers
    bib_headers = ['references', 'bibliography', 'literature cited', 'works cited']
    start_index = -1

    for header in bib_headers:
        index = normalized_text.find(header)
        if index != -1:
            start_index = index
            break

    if start_index == -1:
        print("❌ Bibliography section not found.")
        return

    # Extract bibliography section
    bibliography = full_text[start_index:]
    
    # Optional: truncate at the end if there's an appendix or acknowledgments
    for end_marker in ['appendix', 'acknowledgments', 'about the authors']:
        end_idx = bibliography.lower().find(end_marker)
        if end_idx != -1:
            bibliography = bibliography[:end_idx]
            break

    print("✅ Bibliography section extracted:")
    print("-" * 40)
    print(bibliography.strip())

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python extract_bibliography.py <paper.pdf>")
    else:
        extract_bibliography(sys.argv[1])

