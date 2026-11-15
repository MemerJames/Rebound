extends CanvasLayer

var screen_size
@export var player: Area2D
@export var fullHungerIcon: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updateHungerUI(currentHunger: int) -> void:
	$hunger1.texture = fullHungerIcon
	
