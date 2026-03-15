extends Node2D

@onready var game_manager: Node2D = %GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager.load_game()
	pass
