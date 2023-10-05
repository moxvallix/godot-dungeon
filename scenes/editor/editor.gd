extends Node2D

var door_cell: Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	var start_x_cell: int = randi_range(0, 64)
	var start_x_pos: int = start_x_cell * %Overlay.cell_quadrant_size
	door_cell = Vector2i(start_x_cell, 64)
	%Overlay.set_starting_cell(door_cell)
	%Camera.focus_point = Vector2(start_x_pos, 1008)
	%Camera.reset_camera()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_overlay_edited_cell(cell_pos):
	%Camera.focus_point = cell_pos
