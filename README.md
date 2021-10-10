# fastdb

collection of commands to easily run common docker containers

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

currently supports running

- go
- rust
- haskell
- python
- node
- linux
- postgres
- mysql
