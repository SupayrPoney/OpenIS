all: mapping.ttl

%.ttl: %.r2rml
	java -cp dependency/ -jar db2triples-1.0.3-SNAPSHOT.jar -f -m r2rml -l jdbc:postgresql: -b openis -r $< -u 'openis' -p 'openis' -o $@
