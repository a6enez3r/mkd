## rust constants
rust_cname := rust_dev
rust_workdir := /home
ifeq ($(rust_port),)
rust_port := 1111
endif
ifeq ($(rust_image),)
rust_image := rust:alpine
endif


## go constants
go_cname := go_dev
go_workdir := /go/src/github.com/abmamo
ifeq ($(go_port),)
go_port := 2222
endif
ifeq ($(go_image),)
go_image := golang:latest
endif


## linux constants
linux_cname := linux_dev
linux_workdir := /home
ifeq ($(linux_port),)
linux_port := 3333
endif
ifeq ($(linux_image),)
linux_image := ubuntu:latest
endif


## haskell constants
haskell_cname := haskell_dev
haskell_workdir := /home
ifeq ($(haskell_port),)
haskell_port := 4444
endif
ifeq ($(haskell_image),)
haskell_image := haskell:latest
endif

## node constants
node_cname := node_dev
node_workdir := /home
ifeq ($(node_port),)
node_port := 5555
endif
ifeq ($(node_image),)
node_image := node:latest
endif


## python constants
py_cname := py_dev
py_workdir := /home
ifeq ($(py_port),)
py_port := 6666
endif
ifeq ($(py_image),)
py_image := python:latest
endif

## postgres constants
ifeq ($(pg_db),)
pg_db := pg_dev
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

## mysql constants
ifeq ($(mysql_db),)
mysql_db := mysql_dev
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
mysql_image := mysql:8.0
endif
mysql_uri := mysql://${mysql_user}:${mysql_pass}@${mysql_host}:${mysql_port}/${mysql_db}

help:
	@echo "list of available commands"
	@echo
	@echo "go               - create a go dev env in a docker container"
	@echo "rust             - create a rust dev env in a docker container"
	@echo "haskell          - create a haskell dev env in a docker container"
	@echo "python           - create a python dev env in a docker container"
	@echo "node             - create a node dev env in a docker container"
	@echo "linux            - create a linux dev env in a docker container"
	@echo
	@echo "postgres"
	@echo "pg-start         - start a postgres db running in a docker container"
	@echo "pg-stop          - stop postgres db running in a docker container"
	@echo "pg-restart       - restart postgres db running in a docker container"
	@echo "pg-purge         - stop & remove postgres db running in a docker container"
	@echo "pg-shell         - access postgres shell using psql"
	@echo "pg-uri           - get postgres db connection uri"
	@echo
	@echo "mysql"
	@echo "mysql-start      - start a mysql db running in a docker container"
	@echo "mysql-stop       - stop dev mysql db running in a docker container"
	@echo "mysql-restart    - restart mysql db running in a docker container"
	@echo "mysql-purge      - stop & remove mysql db running in a docker container"
	@echo "mysql-shell      - access mysql shell using mysql-admin"
	@echo "mysql-uri        - get mysql db connection uri"

go:
	@echo "spawing: go"
	@docker run --rm -it --name ${go_cname} -p ${go_port}:${go_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/go/:${go_workdir} -w ${go_workdir} ${go_image}

rust:
	@echo "spawing: rust"
	@docker run --rm -it --name ${rust_cname} -p ${rust_port}:${rust_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/rust/:${rust_workdir} -w ${rust_workdir} ${rust_image}

haskell:
	@echo "spawing: haskell"
	@docker run --rm -it --name ${haskell_cname} -p ${haskell_port}:${haskell_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/haskell/:${haskell_workdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${haskell_workdir} ${haskell_image} bash

python:
	@echo "spawing: python"
	@docker run --rm -it --name ${py_cname} -p ${py_port}:${py_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/py/:${py_workdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${py_workdir} ${py_image} bash

node:
	@echo "spawing: node"
	@docker run --rm -it --name ${node_cname} -p ${node_port}:${node_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/node/:${node_workdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${node_workdir} ${node_image} bash

linux:
	@echo "spawing: linux"
	@docker run --rm -it --name ${linux_cname} -p ${linux_port}:${linux_port} -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/data/linux/:${linux_workdir} -v $(CURDIR)/scripts/startup/:/home/scripts -w ${linux_workdir} ${linux_image}

pg-create:
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@echo "existing pg: ${pg_cid}",\
		@echo "creating pg..." && docker run -t -i -d -v $(CURDIR)/data/postgres:/var/lib/postgresql/data --name ${pg_cname} -e POSTGRES_DB=${pg_db} -e POSTGRES_USER=${pg_user} -e POSTGRES_PASSWORD=${pg_pass} -p ${pg_port}:5432 ${pg_image} postgres -c log_statement=all)
	$(endif)

pg-start: pg-create
	@echo "waiting for pg..." && sleep 5 && docker exec -it $(shell docker ps -aqf "name=${pg_cname}") bash -c "while ! pg_isready -p 5432 -h localhost; do sleep 5; done"

pg-restart:
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@echo "restarting pg..." && docker run ${pg_cid},\
		@echo "no pg container found!")
	$(endif)

pg-stop:
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@echo "stopping pg..." && docker stop ${pg_cid},\
		@echo "no pg container found!")
	$(endif)

pg-purge: pg-stop
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@echo "purging pg..." && docker rm ${pg_cid} && rm -r $(CURDIR)/data/postgres && mkdir $(CURDIR)/data/postgres,\
		@echo "no pg container found!")
	$(endif)

pg-shell:
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@docker exec -it ${pg_cid} psql -h ${pg_host} -U ${pg_user} -p 5432 ${pg_db},\
		@echo "no pg container found!")
	$(endif)

pg-uri:
	$(eval pg_cid = $(shell (docker ps -aqf "name=${pg_cname}")))
	$(if $(strip $(pg_cid)), \
		@echo "uri: ${pg_uri}",\
		@echo "no pg container found!")
	$(endif)

mysql-create:
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@echo "existing mysql: ${mysql_cid}",\
		@echo "creating mysql..." && docker run -t -i -d -v $(CURDIR)/data/mysql:/var/lib/mysql --name ${mysql_cname} -e MYSQL_DATABASE=${mysql_db} -e MYSQL_USER=${mysql_user} -e MYSQL_PASSWORD=${mysql_pass} -e MYSQL_ROOT_PASSWORD=${mysql_rpass} -p ${mysql_port}:3306 ${mysql_image})
	$(endif)

mysql-start: mysql-create
	@echo "waiting for mysql..." && sleep 5 && docker exec -it $(shell docker ps -aqf "name=${mysql_cname}") bash -c "while ! mysqladmin ping -h localhost --silent; do sleep 5; done"

mysql-restart:
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@echo "restarting mysql..." && docker run ${mysql_cid},\
		@echo "no mysql container found!")
	$(endif)

mysql-stop:
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@echo "stopping mysql..." && docker stop ${mysql_cid},\
		@echo "no mysql container found!")
	$(endif)

mysql-purge: mysql-stop
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@echo "purging mysql..." && docker rm ${mysql_cid} && rm -r $(CURDIR)/data/postgres && mkdir $(CURDIR)/data/postgres,\
		@echo "no mysql container found!")
	$(endif)

mysql-shell:
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@docker exec -it ${mysql_cid} mysql -h ${mysql_host} -u ${mysql_user} -P 5432 ${mysql_db} -p,\
		@echo "no mysql container found!")
	$(endif)

mysql-uri:
	$(eval mysql_cid = $(shell (docker ps -aqf "name=${mysql_cname}")))
	$(if $(strip $(mysql_cid)), \
		@echo "uri: ${mysql_uri}",\
		@echo "no mysql container found!")
	$(endif)