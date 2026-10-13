#!/bin/bash
#
# This script automates the building and testing of the MRM message set and flows.
#
# Copyright (c) 2023 Open Technologies for Integration
# Licensed under the MIT license (see LICENSE for details)
#

set -e # Fail on error

# Create the work directory
mqsicreateworkdir /tmp/ace-mrm-compile-example-work-dir

echo ========================================================================
echo Building application and tests
echo ========================================================================

# Old commands 
#mqsipackagebar -w . -a /tmp/MRMMessageFlow.bar -k MRMMessageFlow -t MRMMessageFlow_Test
#mqsibar -c -w /tmp/ace-mrm-compile-example-work-dir -a /tmp/MRMMessageFlow.bar

# ibmint new for v12
ibmint deploy --input-path . --output-work-directory /tmp/ace-mrm-compile-example-work-dir --project MRMMessageFlow --project RecordMRMIssue --project MRMMessageFlow_Test

echo ========================================================================
echo Optimize unit test server
echo ========================================================================
# ibmint optimize server new for v12.0.4
ibmint optimize server --work-directory /tmp/ace-mrm-compile-example-work-dir --disable NodeJS

echo ========================================================================
echo Run unit tests
echo ========================================================================
IntegrationServer -w /tmp/ace-mrm-compile-example-work-dir --start-msgflows false --no-nodejs --admin-rest-api -1 --test-project MRMMessageFlow_Test
