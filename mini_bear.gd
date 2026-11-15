extends Node2D

# variables
var max_hearts = 6
var max_hunger = 6


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area.name == "player":
		area.hunger = max_hunger
		area.health = max_hearts
		area.speedMulitplier = 1.5
		queue_free()
