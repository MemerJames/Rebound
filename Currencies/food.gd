extends Area2D

# variables
var max_hunger = 5

@export var player: Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area.name == "player":
		area.hunger = min(player.hunger + 1, max_hunger)
		queue_free()
