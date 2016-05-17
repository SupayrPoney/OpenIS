all: triples.ttl

database.ok: createdb.sh populate.sql
	./$<
	touch $@

triples.ttl: r2rml.ttl database.ok
	java -cp dependency/ -jar db2triples-1.0.3-SNAPSHOT.jar -d org.postgresql.Driver -f -m r2rml -l jdbc:postgresql: -b openis -r $< -u 'openis' -p 'openis' -o $@

clean:
	rm -f database.ok triples.ttl
	sudo -u postgres dropdb openis
