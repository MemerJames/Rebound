extends Node2D

# variables


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("collectible") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Auto-delete this item if the player misses it and it scrolls off the bottom
	var camera := get_viewport().get_camera_2d()
	if camera != null:
		var screen_bottom := camera.position.y + (get_viewport_rect().size.y / 2.0) + 100.0
		if global_position.y > screen_bottom:
			queue_free()

func collect(player: Area2D) -> void:
	player.health -= 1
	queue_free()
