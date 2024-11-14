#!/bin/bash
ODTP_USER_EMAIL=test@email.com
DT_PATH=$(pwd)
PARAMETERS_PATH=parameters
SECRETS_PATH=secrets

DIGITAL_TWIN_NAME=dt-corsica
EXECUTION_NAME=corsica-execution-1

mkdir -p ${DT_PATH}/${DIGITAL_TWIN_NAME}/${EXECUTION_NAME}

# Pulling all the components and versions
odtp new odtp-component-entry \
--name odtp-eqasim-dataloader \
--component-version v0.4.0 \
--repository https://github.com/odtp-org/odtp-eqasim-dataloader

odtp new odtp-component-entry \
--name odtp-eqasim \
--component-version v0.4.6 \
--repository https://github.com/odtp-org/odtp-eqasim.git

odtp new odtp-component-entry \
--name odtp-eqasim-matsim \
--component-version v0.1.6 \
--repository https://github.com/odtp-org/odtp-eqasim-matsim

odtp new odtp-component-entry \
--name odtp-travel-data-dashboard \
--component-version v0.1.6 \
--repository https://github.com/odtp-org/odtp-travel-data-dashboard

# Creating new digital twin
odtp new digital-twin-entry \
--user-email ${ODTP_USER_EMAIL}  \
--name ${DIGITAL_TWIN_NAME}

# Creating new execution
odtp new execution-entry \
--name ${EXECUTION_NAME} \
--digital-twin-name ${DIGITAL_TWIN_NAME} \
--component-tags odtp-eqasim-dataloader:v0.4.0,odtp-eqasim:v0.4.6,odtp-eqasim-matsim:v0.1.6,odtp-travel-data-dashboard:v0.1.6 \
--parameter-files ${PARAMETERS_PATH}/001.parameters,${PARAMETERS_PATH}/002.parameters,${PARAMETERS_PATH}/003.parameters,${PARAMETERS_PATH}/004.parameters \
--ports ,,,8502:8501

# Preparing execution
odtp execution prepare \
--execution-name ${EXECUTION_NAME} \
--project-path ${DT_PATH}/${DIGITAL_TWIN_NAME}/${EXECUTION_NAME}

# Running execution
odtp execution run \
--execution-name ${EXECUTION_NAME} \
--secrets-files ${SECRETS_PATH}/001.secrets,,, \
--project-path ${DT_PATH}/${DIGITAL_TWIN_NAME}/${EXECUTION_NAME} 

#odtp execution delete --execution-name ${EXECUTION_NAME} --project-path ${DT_PATH}/${DIGITAL_TWIN_NAME}/${EXECUTION_NAME}