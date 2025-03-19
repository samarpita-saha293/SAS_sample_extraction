#!/bin/bash

# Define the output text file
output_file="verify_Chr#.txt"

# Clear the output file if it exists
> "$output_file"

# Loop through the specified range of files
for i in {1..1200}; do
  # Define the VCF file name for the current iteration
  vcf_file="ukb24310_c#_b${i}_v1_SAS_8020.vcf.gz"

  # Check if the file exists
  if [[ -f "$vcf_file" ]]; then
    # Append a header indicating the current file being processed
    echo "Processing $vcf_file" >> "$output_file"

    # Run the command and append the result to the output file
    zgrep -v "##" "$vcf_file" | cut -f 1,2,3,8,9 | head >> "$output_file"

    # Append a blank line to separate outputs
    echo "" >> "$output_file"
  else
    echo "File $vcf_file does not exist" >> "$output_file"
  fi
done

echo "The result has been written to $output_file"

