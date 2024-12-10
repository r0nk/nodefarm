extends CSGBox3D

func interact():
	if(rotation_degrees.y==90):
		rotation_degrees.y=0
		return
	if(rotation_degrees.y==0):
		rotation_degrees.y=90
		return
