extends Control

var data = [
["1","Lele", "2", "Edit"],
["2","Nila", "3", "Edit"],
["3","Gurame", "2", "Edit"],
["4","Gabus", "2.5", "Edit"],
["5","Belut", "1.5", "Edit"],
["6","Udang", "2", "Edit"],
["7","Cumi", "3", "Edit"]]

func _ready():
	for c in range(len(data)):
		for r in range(len(data[c])):
			if(r != 3):
				$table.add_item (data[c][r], null, false)
			else:
				$table.add_item (data[c][r], null, true)

func _on_table_item_selected(index):
	print(index)
