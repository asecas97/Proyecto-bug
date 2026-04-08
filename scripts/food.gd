extends StaticBody2D
class_name Food

@onready var floor_raycast: RayCast2D = $FloorRaycast
@onready var health: HealthComponent = $Health
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var type = "";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health.value = 100
	
func _process(delta: float) -> void:
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
