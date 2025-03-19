# SAS_sample_extraction

This GitHub repository provides tutorials and scripts used to analyze population-level genotype data on UK Biobank Research Analysis Platform. For our study we have extracted variant information from WGS data (UKB Data-Field 24310) of 8024 participants belonging to Indian, Pakistani and Bangladeshi populations. Another point to note is that these ethnic backgrounds of the Individuals are self-claimed, this information has been collected via a set of questions from a questionnaire (https://biobank.ndph.ox.ac.uk/showcase/refer.cgi?id=807). 

## Preprocessing workflow

![Screenshot (190)](https://github.com/user-attachments/assets/26433718-8c7d-4a11-8d29-c8bcb4be0b9b)

### Prerequisites
- python3.11.4
- bcftools-1.18

dxpy module is loaded in python3.11.4

Before working on the project you need to login to your project account using your DNAnexus account credentials
```
dx login
```
Your credentials will be acquired from https://auth.dnanexus.com . While logging in you will be asked to choose from the list of available projects to work on.

Use dx login --timeout to control the expiration date, or dx logout to end this session.

