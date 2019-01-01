extends Node2D

var colors = []
var min_diff = 0.5
var transparent = Color(0, 0, 0, 0)

func _ready():
	var image = Image.new()
	image.load("hollow-knight.png")
	image.lock()
	var grid = get_parent().get_node("Grid")
	
	print(image.get_height() * image.get_width())
	for x in range(image.get_height()):
		for y in range(image.get_width()):
			var color = find_close_color(image.get_pixel(x,y))
			var cell = grid.cell_at(x,y)
			cell.color = color				
			#grid.cell_at(x,y).colored = true
			if colors.find(color) == -1:
				colors.append(color)
			
			if color != transparent:
				cell.color_num = colors.find(color)
			else:
				cell.color_num = -1

func find_close_color(c):
	for c2 in colors:
		var diff = abs(c.r - c2.r) + abs(c.g - c2.g) + abs(c.b - c2.b) + abs(c.a - c2.a)
		if diff <= min_diff:
			return c2
			
	return c