extends StaticBody2D
class_name FoodComponent

@onready var health_component: HealthComponent = $HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_component.value = 100
