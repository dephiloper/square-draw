extends Node2D

var zoom = 1.0

func _ready():
	$Grid.position.x -= int($Grid.grid_size.x * $Grid.cell_dim.x / 2)
	$Grid.position.y -= int($Grid.grid_size.y * $Grid.cell_dim.y / 2)
	
func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_C:
			$Grid.clear_cells()
			$Grid.update()
		if event.scancode == KEY_0:
			$Camera2D.zoom = Vector2(1, 1)
		if event.scancode == KEY_ESCAPE:
			get_tree().quit()
			
func _process(delta):
	if Input.is_action_pressed("zoom_in"):
		zoom -= delta
	elif Input.is_action_pressed("zoom_out"):
		zoom += delta
	if Input.is_action_pressed("ui_left"):
		$Camera2D.offset.x += delta * 100
	if Input.is_action_pressed("ui_right"):
		$Camera2D.offset.x -= delta * 100
	if Input.is_action_pressed("ui_up"):
		$Camera2D.offset.y += delta * 100
	if Input.is_action_pressed("ui_down"):
		$Camera2D.offset.y -= delta * 100
	
	zoom = clamp(zoom, 0.5, 2.0)
	$Camera2D.zoom = Vector2.ONE * zoom