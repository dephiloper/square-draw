extends Node2D

export(Vector2) var draw_size = Vector2(64, 64)
var cell_dim = Vector2(16,16)
var rects = []
var pressed

func _draw():
	for rect in rects:
		draw_rect(rect, Color.red)
	for i in range(draw_size.x + 1):
		draw_line(Vector2(i * cell_dim.x, 0), Vector2(i * cell_dim.x, draw_size.y * cell_dim.y), Color.white)
	for i in range(draw_size.y + 1):
		draw_line(Vector2(0, i * cell_dim.y), Vector2(draw_size.x * cell_dim.x, i * cell_dim.y), Color.white)
		
func _input(event):
	if event is InputEventMouseButton:
		pressed = event.pressed
		draw_cell(get_global_mouse_position())
	if event is InputEventMouseMotion and pressed:
		draw_cell(get_global_mouse_position()) 
	
func draw_cell(pos):
	var grid_pos = (pos - position)
	if  (grid_pos.x < 0 or grid_pos.y < 0) or (grid_pos.x > cell_dim.x * draw_size.x or grid_pos.y > cell_dim.y * draw_size.y): return
	
	var x = int(grid_pos.x / cell_dim.x) * cell_dim.x
	var y = int(grid_pos.y / cell_dim.y) * cell_dim.y
	
	var rect = Rect2(Vector2(x, y), cell_dim)
	
	if rects.find(rect) == -1:
		rects.append(rect)
	update()