extends Control

var data = [
["1","123404321", "24", "120.000", "18%", "24 Bln", "Edit"],
["2","123404322", "4", "240.000", "16%", "12 Bln", "Edit"],
["3","123404323", "9", "840.000", "17%", "6 Bln", "Edit"],
["4","123404324", "40", "1000.000", "18%", "12 Bln", "Edit"],
["5","123404325", "19", "120.000", "15%", "24 Bln", "Edit"],
["6","123404326", "17", "560.000", "18%", "12 Bln", "Edit"],
["7","123404327", "0", "240.000", "14%", "24 Bln", "Edit"]]

func _ready():
	for c in range(len(data)):
		for r in range(len(data[c])):
			if(r != 6):
				$table.add_item (data[c][r], null, false)
			else:
				$table.add_item (data[c][r], null, true)

func _on_table_item_selected(index):
	print(index)
