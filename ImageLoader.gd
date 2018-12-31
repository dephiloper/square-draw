extends Node2D

func _ready():
	var image = Image.new()
	image.load("icon.png")
	image.lock()
	for i in range(image.get_height()):
		for j in range(image.get_width()):
			pass