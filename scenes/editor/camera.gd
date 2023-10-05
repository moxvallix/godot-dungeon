extends Camera2D

@export var zoom_increment: float = 0.3
@export var zoom_clamp: Vector2 = Vector2(1, 12)

var panning: bool = false
var focus_point: Vector2
var default_zoom: Vector2

func _ready():
	default_zoom = zoom

func _input(event):
	if event.is_action(&"camera_pan"):
		panning = event.is_pressed()
	if event.is_action(&"camera_zoom_in"):
		zoom_by(zoom_increment)
	if event.is_action(&"camera_zoom_out"):
		zoom_by(-zoom_increment)
	if event.is_action(&"camera_reset"):
		reset_camera()
	if event is InputEventMouseMotion and panning:
		position -= event.relative / zoom

func zoom_by(amount: float) -> void:
	set_zoom_clamped(zoom + Vector2(amount, amount))

func set_zoom_clamped(value: Vector2) -> void:
	zoom = value.clamp(Vector2(zoom_clamp.x, zoom_clamp.x), Vector2(zoom_clamp.y, zoom_clamp.y))

func reset_camera() -> void:
	set_zoom_clamped(default_zoom)
	position = focus_point
