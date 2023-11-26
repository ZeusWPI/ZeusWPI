SHELL=/bin/bash

docker_compose=docker compose

setup: data files
	mkdir -p {data,files}

devel: setup
	${docker_compose} -f docker-compose.devel.yml up -d
	swipl src/main.pl devel 5000

prod: setup
	swipl src/main.pl prod 5000
