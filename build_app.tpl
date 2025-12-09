#!/usr/bin/env bash

git clone https://github.com/cranberry511/ter_project.git
cd ter_project
docker build -t cr.yandex/${registry_name}/my_python:1.0.0 .
docker push cr.yandex/${registry_name}/my_python:1.0.0
