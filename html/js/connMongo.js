function connectDB(){
	conn = new Mongo();
	db = conn.getDB("teste");
	if(!db){
		print("Erro ao Conectar");
	}
	else{
		print("Conexão realizada com sucesso!!");
	}

	db.restaurants.insert(
	   {
	      "address" : {
	         "street" : "2 Avenue",
	         "zipcode" : "10075",
	         "building" : "1480",
	         "coord" : [ -73.9557413, 40.7720266 ]
	      },
	      "borough" : "Manhattan",
	      "cuisine" : "Italian",
	      "grades" : [
	         {
	            "date" : ISODate("2014-10-01T00:00:00Z"),
	            "grade" : "A",
	            "score" : 11
	         },
	         {
	            "date" : ISODate("2014-01-16T00:00:00Z"),
	            "grade" : "B",
	            "score" : 17
	         }
	      ],
	      "name" : "Vella",
	      "restaurant_id" : "41704620"
	   }
	)
}
