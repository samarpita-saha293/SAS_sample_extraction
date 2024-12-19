#!/bin/bash

#define variables
ORG="org-ukb_wallet_fe353e8c4c0"
CREATED_AFTER="2024-07-25"
PROJECT_COSTS=()
COSTS_REPORT=computing_costs_report.txt

#list all projects within the specified org
PROJECT_LIST=$(dx find org projects ${ORG} --brief)
#initialize costs_report.txt file
printf "Computing costs report\n\n\n" > ${COSTS_REPORT}
printf "Computing costs of jobs for org %s created afted %s \n\n\n" ${ORG} ${CREATED_AFTER} >> ${COSTS_REPORT}

#loop over all projects within an org and retrieve the total price of all jobs within the project
for PROJECT in ${PROJECT_LIST}
do
TOTAL_PRICE=$(dx find jobs --project ${PROJECT} --created-after ${CREATED_AFTER} --json | jq 'map(.totalPrice) | add')
PROJECT_NAME=$(dx describe ${PROJECT} --json | jq '.name')
printf "Computing costs of %s with name %s : %s \n" "${PROJECT}" "${PROJECT_NAME}" "${TOTAL_PRICE}" >> ${COSTS_REPORT}
PROJECT_COSTS+=( ${TOTAL_PRICE} )
done

#make a sum of all computing charges for all jobs across all projects within an org
SUM=$( IFS="+"; bc <<< "${PROJECT_COSTS[*]}" )
printf "Total computing costs are %s\n\n\n" ${SUM} >> ${COSTS_REPORT}
