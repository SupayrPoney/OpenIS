#!/bin/bash

DBNAME="openis"
ME=$(whoami)

# Create the database
sudo -u postgres createdb -O $ME $DBNAME

# postgres user required to create extension postgis
sudo -u postgres psql $DBNAME -c 'CREATE EXTENSION postgis;'

# Create schemas
psql $DBNAME < create.sql

# Then fill in everything
psql $DBNAME < populate.sql
