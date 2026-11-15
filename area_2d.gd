extends Area2D

@export var jumpPower: float = 400.0
@export var jumpXPower: float = 700.0
@export var friction: float = 150.0
@export var speedMultiplier: float = 0.0

var velocity = Vector2.ZERO
var direction: int = 1
var screen_size

@export var health: float = 0
@export var hunger: float = 0

func _ready() -> void:
	screen_size = get_viewport_rect().size
	position = screen_size / 2.0	

func _process(delta: float) -> void:
	var camera = get_viewport().get_camera_2d()
	if camera != null:
		var camera_y = camera.position.y
		var screen_bottom = camera_y + (screen_size.y / 2.0)
		if position.y < screen_bottom:
			pass
	
	velocity.x = move_toward(velocity.x, 0.0, friction * delta)
	
	if Input.is_action_pressed("jump"):
		print("jumped!")
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
		
	position += velocity * delta
	
