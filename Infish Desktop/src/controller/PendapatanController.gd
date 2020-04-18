extends Control

var data = [
["1","123404321", "Benih", "65.000", "19/04/2020", "Edit"],
["2","123404322", "Benih", "140.000", "19/04/2020", "Edit"],
["3","123404323", "Dewasa", "72.000", "19/04/2020", "Edit"],
["4","123404324", "Dewasa", "500.000", "19/04/2020", "Edit"],
["5","123404325", "Benih", "30.000", "19/04/2020", "Edit"],
["6","123404326", "Dewasa", "560.000", "19/04/2020", "Edit"],
["7","123404327", "Dewasa", "50.000", "19/04/2020", "Edit"]]

func _ready():
	for c in range(len(data)):
		for r in range(len(data[c])):
			if(r != 6):
				$table.add_item (data[c][r], null, false)
			else:
				$table.add_item (data[c][r], null, true)

func _on_table_item_selected(index):
	print(index)
