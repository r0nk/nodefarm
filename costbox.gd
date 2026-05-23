extends CSGBox3D

var cost = 200

func buy():
	if Player.get_node("inventory").cash>cost:
		Player.get_node("inventory").cash-=cost
		return true
	return false

func interact():
	print("activated costbox")
	if buy():
		queue_free()

func _ready():
	$label.text="$ "+str(cost)

