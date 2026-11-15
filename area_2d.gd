extends Area2D

@export var jumpPower = 50
@export var jumpXPower = 200
@export var friction = 10
@export var velocity = Vector2.ZERO
var screen_size

@export var health = 0
@export var hunger = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not velocity.is_zero_approx():
		var currentFriction = friction if velocity.x < 0 else friction * -1
		velocity.x -= currentFriction
	if Input.is_action_pressed("jump"):
		if velocity.x < 0:
			velocity.x -= jumpXPower
		if velocity.x > 0: 
			velocity.x += jumpXPower
		velocity.y -= jumpPower
