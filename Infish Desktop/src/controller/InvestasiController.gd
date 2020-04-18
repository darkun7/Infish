extends Control

var data = [
["1","123404321", "240.000", "BNI", "19/4/20", "Diterima", "Edit"],
["2","123404322", "720.000", "BCA", "19/4/20", "Diterima", "Edit"],
["3","123404323", "2.000.000", "BRI", "19/4/20", "Diterima", "Edit"],
["4","123404323", "4.800.000", "BNI", "19/4/20", "Diterima", "Edit"],
["5","123404322", "960.000", "BTN", "19/4/20", "Belum", "Edit"],
["6","123404322", "3.750.000", "MEGA", "19/4/20", "Belum", "Edit"],
["7","123404321", "480.000", "BRI", "19/4/20", "Belum", "Edit"]]

func _ready():
	for c in range(len(data)):
		for r in range(len(data[c])):
			if(r != 6):
				$table.add_item (data[c][r], null, false)
			else:
				$table.add_item (data[c][r], null, true)

func _on_table_item_selected(index):
	print(index)
