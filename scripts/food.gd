extends StaticBody2D
class_name Food

var draggable = false
var offset: Vector2

@onready var floor_raycast: RayCast2D = $FloorRaycast
@onready var health: HealthComponent = $Health
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var type = "";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health.value = 100
	
func _process(delta: float) -> void:
	var dragged = is_dragged()
	if(!dragged):
		if not floor_raycast.is_colliding():
			self.position.y += delta*60

func setSprite() -> void:
	if(health.value < 100 and health.value>=75):
		animated_sprite.set_frame_and_progress(1, animated_sprite.get_process_delta_time())
	elif(health.value < 75 and health.value>=50):
		animated_sprite.set_frame_and_progress(2, animated_sprite.get_process_delta_time())
	elif(health.value < 50 and health.value>=5):
		animated_sprite.set_frame_and_progress(3, animated_sprite.get_process_delta_time())
	elif(health.value < 25 and health.value>0):
		animated_sprite.set_frame_and_progress(4, animated_sprite.get_process_delta_time())
	else:
		queue_free()

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y,
		"health": health.save(),
		"type": type
	}
	return save_dict

func is_dragged() -> bool:
	if(draggable):
		if(Input.is_action_just_pressed("click")):
			offset = get_global_mouse_position() - global_position
		if(Input.is_action_pressed("click")):
			global_position = get_global_mouse_position() - offset
		elif(Input.is_action_just_released("click")):
			return false
	return false

func _on_mouse_entered() -> void:
	# TODO: Presentar info de los datos mas importprint_tree()
	draggable = true
	print(draggable)


func _on_mouse_exited() -> void:
	draggable = false
