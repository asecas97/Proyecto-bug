extends CanvasLayer

@onready var game_manager: Node = %GameManager

func _on_button_pressed() -> void:
	game_manager.save_game()
