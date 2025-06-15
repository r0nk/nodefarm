extends Panel

signal item_picked(item)

func search_changed(search_text):
	#TODO make this filter the items
	print(search_text)
	$scroll.value=0


