extends Area2D


@export var jumpPower: float = 400.0
@export var jumpXPower: float = 700.0
@export var friction: float = 150.0
@export var speedMultiplier: float = 1.0
@export var jumpMultiplier: float = 1.0

# Hunger drains over time: a new random delay in this range (seconds) is picked
# after every point of hunger lost.
@export var hungerDecayMin: float = 1.0 
@export var hungerDecayMax: float = 15.0

# Once hunger is empty the player starts losing health, one heart per interval.
@export var starveDamageInterval: float = 10.0

var velocity = Vector2.ZERO
var direction: int = 1
var screen_size
var time: float = 0
var hungerDecayTimer: float = 0.0
var hungerDecayInterval: float = 0.0
var starveTimer: float = 0.0

@export var health: float = 5
@export var hunger: float = 5

signal stats_changed(health: float, hunger: float)

func _ready() -> void:
	screen_size = get_viewport_rect().size
	position = screen_size / 2.0
	hungerDecayInterval = randf_range(hungerDecayMin, hungerDecayMax)
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
		
	# hunger slowly drains over time
	hungerDecayTimer += delta
	if hungerDecayTimer >= hungerDecayInterval:
		hungerDecayTimer = 0.0
		hungerDecayInterval = randf_range(hungerDecayMin, hungerDecayMax)
		if hunger > 0.0:
			hunger = max(hunger - 1.0, 0.0)
			stats_changed.emit(health, hunger)
	
	# an empty stomach costs health
	if hunger <= 0.0:
		starveTimer += delta
		if starveTimer >= starveDamageInterval:
			starveTimer = 0.0
			if health > 0.0:
				health = max(health - 1.0, 0.0)
				stats_changed.emit(health, hunger)
	else:
		starveTimer = 0.0
	
	# friction
	velocity.x = move_toward(velocity.x, 0.0, friction * delta)
	
	#move on jump
	if Input.is_action_pressed("jump"):
		# print("jumped!")
		velocity.x = direction * jumpXPower * speedMultiplier
		velocity.y = -jumpPower * jumpMultiplier
		
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
	
func _physics_process(_delta: float) -> void:
	# Check for any overlapping collectible items every physics frame
	for area in get_overlapping_areas():
		var item := area.get_parent()
		if item.is_in_group("collectible"):
			item.collect(self)
			stats_changed.emit(health, hunger)
	
