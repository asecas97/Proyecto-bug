extends StaticBody2D
class_name FoodComponent

@onready var health_component: HealthComponent = $HealthComponent
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_component.value = 100

func setSprite() -> void:
	print(health_component.value)
	if(health_component.value < 100 and health_component.value>=75):
		animated_sprite.set_frame_and_progress(1, animated_sprite.get_process_delta_time())
	elif(health_component.value < 75 and health_component.value>=50):
		animated_sprite.set_frame_and_progress(2, animated_sprite.get_process_delta_time())
	elif(health_component.value < 50 and health_component.value>=5):
		animated_sprite.set_frame_and_progress(3, animated_sprite.get_process_delta_time())
	elif(health_component.value < 25 and health_component.value>0):
		animated_sprite.set_frame_and_progress(4, animated_sprite.get_process_delta_time())
	else:
		queue_free()
