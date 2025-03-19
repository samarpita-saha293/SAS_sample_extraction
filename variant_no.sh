#!/bin/bash

# List no. of variants in each chromosome

# Naming the Output file
output_file="Chr_#_variant_counts.txt"

# Clear the output file if it exists
> $output_file

# Loop through all VCF files in the directory
for i in {1..3000}; do

# Get the number of variants in chromosome 17
variant_count=$(bcftools view ukb24310_c#_b${i}_v1_SAS_8020.vcf.gz | grep -v -c '^#')

# Output the result to the file
echo "Block_$i: $variant_count" >> $output_file
done

#echo "Variant counts have been written to $output_file"
