extends Node2D

func _ready():
	$Grid.position.x -= int($Grid.draw_size.x * $Grid.cell_dim.x / 2)
	$Grid.position.y -= int($Grid.draw_size.y * $Grid.cell_dim.y / 2)
	
func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_C:
			$Grid.rects.clear()
			$Grid.update()
		if event.scancode == KEY_PLUS:
			$Camera2D.zoom -= Vector2(0.1, 0.1)
		if event.scancode == KEY_MINUS:
			$Camera2D.zoom += Vector2(0.1, 0.1)
		if event.scancode == KEY_0:
			$Camera2D.zoom = Vector2(1, 1)