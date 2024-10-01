extends Area2D

var distancia : float
var direccion : Vector2
var index : int = -1
@onready var rango: Sprite2D = $Rango
@onready var palanca: Sprite2D = $Palanca
@onready var radio: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed() and index == -1:
			#si se acaba de presionar, global_position -> centro del joystick
			distancia = global_position.distance_to(event.position)
			if distancia < radio.shape.radius:
				index = event.index
				palanca.global_position = event.position
				direccion = (global_position.direction_to(palanca.global_position) * distancia) / radio.shape.radius
		elif event.index == index:
			#si se acaba de soltar
			release_actions()
			distancia = 0
			index = -1
			palanca.position = Vector2.ZERO
			direccion = Vector2.ZERO
	if event is InputEventScreenDrag:
		#si se arrastró el dedo
		if event.index == index:
			distancia = global_position.distance_to(event.position)
			if distancia <= radio.shape.radius:
				palanca.global_position = event.position		
				direccion = (global_position.direction_to(palanca.global_position) * distancia) / radio.shape.radius #vector en el rango deseado
			else:
				direccion = global_position.direction_to(event.position)
				palanca.position = direccion * radio.shape.radius
				
	var angle : float = (direccion * Vector2(1, -1)).angle()
	if distancia > 10 and distancia < radio.shape.radius:
		release_actions()
		if angle >= PI / 4 * -1 and angle <= PI / 4:
			Input.action_press("right")
		#elif angle <= PI * 3 / 4 and angle >= PI / 4:
		#	Input.action_press("up")
		elif angle >= PI * 3 / 4 or angle <= PI * 3 / 4 * -1:
			Input.action_press("left")
		#elif angle <= PI / 4 * -1 and angle >= PI * 3 / 4 * -1:
		#	Input.action_press("down")
			
func release_actions():
	Input.action_release("right")
	Input.action_release("left")
	#Input.action_release("up")
	#Input.action_release("down")
