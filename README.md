# makeDB

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

**installation**

download `makeDB`
```sh
curl https://raw.githubusercontent.com/abmamo/makeDB/main/Makefile --output makeDB.mk
```

make it globally accessible (by adding to `.zshrc` or `.bashrc`)
```
alias makedb="make --makefile=/path/to/makeDB/Makefile"
```
***

## quickstart

to see list of available commands `make help` (or `makedb` depending on your installation)
``` 
cmds:

  help                  show usage / common commands available

  quickstart            show sample usecase


              -- Language containers --

  go:                   create Go env [Docker]
  rust:                 create Rust env [Docker]
  haskell:              create Haskell env [Docker]
  python:               create Python env [Docker]
  node:                 create Node env [Docker]
  java:                 create Java env [Docker]

              -- Misc containers --

  linux:                create Linux env [Docker]
  registry:             create registry env [Docker]
  prometheus:           create Prometheus env [Docker]

              -- KV containers --

  redis-create:         create Redis container [Docker]
  redis-shell:          exec. into Redis shell [Docker]
  redis-uri:            get Redis uri [Docker]

              -- NoSQL containers --

  mongo-create:         create mongo container [Docker]
  mongo-shell:          exec. into mongo shell [Docker]
  mongo-uri:            get mongo uri [Docker]

              -- SQL containers --

  pg-create:            create Postgres container [Docker]
  pg-start:             create & start Postgres container [Docker]
  pg-restart:           restart Postgres container [Docker]
  pg-stop:              stop Postgres container [Docker]
  pg-purge:             purge Postgres container [Docker]
  pg-shell:             exec. into Postgres shell [Docker]
  pg-uri:               get Postgres uri [Docker]
  mysql-create:         create MySQL container [Docker]
  mysql-start:          create & start MySQL container [Docker]
  mysql-restart:        restart MySQL container [Docker]
  mysql-stop:           stop MySQL container [Docker]
  mysql-purge:          purge MySQL container [Docker]
  mysql-shell:          exec. into MySQL shell [Docker]
  mysql-uri:            get MySQL uri [Docker]
```
