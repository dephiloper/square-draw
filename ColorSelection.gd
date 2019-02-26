extends Node2D

signal selection_changed

var viewport_size
var font
var color_rect
var outline_rect
var image_loader
var color_index = 0

func _ready():
	image_loader = $"/root/Main/ImageLoader"
	viewport_size = get_viewport().size
	font = LoadingManager.font.duplicate()
	font.size = 48
	
	color_rect = Rect2(Vector2(viewport_size.x/2-25,viewport_size.y-51),Vector2(50,50))
	outline_rect = Rect2(Vector2(viewport_size.x/2-26,viewport_size.y-52),Vector2(52,52))
	
func _draw():
	draw_rect(outline_rect, Color.black)
	draw_rect(color_rect, image_loader.colors[color_index])
	draw_color_num()
	
func draw_color_num():
	var num_str = str(color_index)
	var font_size = font.get_string_size(num_str)
	font_size = Vector2(-font_size.x, font_size.y) 
	draw_string(font, outline_rect.position + color_rect.size / 2  + (font_size / 2), num_str, Color(1, 1, 1, 0.25))

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		if outline_rect.has_point(get_global_mouse_position()):
			color_index = (color_index + 1) % len(image_loader.colors)
			update()
			emit_signal("selection_changed")
			