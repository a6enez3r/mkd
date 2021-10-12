# fastdb

collection of commands to easily run common docker containers

***

**supports**

***

- `go`
- `rust`
- `haskell`
- `python`
- `node`
- `linux`
- `java`
- `registry`
- `prometheus`
- `mongo`
- `redis`
- `postgres`
- `mysql`

***

**prerequisites**

***

`Docker`

`make`

***

## quickstart

to see list of available commands `make help`
``` 
    list of available commands

    go               - create a go dev env in a docker container
    rust             - create a rust dev env in a docker container
    haskell          - create a haskell dev env in a docker container
    python           - create a python dev env in a docker container
    node             - create a node dev env in a docker container
    linux            - create a linux dev env in a docker container
    java             - create a openjdk [java] dev env in a docker container
    registry         - create a dev registry in a docker container
    prometheus       - create a dev prometheus in a docker container

    mongo
    mongo-create     - create a mongodb dev db in a docker container
    mongo-shell      - create a mongodb dev db in a docker container
    mongo-uri        - get a mongodb db connection uri

    redis
    redis-create     - create a redis dev db in a docker container
    redis-shell      - create a redis dev db in a docker container
    redis-uri        - get a redis connection uri

    postgres
    pg-start         - start a postgres db running in a docker container
    pg-stop          - stop postgres db running in a docker container
    pg-restart       - restart postgres db running in a docker container
    pg-purge         - stop & remove postgres db running in a docker container
    pg-shell         - access postgres shell using psql
    pg-uri           - get postgres db connection uri

    mysql
    mysql-start      - start a mysql db running in a docker container
    mysql-stop       - stop dev mysql db running in a docker container
    mysql-restart    - restart mysql db running in a docker container
    mysql-purge      - stop & remove mysql db running in a docker container
    mysql-shell      - access mysql shell using mysql-admin
    mysql-uri        - get mysql db connection uri
```
