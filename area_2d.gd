extends Area2D

@export var jumpPower: float = 400.0
@export var jumpXPower: float = 250.0
@export var friction: float = 150.0

var velocity = Vector2.ZERO
var direction: int = 1
var screen_size

@export var health: float = 0
@export var hunger: float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	position = screen_size / 2.0	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity.y += gravity * delta
	
	velocity.x = move_toward(velocity.x, 0.0, friction * delta)
	
	if Input.is_action_pressed("jump"):
		print("jumped!")
		velocity.x = direction * jumpXPower
		velocity.y = -jumpPower
		
	# reflect player
	if position.x < 0:
		position.x = 0
		direction = 1
		velocity.x = abs(velocity.x)
	elif position.x > screen_size.x:
		position.x = screen_size.x
		velocity.x = -abs(velocity.x)
		
	position += velocity * delta
	
