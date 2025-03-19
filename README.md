# SAS_sample_extraction

This GitHub repository provides tutorials and scripts used to analyze population-level genotype data on UK Biobank Research Analysis Platform. For our study we have extracted variant information from WGS data (UKB Data-Field 24310) of 8020 participants belonging to Indian, Pakistani and Bangladeshi populations. The ethnic backgrounds of these Individuals are self-claimed and this information has been collected via a set of questions from a questionnaire (https://biobank.ndph.ox.ac.uk/showcase/refer.cgi?id=807). 

## Preprocessing workflow

![Screenshot (191)](https://github.com/user-attachments/assets/9c3feb00-287e-475a-8e05-3668ebf40082)

### Prerequisites

- Python 3.8 or higher
- bcftools

The DNAnexus dxpy Python library offers Python bindings for interacting with the DNAnexus Platform through its API. The dxpy package, part of the DNAnexus platform SDK, requires Python 3.8 or higher. We used python3.11.4 module and bcftools-1.18 on the Institute's HPC system.

Before working on the project you need to login to your project account using your DNAnexus account credentials
```
dx login
```
Your credentials will be acquired from https://auth.dnanexus.com. While logging in you will be asked to choose from the list of available projects to work on.

Use dx login --timeout to control the expiration date, or dx logout to end this session.

for the variant extraction from DNAnexus platform we have used Swiss Army Knife (v4.13.0). BCFtools was accessed using Swiss-Army-Knife for SAS sample extractions. Provided below is the breakdown of the command used:

```
dx run swiss-army-knife \
-iin="/Bulk/DRAGEN WGS/DRAGEN population level WGS variants, pVCF format [500k release]/chr#/ukb24310_c#_b$_v1.vcf.gz" \
-iin="/Cohorts/SAS_WGS_500k/SAS_sampleIDs.txt" \
-icmd="bcftools view -S SAS_sampleIDs.txt ukb24310_c#_b$_v1.vcf.gz --force-samples -Oz -o ukb24310_c#_b$_v1_SAS_8020.vcf.gz" \ 
--tag="bcftools_view" \
--priority="normal" \
--instance-type="mem1_ssd1_v2_x8" \
--destination="/Cohorts/BCFtools_SAS_extract/Chr_#"
```

### Components of the command: 
•	-iin is used to specify the input. For the input we have .vcf.gz files from data-field 24310 (Bulk/DRAGEN WGS/DRAGEN population level WGS variants, pVCF format [500k release]). Along with the .vcf.gz files we have taken the SampleIDs.txt file which comprises of sample IDs of Indian, Pakistani and Bangladeshi Individuals.
•	-icmd is used to specify the BCFtools command, where we have used the flags –force-samples, -Oz and -o (Refer to the BCFtools Manual: samtools.github.io/bcftools/bcftools.html).
•	--tag is used to assign your job name or category.
•	--priority is set to normal.
•	--instance-type specifies is used to specify memory and storage capacity (per core), version denotes the version of the instance-type, and core denotes the no. of cores to be used. The instance type used for our jobs is mem1_ssd1_v2_x8, which has an estimated cost of £0.0780 or £0.1448 per hour per job (Refer to https://documentation.dnanexus.com/developer/api/running-analyses/instance-types).
•	--destination is used to specify the destination of output files.

For iterating this command for each chromosome use UKB_SAS_extract_SS.sh script. Also, make sure SAS_500k_sampleIDS.csv is in the same directory as and the bash script. SAS_500k_sampleIDS.csv comprises of the Sample IDs of the 8020 participants.

