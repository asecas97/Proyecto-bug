extends Node2D
class_name HungerComponent

var value = 0
var voracity = 0
@export var diet_type = ""
var hunger_delta: float = 0.0
var eating: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!eating):
		hunger_delta += delta
		if(int(hunger_delta)%4 == 0 && int(hunger_delta) != 0):
			hunger_delta = 0
			value += 1
	else:
		hunger_delta = 0.0

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"value": value,
		"voracity": voracity,
		"diet_type": diet_type
	}
	return save_dict
