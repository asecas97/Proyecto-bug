extends Camera2D

var edge_margin = 50.0
var movement_speed = 300.0

var screen_size: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var touch_position = get_viewport().get_mouse_position() # Obtiene la posición del ratón/toque
	# Comprueba si el toque está cerca de los bordes y mueve la cámara
	var movement_direction = Vector2.ZERO
	if touch_position.x < edge_margin:
		movement_direction.x -= 1
	elif touch_position.x > screen_size.x - edge_margin:
		movement_direction.x += 1
	if touch_position.y < edge_margin:
		movement_direction.y -= 1
	elif touch_position.y > screen_size.y - edge_margin:
		movement_direction.y += 1
	# Normaliza la dirección para evitar movimientos más rápidos en diagonal y aplica velocidad
	if movement_direction != Vector2.ZERO:
		movement_direction = movement_direction.normalized() * movement_speed * delta
		# Mueve la cámara
		global_position += movement_direction
