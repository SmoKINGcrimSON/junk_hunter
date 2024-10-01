class_name Plastic extends Trash

func _init() -> void:
	speed = Vector2(0, 2000)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

func _is_correct_trashbucket(trash_bucket: TrashBucket):
	if trash_bucket.current_bucket.type != "Plastico":
		player.hp -= 1
