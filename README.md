# SAS_sample_extraction

This GitHub repository provides tutorials and scripts used to analyze population-level genotype data on UK Biobank Research Analysis Platform. For our study we have extracted variant information from WGS data (UKB Data-Field 24310) of 8024 individuals from to Indian, Pakistani and Bangladeshi populations.

## Preprocessing workflow

![Screenshot (190)](https://github.com/user-attachments/assets/26433718-8c7d-4a11-8d29-c8bcb4be0b9b)

### Prerequisites
- python3.11.4
- bcftools-1.18

The DNAnexus dxpy Python library offers Python bindings for interacting with the DNAnexus Platform through its API. The dxpy module is loaded in python3.11.4 on the HPC.

Before working on the project you need to login to your project account using your DNAnexus account credentials
```
dx login
```
Your credentials will be acquired from https://auth.dnanexus.com. While logging in you will be asked to choose from the list of available projects to work on.

Use dx login --timeout to control the expiration date, or dx logout to end this session.

Moreover, for the variant extraction from DNAnexus platform we have used Swiss Army Knife (v4.13.0). BCFtools was accessed using Swiss-Army-Knife for SAS sample extractions. Provided below is the breakdown of the command used:

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
For iterating this command for each chromosome use UKB_SAS_extract_SS.sh

## Details about the extracted data from UKB RAP

Below mentioned is the path of the storage system, you cannot ssh into this system, however the content can be viewed and accessed using nfs-share (via linux OS) or smb-share (via windows OS).
```
10.10.13.240:/bklab
```
Also, the path to lab storage server is mounted on our lab system. To ssh or scp you can use via the lab system with ip address 10.10.25.160 and cd to the path:
```
/mnt/nfsshare/samarpita/
```

### Directory Structure of UKB_data
```
UKB_data
|
|___ Chr_1/
|	|__ ukb24310_c1_b1_v1_SAS_8020.vcf.gz
|	|__ …
|	|__ ukb24310_c1_b12448_v1_SAS_8020.vcf.gz
|___ …
   	| 
|___ Chr_22/
   	|
	|___ concat/
	|	|__ ukb24310_c1_concat.vcf.gz
	|	|__ …
	|	|__ ukb24310_c22_concat.vcf.gz
	|
	|___ norm/
	|	|__ ukb24310_c1_norm.vcf.gz
	|	|__ ukb24310_c1_norm.vcf.gz.csi
	|	|__ …
	|	|__ …
	|	|__ ukb24310_c22_norm.vcf.gz
	|	|__ ukb24310_c22_norm.vcf.gz.csi
	|
	|___ B_files/
	|	|__ukb24310_c1_SAS_8020.bed
	|	|__ukb24310_c1_SAS_8020.bim
	|	|__ukb24310_c1_SAS_8020.fam
	|	|__ …	
	|
	|___ variant_count/
		|__ Chr_1_variant_counts.txt
		|__ …
		|__ Chr_22_variant_counts.txt
```


