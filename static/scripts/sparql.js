const SPARQL = {
    PREFIXES: 'PREFIX geo: <http://www.opengis.net/ont/geosparql#>\n'+
              'PREFIX geof: <http://www.opengis.net/def/function/geosparql/>\n' +
              'PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>\n' +
              'PREFIX sf: <http://www.opengis.net/ont/sf#>\n' +
              'PREFIX ont: <http://openis.ititou.be/ont#>\n',

    sparql: function (Q, cont) {
        var payload = {
            query: this.PREFIXES + Q,
            display: "json",
            custom: "",
            stylesheet: "",
            output: "json"
        };
        return $.post("http://openis.ititou.be:8080/parliament/sparql", payload);
    },

    inBoundingBox: function(lon1, lat1, lon2, lat2){
        // Closed rectangle
        var points = [[lon1, lat1], [lon1, lat2], [lon2, lat2], [lon2, lat1],
                      [lon1, lat1]];
        // Then format to WKT
        var pointStr = points.map(function(ll){return ll.join(' ')}).join(',');
        return this.sparql(
            " SELECT DISTINCT ?track ?geom" +
            " WHERE {" +
            "   ?track rdf:type ont:Track." +
            "   ?track geo:hasGeometry ?geom." +
            "   FILTER (geof:sfContains(" +
            "     STRDT(\"POLYGON((" + pointStr + "))\", sf:wktLiteral)," +
            "     STRDT(?geom, sf:wktLiteral))" +
            "   )." +
            "}");
    },

    allTracks: function(){
        return this.sparql("SELECT DISTINCT ?track ?geom WHERE {?track rdf:type ont:Track. ?track geo:hasGeometry ?geom.}");
    }
};
