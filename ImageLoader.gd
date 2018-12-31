extends Node2D

func _ready():
	var image = Image.new()
	image.load("icon.png")
	image.lock()
	print("height: ",image.get_height(), "width: ", image.get_height()) 
	for i in range(image.get_height()):
		for j in range(image.get_width()):
			print(image.get_pixel(j,i))