## Detailed breakdown of UKB RAP expenses

In order to estimate the actual computing charges for the jobs of specific project executed from the last invoice, you can use the following command (the user executing this command needs to have at least CONTRIBUTOR access to the project):

```
dx find jobs --project project-xxxx --created-after "2024-09-30" --json > UKB_exp_report
```

Here, you need to specify the project-ID and the date when your last invoice was issued and this will give you the json output, where you can refer to the ".totalPrice" record showing the price of individual jobs.

In order to see more than last 10 jobs you can use parameter -n <number> to adjust for the number of jobs you would like to get returned. You can also see the help of the dx find jobs function by executing:

```
dx find jobs -h
```

Where you can find following section:
```
-n N, --num-results N
```
Max number of results (trees or jobs, as according to the search mode) to return (default 10)

Note: (again the user running that script will need at least CONTRIBUTOR access to the projects and has to be ADMIN of the org). Inside a script you can change the date of the last invoice defined by variable "CREATED_AFTER" and the date has to be in format YYYY-MM-DD. Please feel free to upgrade and use the script as you wish.

