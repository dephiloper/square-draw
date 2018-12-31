extends Node2D

const draw_size = Vector2(16, 16)
const cell_dim = Vector2(16,16)
var pressed
var cells = []

func _init():
	for y in range(draw_size.y):
		for x in range(draw_size.x):
			cells.append(Cell.new(x, y))

func _draw():
	for cell in cells:
		if cell.colored:
			draw_rect(Rect2(cell.draw_pos, draw_size),Color.red)
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
	
	var x = int(grid_pos.x / cell_dim.x)
	var y = int(grid_pos.y / cell_dim.y)
	cells[x + y * draw_size.y].colored = true
	update()
	
func clear_cells():
	for cell in cells:
		cell.clear()
	
class Cell:
	var colored = false
	var grid_pos = Vector2.ZERO
	var draw_pos = Vector2.ZERO
	var rect = Rect2(Vector2.ZERO, Vector2.ZERO)
	func _init(x, y):
		self.grid_pos = Vector2(x,y)
		self.draw_pos = Vector2(x * cell_dim.x, y * cell_dim.y)
		self.rect = Rect2(draw_pos, draw_size)
		
	func clear():
		self.colored = false