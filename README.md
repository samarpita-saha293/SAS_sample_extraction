# SAS_UKB_GWAS

### Prerequisites:
python3.11.4
bcftools-1.18

dxpy module is loaded in python3.11.4

For extracting the detailed breakdown of UKB RAP expenses you can use the following command:

```
dx find jobs --project project-xxxx --created-after "2024-09-30" --json
```

In order to see more than last 10 jobs you can use parameter -n <number> to adjust how many jobs you would like to get returned. You can also see the help of the dx find jobs function by executing:

```
dx find jobs -h
```

Note: 
