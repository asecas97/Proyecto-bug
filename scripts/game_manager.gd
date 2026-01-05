extends Node

@onready var timer: Timer = $Timer

var delta_total = 0

func _process(delta: float) -> void:
	if(timer.is_stopped()):
		timer.start()

func _on_timer_timeout() -> void:
	delta_total += 1

func comer(comida: FoodComponent, voracity: int) -> int: 
	if(comida.health_component.value > voracity):
		return comida.health_component.value
	else:
		comida.health_component.value -= voracity
		return voracity

func getNearestFood(x_position:int,y_position:int)-> FoodComponent:
	var foods_node: Node = $"../Foods"
	var foods = foods_node.get_children(false)
	if(foods.size() > 0):
		var nearest_food = foods[0]
		var distance_to_the_nearest_food = abs(x_position - nearest_food.position.x) + abs(y_position - nearest_food.position.y)
		var distance_to_the_food = 0
		for food in foods:
			distance_to_the_food = abs(x_position - food.position.x) + abs(y_position - food.position.y)
			if(distance_to_the_food<distance_to_the_nearest_food):
				nearest_food = food
				distance_to_the_nearest_food= distance_to_the_food
		return nearest_food
	return null
