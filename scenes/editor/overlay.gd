extends TileMap

const DOOR_ATLAS: Vector2i = Vector2i(2, 4)

signal edited_cell(cell_pos: Vector2i)

var starting_cell: Vector2i
var editable_cell: bool = false
var editable_cell_coords: Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if editable_cell:
		%TextureRect.modulate = Color("ffffff")
	else:
		%TextureRect.modulate = Color("ff0000")

func _input(event):
	if event is InputEventMouse:
		var cell_coords: Vector2i = local_to_map(get_local_mouse_position())
		var cursor_coords: Vector2 = map_to_local(cell_coords)
		if get_cell_source_id(0, cell_coords) >= 0:
			%TextureRect.show()
			%TextureRect.position = cursor_coords
		else:
			%TextureRect.hide()
		if is_editable_cell(cell_coords):
			editable_cell = true
			editable_cell_coords = cell_coords
		else:
			editable_cell = false
	if event.is_action_pressed(&"builder_use") and editable_cell:
		BetterTerrain.set_cell(self, 0, editable_cell_coords, -1)
		BetterTerrain.update_terrain_cell(self, 0, editable_cell_coords)
		var global_cell_pos: Vector2 = to_global(map_to_local(editable_cell_coords))
		edited_cell.emit(global_cell_pos)

func set_starting_cell(coords: Vector2i) -> void:
	starting_cell = coords
	set_cell(0, coords, 0, DOOR_ATLAS)

func is_editable_cell(coords: Vector2i) -> bool:
	var directions: Array[Vector2i] = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
	var current_rect: Vector2i = get_used_rect().size - Vector2i.ONE
	if coords.x >= current_rect.x || coords.x <= 0: return false
	if coords.y >= current_rect.y || coords.y <= 0: return false
	for dir in directions:
		var neighbour: Vector2i = coords + dir
		if neighbour == starting_cell: return true
		if get_cell_source_id(0, neighbour) == -1: return true
	return false
