extends Node2D
class_name HungerComponent

var value = 0
var voracity = 0
var diet_type = ""
var hunger_delta: float = 0.0
var eating: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!eating):
		hunger_delta += delta
		if(int(hunger_delta)%2 == 0 && int(hunger_delta) != 0):
			print("Hunger: "+str(value))
			hunger_delta = 0
			value += 1
	else:
		hunger_delta = 0.0
