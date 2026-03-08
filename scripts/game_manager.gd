extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func eat(comida: Food, voracity: int) -> int:
	if(comida.health_component.value < voracity):
		voracity = comida.health_component.value
		comida.health_component.value = 0
	else:
		comida.health_component.value -= voracity
	comida.setSprite()
	return voracity

func getNearestFood(x_position:int,y_position:int, bug:Bug)-> Food:
	var foods_node: Node = $"../Foods"
	var foods = foods_node.get_children(false)
	if(foods.size() > 0):
		var nearest_food = foods[0]
		var distance_to_the_nearest_food = abs(x_position - nearest_food.position.x) + abs(y_position - nearest_food.position.y)
		var distance_to_the_food = 0
		for food in foods:
			if(food.type == bug.hunger.diet_type):
				distance_to_the_food = abs(x_position - food.position.x) + abs(y_position - food.position.y)
				if(distance_to_the_food<distance_to_the_nearest_food):
					nearest_food = food
					distance_to_the_nearest_food= distance_to_the_food
		return nearest_food
	return null

func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)

		# Store the save dictionary as a new line in the save file.
		save_file.store_line(json_string)
