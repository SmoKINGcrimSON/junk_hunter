extends Node

@export var player: Player
var trash_bucket: TrashBucket
@onready var label: Label = $Label
@onready var change_bucket: TouchScreenButton = $"."

func _ready() -> void:
	trash_bucket = player.trash_bucket

func _physics_process(delta: float) -> void:
	change_bucket.self_modulate = trash_bucket.current_bucket.color
	label.text = trash_bucket.current_bucket.type
