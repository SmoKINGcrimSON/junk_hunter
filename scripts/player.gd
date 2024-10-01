class_name Player extends CharacterBody2D

var coins : int = 0
const SPEED = 200.0
var direction : int
var is_facing_right: bool = true  # Variable para saber la dirección actual
@onready var run_sprites: Sprite2D = $Run_sprites
@onready var idle_sprites: Sprite2D = $Idle_sprites
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var trash_bucket: TrashBucket
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
var max_hp: int
var hp: int

func _init() -> void:
	max_hp = 10
	hp = max_hp

func _ready() -> void:
	idle_sprites.visible = true
	run_sprites.visible = false

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("left", "right")
	if direction < 0:
		run_sprites.flip_h = true
		idle_sprites.flip_h = true
	elif direction > 0:
		run_sprites.flip_h = false
		idle_sprites.flip_h = false
	self.velocity = Vector2(SPEED * direction, 0)
	if self.velocity.x > 0 or self.velocity.x < 0:
		idle_sprites.visible = false
		run_sprites.visible = true
		animation_player.play("run")
	else:
		idle_sprites.visible = true
		run_sprites.visible = false
		animation_player.play("idle")
	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left") and is_facing_right:
		collision_shape.position.x = -11
		trash_bucket.position.x *= -1
		is_facing_right = false
	elif Input.is_action_just_pressed("right") and not is_facing_right:
		collision_shape.position.x = 11
		trash_bucket.position.x *= -1
		is_facing_right = true

func _process(delta: float) -> void:
	pass
