extends Node2D 
class_name Bug

var draggable = false
var speed = 40
var move_delta: float = 0.0
var eating_delta: float = 0.0
var finish_pos: int
var offset: Vector2

@onready var floor_raycast: RayCast2D = $FloorRaycast
@onready var head_raycast: RayCast2D = $HeadRaycast
@onready var health: HealthComponent = $Health
@onready var hunger: HungerComponent = $Hunger
@onready var energy: EnergyComponent = $Energy
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager: Node2D = %GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	finish_pos = int(position.x)
	health.value = 100
	energy.value = 100
	hunger.value = 0
	hunger.voracity = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dragged = is_dragged()
	if(!dragged):
		move_delta += delta
		eating_delta += delta
		if not floor_raycast.is_colliding():
			self.position.y += delta*60
		if(head_raycast.is_colliding()):
			if(head_raycast.get_collider() is Food && (hunger.value >= 75 or hunger.eating)):
				stop()
				if(int(eating_delta) % 1 == 0 && int(eating_delta) != 0):
					eating_delta = 0.0
					eat(head_raycast.get_collider())
				return
			else:
				hunger.eating = false
		if(hunger.value >= 90 and !hunger.eating):
			var food = game_manager.getNearestFood(position.x, self)
			finish_pos = food.get_position().x
			move_delta = 0.0
			move(delta)
		elif(int(move_delta) % 4 == 0 && int(move_delta) != 0):
			move_delta = 0.0
			random_move(delta)
		elif(int(position.x) == finish_pos):
			stop()
		else:
			if(!hunger.eating):
				move_delta = 0.0
				move(delta)
			
func is_dragged() -> bool:
	if(draggable):
		if(Input.is_action_just_pressed("click")):
			offset = get_global_mouse_position() - global_position
		if(Input.is_action_pressed("click")):
			global_position = get_global_mouse_position() - offset
		elif(Input.is_action_just_released("click")):
			return false
	return false

func _on_area_2d_mouse_entered() -> void:
	# TODO: Presentar info del nombre y de los datos mas importantes
	draggable = true

func _on_area_2d_mouse_exited() -> void:
	draggable = false

func random_move(delta:float):
	finish_pos = randi_range(-640, 640)
	print(finish_pos)
	move(delta)
	
func move(delta:float):
	var i = -1
	if((position.x-finish_pos) < 0):
		i = 1
		animated_sprite.flip_h = true
		head_raycast.rotation_degrees = 270
	else:
		animated_sprite.flip_h = false
		head_raycast.rotation_degrees = 90
	if(int(position.x) != finish_pos):
		position.x += delta * speed * i
	#animated_sprite.play("move")

func stop():
	if(animated_sprite.animation != "idle"):
		animated_sprite.play("idle")
		
func eat(comida: Food):
	var food = game_manager.eat(comida, hunger.voracity)
	hunger.value -= food
	if(hunger.value == 0 or food == 0 or comida == null):
		hunger.eating = false
	else:
		#animated_sprite.play("eat")
		hunger.eating = true

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y,
		"health": health.save(),
		"hunger": hunger.save(),
		"energy": energy.save()
	}
	return save_dict
