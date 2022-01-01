default_ddir := $(CURDIR)/data

# language containers

# rust constants
rust_cname := makedb_rust
rust_wdir := /home
ifeq ($(rust_ddir),)
rust_ddir := ${default_ddir}/rust
endif
ifeq ($(rust_port),)
rust_port := 1111
endif
ifeq ($(rust_image),)
rust_image := rust:alpine
endif

# go constants
go_cname := makedb_go
go_wdir := /go/src/github.com/abmamo
ifeq ($(go_ddir),)
go_ddir := ${default_ddir}/go
endif
ifeq ($(go_port),)
go_port := 2222
endif
ifeq ($(go_image),)
go_image := golang:latest
endif

# haskell constants
haskell_cname := makedb_haskell
haskell_wdir := /home
ifeq ($(haskell_ddir),)
haskell_ddir := ${default_ddir}/haskell
endif
ifeq ($(haskell_port),)
haskell_port := 4444
endif
ifeq ($(haskell_image),)
haskell_image := haskell:latest
endif

# node constants
node_cname := makedb_node
node_wdir := /home
ifeq ($(node_ddir),)
node_ddir := ${default_ddir}/node
endif
ifeq ($(node_port),)
node_port := 5555
endif
ifeq ($(node_image),)
node_image := node:latest
endif

# python constants
python_cname := makedb_python
python_wdir := /home
ifeq ($(python_ddir),)
python_ddir := ${default_ddir}/python
endif
ifeq ($(python_port),)
python_port := 6666
endif
ifeq ($(python_image),)
python_image := python:latest
endif

# python constants
java_cname := makedb_python
java_wdir := /home
ifeq ($(java_ddir),)
java_ddir := ${default_ddir}/java
endif
ifeq ($(java_port),)
java_port := 7777
endif
ifeq ($(java_image),)
java_image := openjdk:alpine
endif

# Misc containers

# linux constants
linux_cname := makedb_linux
linux_wdir := /home
ifeq ($(linux_ddir),)
linux_ddir := ${default_ddir}/linux
endif
ifeq ($(linux_port),)
linux_port := 8888
endif
ifeq ($(linux_image),)
linux_image := ubuntu:latest
endif

# registry constants
registry_cname := makedb_registry
registry_wdir := /home
ifeq ($(registry_ddir),)
registry_ddir := ${default_ddir}/registry
endif
ifeq ($(registry_port),)
registry_port := 5000
endif
ifeq ($(registry_image),)
registry_image := registry:latest
endif

# prometheus constants
prometheus_cname := makedb_prometheus
prometheus_wdir := /prometheus
ifeq ($(prometheus_ddir),)
prometheus_ddir := ${default_ddir}/prometheus
endif
ifeq ($(prometheus_port),)
prometheus_port := 9090
endif
ifeq ($(prometheus_image),)
prometheus_image := prom/prometheus:latest
endif

# KV containers

# redis constants
redis_cname := makedb_redis
redis_wdir := /home
ifeq ($(redis_ddir),)
redis_ddir := ${default_ddir}/redis
endif
ifeq ($(redis_port),)
redis_port := 27017
endif
ifeq ($(redis_image),)
redis_image := bitnami/redis:latest
endif
ifeq ($(redis_user),)
redis_user := abenezer
endif
ifeq ($(redis_pass),)
redis_pass := pw
endif
redis_uri := redis://:${redis_pass}@localhost:${redis_port}

# NoSQL containers

# mongo constants
mongo_cname := makedb_mongo
mongo_wdir := /home
ifeq ($(mongo_ddir),)
mongo_ddir := ${default_ddir}/mongo
endif
ifeq ($(mongo_port),)
mongo_port := 27017
endif
ifeq ($(mongo_image),)
mongo_image := mongo:latest
endif
ifeq ($(mongo_user),)
mongo_user := abenezer
endif
ifeq ($(mongo_pass),)
mongo_pass := pw
endif
mongo_uri := mongodb://${mongo_user}:${mongo_pass}@localhost:${mongo_port}

# SQL containers

# postgres constants
ifeq ($(pg_ddir),)
pg_ddir := ${default_ddir}/postgres
endif
ifeq ($(pg_db),)
pg_db := makedb_pg
endif
ifeq ($(pg_user),)
pg_user := abenezer
endif
ifeq ($(pg_pass),)
pg_pass := pw
endif
ifeq ($(pg_host),)
pg_host := localhost
endif
ifeq ($(pg_port),)
pg_port := 5432
endif
ifeq ($(pg_cname),)
pg_cname := pg_dev
endif
ifeq ($(pg_image),)
pg_image := postgres:latest
endif
pg_uri := postgresql://${pg_user}:${pg_pass}@${pg_host}:${pg_port}/${pg_db}

# mysql constants
ifeq ($(mysql_ddir),)
mysql_ddir := ${default_ddir}/mysql
endif
ifeq ($(mysql_db),)
mysql_db := makedb_mysql
endif
ifeq ($(mysql_user),)
mysql_user := abenezer
endif
ifeq ($(mysql_pass),)
mysql_pass := pw
endif
ifeq ($(mysql_rpass),)
mysql_rpass := rpw
endif
ifeq ($(mysql_host),)
mysql_host := localhost
endif
ifeq ($(mysql_port),)
mysql_port := 3306
endif
ifeq ($(mysql_cname),)
mysql_cname := mysql_dev
endif
ifeq ($(mysql_image),)
mysql_image := mysql:latest
endif
mysql_uri := mysql+pymysql://${mysql_user}:${mysql_pass}@${mysql_host}:${mysql_port}/${mysql_db}

.DEFAULT_GOAL := help
TARGET_MAX_CHAR_NUM=20
# COLORS
ifneq (,$(findstring xterm,${TERM}))
	BLACK        := $(shell tput -Txterm setaf 0 || exit 0)
	RED          := $(shell tput -Txterm setaf 1 || exit 0)
	GREEN        := $(shell tput -Txterm setaf 2 || exit 0)
	YELLOW       := $(shell tput -Txterm setaf 3 || exit 0)
	LIGHTPURPLE  := $(shell tput -Txterm setaf 4 || exit 0)
	PURPLE       := $(shell tput -Txterm setaf 5 || exit 0)
	BLUE         := $(shell tput -Txterm setaf 6 || exit 0)
	WHITE        := $(shell tput -Txterm setaf 7 || exit 0)
	RESET := $(shell tput -Txterm sgr0)
else
	BLACK        := ""
	RED          := ""
	GREEN        := ""
	YELLOW       := ""
	LIGHTPURPLE  := ""
	PURPLE       := ""
	BLUE         := ""
	WHITE        := ""
	RESET        := ""
endif

## show usage / common commands available
.PHONY: help
help:
	@printf "\n${PURPLE}mkd${RESET}: collection of commands to simplify running common Docker containers\n\n"
	@printf "${RED}cmds:\n\n";

	@awk '{ \
			if ($$0 ~ /^.PHONY: [a-zA-Z\-\_0-9]+$$/) { \
				helpCommand = substr($$0, index($$0, ":") + 2); \
				if (helpMessage) { \
					printf "  ${LIGHTPURPLE}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n\n", helpCommand, helpMessage; \
					helpMessage = ""; \
				} \
			} else if ($$0 ~ /^[a-zA-Z\-\_0-9.]+:/) { \
				helpCommand = substr($$0, 0, index($$0, ":")); \
				if (helpMessage) { \
					printf "  ${BLUE}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
					helpMessage = ""; \
				} \
			} else if ($$0 ~ /^##/) { \
				if (helpMessage) { \
					helpMessage = helpMessage"\n                     "substr($$0, 3); \
				} else { \
					helpMessage = substr($$0, 3); \
				} \
			} else { \
				if (helpMessage) { \
					print "\n${YELLOW}             "helpMessage"\n" \
				} \
				helpMessage = ""; \
			} \
		}' \
		$(MAKEFILE_LIST)

## show sample usecase
.PHONY: quickstart
quickstart:
	@printf "\n${PURPLE}mkd${RESET}: collection of commands to simplify running common Docker containers\n\n"
	@printf "you can make ${GREEN}mkd${RESET} globally accessible by adding: \n\n"
	@printf '	${RED}alias mkd="make --makefile=/path/to/mkd/Makefile"${RESET}\n\n'
	@printf "once you have that set up you can see list of available commands / containers: \n\n"
	@printf '	${RED}mkd help${RESET}\n\n'
	@printf "launching a ${GREEN}Python${RESET} container: \n\n"
	@printf '	${RED}mkd python${RESET}\n\n'
	@printf "launching a ${GREEN}Redis${RESET} container: \n\n"
	@printf '	${RED}mkd redis-create${RESET}\n\n'
	@printf "similarly a ${GREEN}Postgres${RESET} container can be launched: \n\n"
	@printf '	${RED}mkd pg-start${RESET}\n\n'

## -- Language containers --

## create Go env [Docker]
go:
	@echo "spawning: go"
	@docker run --rm -t --name ${go_cname} -p ${go_port}:${go_port} -v /var/run/docker.sock:/var/run/docker.sock -v ${go_ddir}:${go_wdir} -w ${go_wdir} ${go_image}

## create Rust env [Docker]
rust:
	@echo "spawning: rust"
	@docker run --rm -t --name ${rust_cname} -p ${rust_port}:${ru bst_port} -v /var/run/docker.sock:/var/run/docker.sock -v ${rust_ddir}:${rust_wdir} -w ${rust_wdir} ${rust_image}

## create Haskell env [Docker]
haskell:
	@echo "spawning: haskell"
	@docker run --rm -t --name ${haskell_cname} -p ${haskell_port}:${haskell_port} -v /var/run/docker.sock:/var/run/docker.sock -v ${haskell_ddir}:${haskell_wdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${haskell_wdir} ${haskell_image} bash

## create Python env [Docker]
python:
	@echo "spawning: python"
	@docker run --rm -t --name ${python_cname} -p ${python_port}:${python_port} -v /var/run/docker.sock:/var/run/docker.sock -v ${python_ddir}:${python_wdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${python_wdir} ${python_image} bash

## create Node env [Docker]
node:
	@echo "spawning: node"
	@docker run --rm -t --name ${node_cname} -p ${node_port}:${node_port} -v /var/run/docker.sock:/var/run/docker.sock -v ${node_ddir}:${node_wdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${node_wdir} ${node_image} bash

## create Java env [Docker]
java:
	@echo "spawning: java"
	@docker run --rm -t --name ${java_cname} -p ${java_port}:${java_port} -v /var/run/docker.sock:/var/run/docker.sock -v ${java_ddir}:${java_wdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${java_wdir} ${java_image}

## -- Misc containers --

## create Linux env [Docker]
linux:
	@echo "spawning: linux"
	@docker run --rm -t --name ${linux_cname} -p ${linux_port}:${linux_port} -v /var/run/docker.sock:/var/run/docker.sock -v ${linux_ddir}:${linux_wdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${linux_wdir} ${linux_image}

## create registry env [Docker]
registry:
	@echo "spawning: registry"
	@docker run --rm -t --name ${registry_cname} -p ${registry_port}:${registry_port} -v /var/run/docker.sock:/var/run/docker.sock -v ${registry_ddir}:${registry_wdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${registry_wdir} ${registry_image}

## create Prometheus env [Docker]
prometheus:
	@echo "spawning: prometheus"
	@docker run --rm -t --name ${prometheus_cname} -p ${prometheus_port}:${prometheus_port} -v /var/run/docker.sock:/var/run/docker.sock -v ${prometheus_ddir}:${prometheus_wdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${prometheus_wdir} ${prometheus_image}

## -- KV containers --

## create Redis container [Docker]
redis-create:
	@echo "spawning: redis"
	@docker run --rm -t --name ${redis_cname} -e REDIS_PORT_NUMBER=${redis_port} -p ${redis_port}:${redis_port} -v /var/run/docker.sock:/var/run/docker.sock -v ${redis_ddir}:${redis_wdir} -v $(CURDIR)/scripts/startup/:/home/scripts -e MONGO_INITDB_ROOT_USERNAME=${mongo_user} -e REDIS_PASSWORD=${redis_pass} -w ${redis_wdir} ${redis_image}

## exec. into Redis shell [Docker]
redis-shell:
	$(eval redis_cid = $(shell (docker ps -aqf "name=${redis_cname}")))
	$(if $(strip $(redis_cid)), \
		@docker exec -t ${redis_cid} redis-cli -h localhost -p ${redis_port} -a ${redis_pass},\
		@echo "no redis container found!")
	$(endif)

## get Redis uri [Docker]
redis-uri:
	$(eval redis_cid = $(shell (docker ps -aqf "name=${redis_cname}")))
	$(if $(strip $(redis_cid)), \
		@echo "${redis_uri}",\
		@echo "no redis container found!")
	$(endif)

## -- NoSQL containers --

## create mongo container [Docker]
mongo-create:
	@echo "spawning: mongo"
	@docker run --rm -t --name ${mongo_cname} -p ${mongo_port}:${mongo_port} -v /var/run/docker.sock:/var/run/docker.sock -v ${mongo_ddir}:${mongo_wdir} -v $(CURDIR)/scripts/startup/:/home/scripts -e MONGO_INITDB_ROOT_USERNAME=${mongo_user} -e MONGO_INITDB_ROOT_PASSWORD=${mongo_pass} -w ${mongo_wdir} ${mongo_image}

## exec. into mongo shell [Docker]
mongo-shell:
	$(eval mongo_cid = $(shell (docker ps -aqf "name=${mongo_cname}")))
	$(if $(strip $(mongo_cid)), \
		@docker exec -t ${mongo_cid} mongo,\
		@echo "no mongo container found!")
	$(endif)

## get mongo uri [Docker]
mongo-uri:
	$(eval mongo_cid = $(shell (docker ps -aqf "name=${mongo_cname}")))
	$(if $(strip $(mongo_cid)), \
		@echo "${mongo_uri}",\
		@echo "no mongo container found!")
	$(endif)

## -- SQL containers --

## create Postgres container [Docker]
pg-create:
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@echo "existing pg: ${pg_cid}",\
		@echo "creating pg..." && docker run -t -i -d -v ${pg_ddir}:/var/lib/postgresql/data --name ${pg_cname} -e POSTGRES_DB=${pg_db} -e POSTGRES_USER=${pg_user} -e POSTGRES_PASSWORD=${pg_pass} -p ${pg_port}:5432 ${pg_image} postgres -c log_statement=all)
	$(endif)

## create & start Postgres container [Docker]
pg-start: pg-create
	@echo "waiting for pg..." && sleep 5 && docker exec -t $(shell docker ps -aqf "name=${pg_cname}") bash -c "while ! pg_isready -p 5432 -h localhost; do sleep 5; done"

## restart Postgres container [Docker]
pg-restart:
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@echo "restarting pg..." && docker run ${pg_cid},\
		@echo "no pg container found!")
	$(endif)

## stop Postgres container [Docker]
pg-stop:
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@echo "stopping pg..." && docker stop ${pg_cid},\
		@echo "no pg container found!")
	$(endif)

## purge Postgres container [Docker]
pg-purge: pg-stop
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@echo "purging pg..." && docker rm ${pg_cid} && rm -r ${pg_ddir} && mkdir ${pg_ddir},\
		@echo "no pg container found!")
	$(endif)

## exec. into Postgres shell [Docker]
pg-shell:
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@docker exec -t ${pg_cid} psql -h ${pg_host} -U ${pg_user} -p 5432 ${pg_db},\
		@echo "no pg container found!")
	$(endif)

## get Postgres uri [Docker]
pg-uri:
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@echo "${pg_uri}",\
		@echo "no pg container found!")
	$(endif)

## create MySQL container [Docker]
mysql-create:
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@echo "existing mysql: ${mysql_cid}",\
		@echo "creating mysql..." && docker run -t -i -d -v ${mysql_ddir}:/var/lib/mysql --name ${mysql_cname} -e MYSQL_DATABASE=${mysql_db} -e MYSQL_USER=${mysql_user} -e MYSQL_PASSWORD=${mysql_pass} -e MYSQL_ROOT_PASSWORD=${mysql_rpass} -p ${mysql_port}:3306 ${mysql_image})
	$(endif)

## create & start MySQL container [Docker]
mysql-start: mysql-create
	@echo "waiting for mysql..." && sleep 5 && docker exec -t $(shell docker ps -aqf "name=${mysql_cname}") bash -c "while ! mysqladmin ping -h localhost --silent; do sleep 5; done"

## restart MySQL container [Docker]
mysql-restart:
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@echo "restarting mysql..." && docker run ${mysql_cid},\
		@echo "no mysql container found!")
	$(endif)

## stop MySQL container [Docker]
mysql-stop:
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@echo "stopping mysql..." && docker stop ${mysql_cid},\
		@echo "no mysql container found!")
	$(endif)

## purge MySQL container [Docker]
mysql-purge: mysql-stop
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@echo "purging mysql..." && docker rm ${mysql_cid} && rm -r ${mysql_ddir} && mkdir ${mysql_ddir},\
		@echo "no mysql container found!")
	$(endif)

## exec. into MySQL shell [Docker]
mysql-shell:
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@docker exec -t ${mysql_cid} mysql -h ${mysql_host} -u ${mysql_user} -P 5432 ${mysql_db} -p,\
		@echo "no mysql container found!")
	$(endif)

## get MySQL uri [Docker]
mysql-uri:
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@echo "${mysql_uri}",\
		@echo "no mysql container found!")
	$(endif)