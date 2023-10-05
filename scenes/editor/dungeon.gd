extends TileMap

@export var size: Vector2i = Vector2i.ZERO

var weighted_tiles: Array = [
	{&"tile": Vector2i(-1,-1), &"weight": 50},
	{&"tile": Vector2i(0,0), &"weight": 1},
	{&"tile": Vector2i(1,0), &"weight": 5},
	{&"tile": Vector2i(0,1), &"weight": 1},
	{&"tile": Vector2i(1,1), &"weight": 6},
	{&"tile": Vector2i(0,2), &"weight": 1},
	{&"tile": Vector2i(1,2), &"weight": 2},
	{&"tile": Vector2i(2,2), &"weight": 6},
	{&"tile": Vector2i(3,2), &"weight": 15},
	{&"tile": Vector2i(0,3), &"weight": 2},
	{&"tile": Vector2i(1,3), &"weight": 2},
	{&"tile": Vector2i(2,3), &"weight": 2},
	{&"tile": Vector2i(3,3), &"weight": 2}
]

var tile_pool: Array[Vector2i]

# Called when the node enters the scene tree for the first time.
func _ready():
	tile_pool = _create_tile_pool(weighted_tiles)
	_populate_tiles_from_pool(tile_pool)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _create_tile_pool(tile_weights: Array) -> Array[Vector2i]:
	var output: Array[Vector2i] = []
	for tile in tile_weights:
		for i in tile[&"weight"]:
			output.append(tile[&"tile"])
	return output

func _populate_tiles_from_pool(pool: Array[Vector2i]) -> void:
	for x in size.x:
		for y in size.y:
			var selected_tile: Vector2i = pool.pick_random()
			set_cell(0, Vector2i(x, y), 0, selected_tile)
