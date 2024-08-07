#!/bin/bash
ODTP_USER_EMAIL=
DT_PATH=$(pwd)

DIGITAL_TWIN_NAME=dt-corsica
EXECUTION_NAME=corsica-execution-1

# Pulling all the components and versions
odtp new odtp-component-entry \
--name odtp-eqasim-dataloader \
--component-version v0.3.4 \
--repository https://github.com/odtp-org/odtp-eqasim-dataloader

odtp new odtp-component-entry \
--name odtp-eqasim \
--component-version v0.4.4 \
--repository https://github.com/odtp-org/odtp-eqasim.git

odtp new odtp-component-entry \
--name odtp-eqasim-matsim \
--component-version v0.1.4 \
--repository https://github.com/odtp-org/odtp-eqasim-matsim

odtp new odtp-component-entry \
--name odtp-travel-data-dashboard \
--component-version v0.1.4 \
--repository https://github.com/odtp-org/odtp-travel-data-dashboard

# Creating new digital twin
odtp new digital-twin-entry \
--user-email ${ODTP_USER_EMAIL}  \
--name ${DIGITAL_TWIN_NAME}

# Creating new execution
odtp new execution-entry \
--name ${EXECUTION_NAME} \
--digital-twin-name ${DIGITAL_TWIN_NAME} \
--component-tags odtp-eqasim-dataloader:v0.3.3,odtp-eqasim:v0.4.4,odtp-eqasim-matsim:v0.1.4,odtp-travel-data-dashboard:v0.1.4 \
--parameter-files ${DT_PATH}/dt-corsica/001.parameters,${DT_PATH}/dt-corsica/002.parameters,${DT_PATH}/dt-corsica/003.parameters,${DT_PATH}/dt-corsica/004.parameters \
--ports ,,,8502:8501

# Preparing execution
odtp execution prepare \
--execution-name ${EXECUTION_NAME} \
--project-path ${DT_PATH}/dt-corsica/execution

# Running execution
odtp execution run \
--execution-name ${EXECUTION_NAME} \
--secrets-files ,,,${DT_PATH}/dt-corsica/004.secrets \
--project-path ${DT_PATH}/dt-corsica/execution
