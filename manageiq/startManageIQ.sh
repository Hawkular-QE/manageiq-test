#!/bin/bash 
#
# Copyright 2016 Red Hat, Inc. and/or its affiliates
# and other contributors as indicated by the @author tags.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Reference: https://github.com/ManageIQ/guides/blob/master/developer_setup.md

if [ -z ${TOOL_HOME} ] || [ -z ${MANAGEIQ_HOME} ]; then
   echo "Missing TOOL_HOME or MANAGEIQ_HOME env."
   exit 1
fi

# First, start postgres
${TOOL_HOME}/miqPostgres.sh

# Start MemangeIQ
${MANAGEIQ_HOME}/bin/setup      # Installs dependencies, config, prepares database, etc
bundle exec rake evm:start 	# Starts the ManageIQ EVM Application in the background
bundle exec rails s        	# Starts the application server

