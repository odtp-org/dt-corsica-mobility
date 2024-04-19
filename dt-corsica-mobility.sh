#!/bin/bash
ODTP_USER_EMAIL = 
PATH = ${pwd}

DIGITAL_TWIN_NAME = dt-corsica
EXECUTION_NAME = corsica-execution-1

# Pulling all the components and versions
odtp new odtp-component-entry \
--name odtp-eqasim-dataloader \
--component-version 0.3.1 \
--repository https://github.com/odtp-org/odtp-eqasim-dataloader
--commit 9f96f504ad4c772ff96473b13c3bb31d7ed9e471

odtp new odtp-component-entry \
--name odtp-eqasim \
--component-version 0.4.2 \
--repository https://github.com/odtp-org/odtp-eqasim.git
--commit 2c4f6362ab441c07885f7aeebad669acc9e51731

odtp new odtp-component-entry \
--name odtp-eqasim-matsim \
--component-version 0.1.2 \
--repository https://github.com/odtp-org/odtp-eqasim-matsim
--commit 28902c1cea27d5ca503b2af17207e708f0dd407b

odtp new odtp-component-entry \
--name odtp-travel-data-dashboard \
--component-version 0.1.1 \
--repository https://github.com/odtp-org/odtp-travel-data-dashboard
--commit a21e92bbba4a26fd9c645852dab8142fc75fd926

# Creating new digital twin
odtp new digital-twin-entry \
--user-email ${ODTP_USER_EMAIL}  \
--name ${DIGITAL_TWIN_NAME}

# Creating new execution
odtp new execution-entry \
--name ${EXECUTION_NAME} \
--digital-twin-name ${dt-corsica} \
--component-tags odtp-eqasim-dataloader:0.3.1,odtp-eqasim:0.4.2,odtp-eqasim-matsim:0.1.2,odtp-travel-data-dashboard:0.1.1 \
--parameter-files ${PATH}/dt-corsica/001.parameters,${PATH}/dt-corsica/002.parameters,${PATH}/dt-corsica/003.parameters,${PATH}/dt-corsica/004.parameters \
--ports ,,,8502:8501

# Preparing execution
odtp execution prepare --execution-name ${EXECUTION_NAME} --project-path ${PATH}/dt-corsica/execution

# Running execution
odtp execution run --execution-name execution-eqasim-test --secrets-files ,,,${PATH}/dt-corsica/004.secrets --project-path ${PATH}/dt-corsica/execution