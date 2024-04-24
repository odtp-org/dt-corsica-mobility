#!/bin/bash
ODTP_USER_EMAIL=sabine.maennel@gmail.com
ODTP_PATH=$(pwd)
DIGITAL_TWIN_NAME=dt-corsica
EXECUTION_NAME=corsica-execution-1
echo $ODTP_PATH
echo $ODTP_USER_EMAIL
echo $DIGITAL_TWIN_NAME
echo $EXECUTION_NAME

# Pulling all the components and versions
odtp new odtp-component-entry \
--name odtp-eqasim-dataloader \
--component-version v0.3.1 \
--repository https://github.com/odtp-org/odtp-eqasim-dataloader

odtp new odtp-component-entry \
--name odtp-eqasim \
--component-version v0.4.2 \
--repository https://github.com/odtp-org/odtp-eqasim.git

odtp new odtp-component-entry \
--name odtp-eqasim-matsim \
--component-version v0.1.2 \
--repository https://github.com/odtp-org/odtp-eqasim-matsim

odtp new odtp-component-entry \
--name odtp-travel-data-dashboard \
--component-version v0.1.0 \
--repository https://github.com/odtp-org/odtp-travel-data-dashboard

# Creating new digital twin
odtp new digital-twin-entry \
--user-email $ODTP_USER_EMAIL  \
--name $DIGITAL_TWIN_NAME

#Creating new execution
odtp new execution-entry \
--name $EXECUTION_NAME \
--digital-twin-name $DIGITAL_TWIN_NAME \
--component-tags odtp-eqasim-dataloader:v0.3.1,odtp-eqasim:v0.4.2,odtp-eqasim-matsim:v0.1.2,odtp-travel-data-dashboard:v0.1.0 \
--parameter-files $ODTP_PATH/dt-corsica/001.parameters,$ODTP_PATH/dt-corsica/002.parameters,$ODTP_PATH/dt-corsica/003.parameters,$ODTP_PATH/dt-corsica/004.parameters \
--ports ,,,8502:8501

# Preparing execution
odtp execution prepare --execution-name $EXECUTION_NAME --project-path $ODTP_PATH/dt-corsica/execution

# Running execution
odtp execution run --execution-name $EXECUTION_NAME --secrets-files ,,,$ODTP_PATH/dt-corsica/004.secrets --project-path $ODTP_PATH/dt-corsica/execution
