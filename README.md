# OpenIS
## Installation

You need PostgreSQL and Postgis. On Ubuntu/Debian:

    apt-get install postgresql postgis

Then probably create a Postgres cluster using

    sudo -u postgres pg_createcluster 9.4 Main
    sudo -u postgres pg_ctlcluster 9.4 Main start

_**NOTE**: On certain distributions, this is automatically done by the package manager_

After that, you can populate the database using

    ./createdb.sh

_Yes, but now that I fucked up everything, I want a fresh database again !_

    dropdb openis && ./createdb.sh

## Accessing the data

You can open a PostgreSQL REPL with

    psql openis

If you prefer a graphical interface, use PGAdmin3 and connect to the `openis` database.
