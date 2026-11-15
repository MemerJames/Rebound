extends Node2D

@export var items: Array[PackedScene] = []
@export var camera: Camera2D
@export var spawnDistance: float = 200.0
@export var spawnDelay: float = 1
@export var player: Area2D

var nextSpawn: float = 0.0
var itemSpawnAmount: int = 5
var screen_size
var margin = 50
var spawnTimer: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nextSpawn = camera.position.y + 200.0
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawnTimer += delta
	screen_size = get_viewport_rect().size
	if items.is_empty() or camera == null:
		return
	if spawnTimer >= spawnDelay:
		var randomX = randi_range(0 + margin, screen_size.x - margin)
		var randItem: PackedScene = items.pick_random()
		nextSpawn = player.position.y - spawnDistance
		spawnTimer = 0.0
		spawnItem(randomX, nextSpawn, randItem)
	
func spawnItem(x: float, y: float, item):
	var newItem = item.instantiate()
	newItem.position = Vector2(x, y)
	add_child(newItem)
	print("Spawned Item!")
	
