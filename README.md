# SAS_sample_extraction

This GitHub repository provides tutorials and scripts used to analyze population-level genotype data on UK Biobank Research Analysis Platform. For our study we have extracted variant information from WGS data (UKB Data-Field 24310) of 8024 participants belonging to Indian, Pakistani and Bangladeshi populations.

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

## Details about the extracted data from UKB RAP

Below mentioned is the path of the storage system, you cannot ssh into this system, however the content can be viewed and accessed using nfs-share (via linux OS) or smb-share (via windows OS).
```
10.10.13.240:/bklab
```
Also, the path to lab storage server is mounted on our lab system. To ssh or scp you can use via the lab system with ip address 10.10.25.160 and cd to the path:
```
/mnt/nfsshare/samarpita/
```

## Directory Structure of UKB_data
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


