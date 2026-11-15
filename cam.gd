extends Camera2D

@export var player: Area2D
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	position = screen_size / 2.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player == null:
		return
		
	if player.position.y < position.y:
		position.y = player.position.y
