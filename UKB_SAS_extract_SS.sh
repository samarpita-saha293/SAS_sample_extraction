#!/bin/bash

# Look into the README section to understand the input parameters
vcf_directory="/Bulk/DRAGEN WGS/DRAGEN population level WGS variants, pVCF format [500k release]/chr#/"
output_directory="/Cohorts/BCFtools_SAS_extract/Chr_#"
SAS_sample="/Cohorts/SAS_WGS_500k/SAS_sampleIDs.txt"
tag="bcftools_view"
instance_type="mem1_ssd1_v2_x8"
job_priority="normal"

# In the for loop you are to mention the total no. of bins in the chromosome you are working with (take reference from my report)
for i in {1..3099}; do
    # Construct the file paths
    vcf_file="${vcf_directory}ukb24310_c#_b${i}_v1.vcf.gz"
    output_file="${output_directory}/ukb24310_c#_b${i}_v1_SAS_8020.vcf.gz"

    # Constructing the BCFtools command
    bcftools_cmd="bcftools view -S SAS_sampleIDs.txt ukb24310_c#_b${i}_v1.vcf.gz --force-samples -Oz -o ukb24310_c#_b${i}_v1_SAS_8020.vcf.gz"

    # Constructing the dx command with multiple -iin arguments for the input files taken from UKB Bulk data and Sample Ids from Cohorts folder from the RAP platform.
    dx_command="dx run swiss-army-knife -iin=\"$vcf_file\" -iin=\"$SAS_sample\" -icmd=\"$bcftools_cmd\" --tag=\"$tag\" --priority=\"$job_priority\" --instance-type=\"$instance_type\" --destination=\"$output_directory\""

    # Printing the dx command for debugging purposes
    echo "$dx_command"

    # Executing the dx command with expect script to handle prompts
    eval "$dx_command"

    # The timer for the iteration of commands in set to 1 min 
    sleep 45

done

# Wait for all background jobs to complete
wait

# Print confirmation message
echo "All jobs completed. SAS samples extracted successfully."

