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



