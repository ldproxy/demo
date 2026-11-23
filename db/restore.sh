#!/bin/sh
dropdb -Upostgres cologne_lod2
createdb -Upostgres cologne_lod2
gunzip < cologne_lod2.sql.gz | psql -Upostgres -d cologne_lod2
