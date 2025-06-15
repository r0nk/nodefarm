extends Node

#need to have variables to shopkeep inventory and customer inventory
#along with store wallet and customer wallet

var store:Node
var customer:Node

func _process(delta):
	if ! get_parent().visible:
		return
	$"../Buy/transaction_button/slot".item=store.items[0]
