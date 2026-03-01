extends Control

@onready var play_button: Button = $Buttons/PlayButton
@onready var settings_button: Button = $Buttons/SettingsButton
@onready var exit_button: Button = $Buttons/ExitButton

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Nodes/game.tscn")
