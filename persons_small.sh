#!/bin/sh
cd persons
sbt 'run /home/justa/dev/small_token ../small-persons.xls ../small-persons.db'
# printf "drop table persons;\n" | sqlite3 $PERSONSDB
# printf "create table persons(personid text primary key not null, personname text);\n" | sqlite3 $PERSONSDB
# printf "insert into persons(personid) select distinct personid from emails;\n" | sqlite3 $PERSONSDB
