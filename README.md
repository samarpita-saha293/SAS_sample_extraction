# SAS_UKB_GWAS

### Prerequisites:
- python3.11.4
- bcftools-1.18

dxpy module is loaded in python3.11.4

dx login
Acquiring credentials from https://auth.dnanexus.com
Username [samarpita_cbr]:
Password:

For extracting the detailed breakdown of UKB RAP expenses you can use the following command:

```
dx find jobs --project project-xxxx --created-after "2024-09-30" --json
```

In order to see more than last 10 jobs you can use parameter -n <number> to adjust how many jobs you would like to get returned. You can also see the help of the dx find jobs function by executing:

```
dx find jobs -h
```

Where you can find following section:
```
-n N, --num-results N
```
Max number of results (trees or jobs, as according to the search mode) to return (default 10)
Note: 
