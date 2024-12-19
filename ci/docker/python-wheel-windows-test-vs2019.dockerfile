# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# NOTE: You must update PYTHON_WHEEL_WINDOWS_IMAGE_REVISION in .env
# when you update this file.

# based on mcr.microsoft.com/windows/servercore:ltsc2019
# contains choco and vs2019 preinstalled
ARG base
# hadolint ignore=DL3006
FROM ${base}

# hadolint shell=cmd.exe

# Define the full version number otherwise choco falls back to patch number 0 (3.9 => 3.9.0)
ARG python=3.9
RUN (if "%python%"=="3.9" setx PYTHON_VERSION "3.9.13") & \
    (if "%python%"=="3.10" setx PYTHON_VERSION "3.10.11") & \
    (if "%python%"=="3.11" setx PYTHON_VERSION "3.11.9") & \
    (if "%python%"=="3.12" setx PYTHON_VERSION "3.12.5") & \
    (if "%python%"=="3.13" setx PYTHON_VERSION "3.13.0-rc1")

# Install archiver to extract xz archives
RUN choco install -r -y --pre --no-progress --force python --version=%PYTHON_VERSION% && \
    choco install --no-progress -r -y archiver

ENV PYTHON=$python
