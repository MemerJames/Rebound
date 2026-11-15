extends Area2D

@export var jumpPower: float = 400.0
@export var jumpXPower: float = 700.0
@export var friction: float = 150.0
@export var speedMultiplier: float = 1.0

var velocity = Vector2.ZERO
var direction: int = 1
var screen_size
var time: float = 0

@export var health: float = 0
@export var hunger: float = 0

func _ready() -> void:
	screen_size = get_viewport_rect().size
	position = screen_size / 2.0
	await get_tree().create_timer(5.0).timeout # Waits 2s for an item to spawn
	print("--- PLAYER ---")
	print("Layer: ", collision_layer, " | Mask: ", collision_mask, " | Monitoring: ", monitoring, " | Monitorable: ", monitorable)
	for child in get_parent().get_children():
		if child != self and child.has_node("Area2D"):
			var item_area := child.get_node("Area2D")
			print("--- ITEM AREA ---")
			print("Layer: ", item_area.collision_layer, " | Mask: ", item_area.collision_mask, " | Monitoring: ", item_area.monitoring, " | Monitorable: ", item_area.monitorable)
			break

func _process(delta: float) -> void:
	#print(position)
	# game over after player fall out of cam view
	var camera = get_viewport().get_camera_2d()
	if camera != null:
		var camera_y = camera.position.y
		var screen_bottom = camera_y + (screen_size.y / 2.0)
		if position.y < screen_bottom:
			pass
	
	# disable speed multi after 5 seconds
	if speedMultiplier > 0:
		if time < 5:
			time += 1 * delta
		else:
			speedMultiplier = 1
			time = 0
		
	# friction
	velocity.x = move_toward(velocity.x, 0.0, friction * delta)
	
	#move on jump
	if Input.is_action_pressed("jump"):
		# print("jumped!")
		velocity.x = direction * jumpXPower * speedMultiplier
		velocity.y = -jumpPower
		
	# reflect player
	if position.x < 0:
		position.x = 0
		direction = 1
		velocity.x = abs(velocity.x)
	elif position.x > screen_size.x:
		position.x = screen_size.x
		direction = -1
		velocity.x = -abs(velocity.x)
	
	#movement updates
	velocity.y += gravity * delta
	position += velocity * delta
	
	var hits := get_overlapping_areas()
	if not hits.is_empty():
		print("OVERLAPPING RIGHT NOW WITH: ", hits)
	
func _on_area_entered(area: Area2D) -> void:
	print("PLAYER TOUCHED: ", area.name)	
	area.get_parent().queue_free()
	
