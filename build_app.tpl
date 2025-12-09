#!/usr/bin/env bash

git clone https://github.com/cranberry511/05-virt-04-docker-in-practice-shvirtd-example-python.git
cd 05-virt-04-docker-in-practice-shvirtd-example-python
docker build -t cr.yandex/${registry_name}/my_python:1.0.0 .
docker push cr.yandex/${registry_name}/my_python:1.0.0
