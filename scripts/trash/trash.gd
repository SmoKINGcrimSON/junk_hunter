class_name Trash extends CharacterBody2D

@export var collision_shape_2d: CollisionShape2D
@export var sprite_2d: Sprite2D
var speed: Vector2
var player: Player

func _init() -> void:
	speed = Vector2(0, 2000)

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity = speed * delta
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision:
			var collider = collision.get_collider()
			if collider is TileMap:
				player.hp -= 1
			elif collider is TrashBucket:
				_is_correct_trashbucket(collider as TrashBucket)
			queue_free()
	move_and_slide()

func _is_correct_trashbucket(trash_bucket: TrashBucket):
	pass
