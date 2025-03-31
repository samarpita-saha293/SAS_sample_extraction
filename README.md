# SAS_sample_extraction

This GitHub repository provides tutorials and scripts used to analyze population-level genotype data on UK Biobank Research Analysis Platform. For our study we have extracted variant information from WGS data (UKB Data-Field 24310) of 8020 participants belonging to Indian, Pakistani and Bangladeshi populations. The ethnic backgrounds of these Individuals are self-claimed and this information has been collected via a set of questions from a questionnaire. 

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

## STEP 1: SAS sample extraction

For the variant extraction from DNAnexus platform we have used Swiss Army Knife (v4.13.0). BCFtools was accessed using Swiss-Army-Knife for SAS sample extractions. Provided below is the command used:

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
-	**-iin** is used to specify the input. For the input we have .vcf.gz files from data-field 24310 (Bulk/DRAGEN WGS/DRAGEN population level WGS variants, pVCF format [500k release]). Along with the .vcf.gz files we have taken the SampleIDs.txt file which comprises of sample IDs of Indian, Pakistani and Bangladeshi Individuals.
-	**-icmd** is used to specify the BCFtools command, where we have used the flags –force-samples, -Oz and -o (Refer to the BCFtools Manual: samtools.github.io/bcftools/bcftools.html).
-	**--tag** is used to assign your job name or category.
-	**--priority** is set to normal.
-	**--instance-type** specifies memory and storage capacity (per core), version denotes the version of the instance-type, and core denotes the no. of cores to be used. The instance type used for our jobs is mem1_ssd1_v2_x8, which has an estimated cost of £0.0780 or £0.1448 per hour per job (Refer to https://documentation.dnanexus.com/developer/api/running-analyses/instance-types).
-	**--destination** is used to specify the destination of output files.

For iterating this command for each block of each chromosome use [UKB_SAS_extract_SS.sh](UKB_SAS_extract_SS.sh) script along with the [prompt_SS.expect](prompt_SS.expect) script. Also, make sure [SAS_8020_500k_sampleIDS.csv](SAS_8020_500k_sampleIDS.csv) is in /Cohorts/SAS_WGS_500k/ directory on the RAP platform. [SAS_8020_500k_sampleIDS.csv](SAS_8020_500k_sampleIDS.csv) comprises of the Sample IDs of the 8020 participants from the UKB 500k Release. The [prompt_SS.expect](prompt_SS.expect) script answers to the prompts generated with the dx command.

## STEP 2: Download extracted data

First cd to the output directory on UKB RAP and then download the blocks of .vcf.gz using these commands with the help of a bash script iterating over each block in a chromosome.
```
dx cd /Cohorts/BCFtools_SAS_extract/Chr_#

dx download ukb24310_c#_b$_v1_SAS_8020.vcf.gz
```

## STEP 3: Verify the Number of Variants in the downloaded files

Use [variant_no.sh](variant_no.sh) for calculating the no. of variants in each block before concatenation of the blocks of each chromosome. Verify the contents of the empty blocks using [verify.sh](verify.sh).

NOTE: Place the download script, [variant_no.sh](variant_no.sh) and [verify.sh](verify.sh) inside the UKB_data/Chr_# directory.

## STEP 4: Concatenation, Count total no. of Variants and Quality Checking

"bcftools concat" was used to concatenate the blocks in a sequential order. Also, The total no. of variants were calculated using the below mentioned command:

```
bcftools view ukb24310_c14_concat.vcf.gz | grep -v -c '^#'
```
Once the concatenation is done, we extracted the data for the GQ and QL scores across all variants for all samples in a given chromosome using bcftools and awk.

## STEP 5: VCF Normalization and generating Plink format files

Normalization is done to split records into biallelic sites, retaining both REF and ALT alleles. The -both flag used along with -m ensures that it retains all annotations. The normalized data is further indexed.

```
bcftools norm -m -both ukb24310_c#_concat.vcf.gz -Oz -o ukb24310_c#_norm.vcf.gz --threads ##

bcftools index ukb24310_c#_norm.vcf.gz
```  
Furthermore, the normalized .vcf.gz files are used for producing plink format files using PLINK 2.0. 

```
plink2 --vcf ukb24310_c#_norm.vcf.gz --keep SAS_sampleIDs --make-bed --out ukb24310_c#_SAS
```
