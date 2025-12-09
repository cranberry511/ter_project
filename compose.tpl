version: "3"
include:
  - proxy.yaml
services:
  web:
    image: cr.yandex/${registry_name}/my_python:1.0.0
    env_file:
      - ./.env
    networks:
      backend:
        ipv4_address: 172.20.0.5
    restart: on-failure
