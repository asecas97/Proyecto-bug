extends Node2D
class_name Bug

var speed = 40
var move_delta: float = 0.0
var eating_delta: float = 0.0

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast: RayCast2D = $RayCast2D
@onready var health: HealthComponent = $Health
@onready var hunger: HungerComponent = $Hunger
@onready var energy: EnergyComponent = $Energy
@onready var game_manager: Node = %GameManager

func _ready() -> void:
	health.value = 100
	energy.value = 100
	hunger.voracity = 2
	hunger.diet_type = "carnivorous"
	animated_sprite.animation = "move"
	animated_sprite.set_frame_and_progress(0, 0.0)
	
func _process(delta: float) -> void:
	move_delta += delta
	eating_delta += delta
	if(ray_cast.is_colliding()):
		if(ray_cast.get_collider() is FoodComponent && (hunger.value >= 25 or hunger.eating)):
			stop()
			if(int(eating_delta) % 1 == 0 && int(eating_delta) != 0):
				eating_delta = 0.0
				eat(ray_cast.get_collider())
			return
	if(hunger.value >= 50 and !hunger.eating):
		var food = game_manager.getNearestFood(position.x, position.y)
		nav_agent.target_position = food.get_position()
		move_delta = 0.0
		move(delta)
	elif(int(move_delta) % 4 == 0 && int(move_delta) != 0 && nav_agent.is_navigation_finished()):
		move_delta = 0.0
		random_move(delta)
	else:
		if(nav_agent.is_navigation_finished()):
			stop()
		else:
			if(!hunger.eating):
				move_delta = 0.0
				move(delta)
	
func random_move(delta:float):
	var random_x = randf_range(-400, 400)
	var random_y = randf_range(-400, 400)
	nav_agent.target_position = Vector2(random_x,random_y)
	move(delta)

func move(delta:float):
	var new_velocity: Vector2 = global_position.direction_to(nav_agent.get_next_path_position())
	position += new_velocity * delta * speed
	animated_sprite.rotation = new_velocity.angle()
	ray_cast.rotation = new_velocity.angle()
	animated_sprite.play("move")
	
func eat(comida: FoodComponent):
	var food = game_manager.eat(comida, hunger.voracity)
	hunger.value -= food
	if(hunger.value == 0 or food == 0):
		hunger.eating = false
	else:
		hunger.eating = true
		nav_agent.target_position = self.position

func stop():
	nav_agent.target_position = self.position
	if(animated_sprite.animation != "idle"):
		animated_sprite.play("idle")
