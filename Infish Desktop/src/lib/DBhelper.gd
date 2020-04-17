extends Node
# Godot Script belum mendukung penggunaan overloading

var querry : String

#table
func select(table : String)->String:
	querry = "SELECT * FROM `"+table+"`"
	print(">> Query: "+querry)
	return querry

#table, operator ,attribute, value
func select_where(table : String, operator ,attr : String, value)->String:
	querry = "SELECT * FROM `"+table+"`"+" WHERE `"+attr+"` "+operator+" `"+value+"`"
	print(">> Query: "+querry)
	return querry

#table, [attribute], [value]
func insert(table : String, attr : Array, value : Array)->String:
	var attrs : String = ""
	var values : String = ""
	for s in attr:
		attrs  += "`"+s+"`,"
	attrs   =  str(attrs).substr(0, len(attrs)-1)
	for s in value:
		values += "'"+s+"',"
	values  =  str(values).substr(0, len(values)-1)
	querry = "INSERT INTO `"+table+"`("+attrs+") VALUES ("+values+")"
	print(">> Query: "+querry)
	return querry

#table, [attribute], [value], id
#not done yet
func update(table : String, attr : Array, value : Array)->String:
	var attrs : String = ""
	var values : String = ""
	for s in attr:
		attrs  += "`"+s+"`,"
	attrs   =  str(attrs).substr(0, len(attrs)-1)
	for s in value:
		values += "'"+s+"',"
	values  =  str(values).substr(0, len(values)-1)
	querry = "UPDATE `"+table+"` SET ("+attrs+") VALUES ("+values+")"
	print(">> Query: "+querry)
	return querry