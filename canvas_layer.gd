extends CanvasLayer

var screen_size
@export var player: Area2D
@export var fullHungerIcon: Texture2D
@export var fullHealthIcon: Texture2D
@export var emptyHungerIcon: Texture2D
@export var emptyHealthIcon: Texture2D

@onready var gameOverScreen: Control = $gameover
@onready var restartButton: Button = $gameover/restartButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# The game over screen stays clickable while the game is paused.
	gameOverScreen.process_mode = Node.PROCESS_MODE_ALWAYS
	gameOverScreen.visible = false
	restartButton.pressed.connect(_on_restart_pressed)
	if player != null:
		player.stats_changed.connect(_on_player_stats_changed)
		_on_player_stats_changed(player.health, player.hunger)
	else:
		updateHungerUI(5)
		updateHealthUI(5)

func _on_player_stats_changed(health: float, hunger: float) -> void:
	updateHungerUI(int(hunger))
	updateHealthUI(int(health))
	if health <= 0.0:
		showGameOver()

func showGameOver() -> void:
	if gameOverScreen.visible:
		return
	gameOverScreen.visible = true
	get_tree().paused = true

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func updateHungerUI(currentHunger: int) -> void:
	$hunger1.texture = fullHungerIcon if currentHunger >= 1 else emptyHungerIcon
	$hunger2.texture = fullHungerIcon if currentHunger >= 2 else emptyHungerIcon
	$hunger3.texture = fullHungerIcon if currentHunger >= 3 else emptyHungerIcon
	$hunger4.texture = fullHungerIcon if currentHunger >= 4 else emptyHungerIcon
	$hunger5.texture = fullHungerIcon if currentHunger >= 5 else emptyHungerIcon
	
func updateHealthUI(currentHealth: int) -> void:
	$heart1.texture = fullHealthIcon if currentHealth >= 1 else emptyHealthIcon
	$heart2.texture = fullHealthIcon if currentHealth >= 2 else emptyHealthIcon
	$heart3.texture = fullHealthIcon if currentHealth >= 3 else emptyHealthIcon
	$heart4.texture = fullHealthIcon if currentHealth >= 4 else emptyHealthIcon
	$heart5.texture = fullHealthIcon if currentHealth >= 5 else emptyHealthIcon
