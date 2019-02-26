extends Node2D

const grid_size = Vector2(32, 32)
const cell_dim = Vector2(16,16)

var pressed = false
var cells = []
var font
var color_selection = null

func _ready():
	font = LoadingManager.font.duplicate()
	font.size = 12
	color_selection = get_parent().get_node("UI/ColorSelection")
	for y in range(grid_size.y):
		for x in range(grid_size.x):
			cells.append(Cell.new(x, y))

func _draw():
	for cell in cells:
		if cell.colored:
			draw_rect(cell.rect, cell.color)
		else:
			draw_color_num(cell)
			if cell.color_num == color_selection.color_index:
				draw_rect(cell.rect, Color(0.8,0.8,0.8,0.5))
	for i in range(grid_size.x + 1):
		draw_line(Vector2(i * cell_dim.x, 0), Vector2(i * cell_dim.x, grid_size.y * cell_dim.y), Color(1, 1, 1, 0.2))
	for i in range(grid_size.y + 1):
		draw_line(Vector2(0, i * cell_dim.y), Vector2(grid_size.x * cell_dim.x, i * cell_dim.y), Color(1, 1, 1, 0.2))
		
func _input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		pressed = event.pressed
		draw_cell(get_global_mouse_position())
	if event is InputEventMouseMotion and pressed:
		draw_cell(get_global_mouse_position())
	
func draw_cell(pos : Vector2):
	var grid_pos = (pos - position)
	if  (grid_pos.x < 0 or grid_pos.y < 0) or (grid_pos.x > cell_dim.x * grid_size.x or grid_pos.y > cell_dim.y * grid_size.y): return
	
	var x = int(grid_pos.x / cell_dim.x)
	var y = int(grid_pos.y / cell_dim.y)
	cell_at(x,y).colored = true
	update()
	
func clear_cells():
	for cell in cells:
		cell.clear()

func cell_at(x,y) -> Cell:
	return cells[x + y * grid_size.y]

func draw_color_num(cell : Cell):
	if cell.color_num == -1 or cell.colored: return
	var num_str = str(cell.color_num)
	var font_size = font.get_string_size(num_str)
	font_size = Vector2(-font_size.x, font_size.y)
	draw_string(font, cell.draw_pos + (cell_dim / 2) + (font_size / 2), num_str, Color(1, 1, 1, 0.2))

class Cell:
	var color = Color(1,1,1,0)
	var color_num = 0
	var colored = false
	var grid_pos = Vector2.ZERO
	var draw_pos = Vector2.ZERO
	var rect = Rect2(Vector2.ZERO, Vector2.ZERO)
	
	func _init(x, y):
		self.color = Color(1,1,1,0)
		self.colored = false
		self.grid_pos = Vector2(x,y)
		self.draw_pos = Vector2(x * cell_dim.x, y * cell_dim.y)
		self.rect = Rect2(draw_pos, cell_dim)
		
	func clear():
		self.colored = false

func _on_ColorSelection_selection_changed() -> void:
	update()
