class_name TrashBucket extends StaticBody2D

@onready var area_2d: Area2D = $Area2D
@export var player: Player
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var pick_up_sound: AudioStreamPlayer2D = $PickUpSound

var buckets = {
	0 : {
		"type": "PaperAndCardboard",
		"color": "#f67a74"
	},
	1 : {
		"type": "Metals",
		"color": "#f3e068"
	},
	2 : {
		"type": "Organico",
		"color": "#a66d20"
	},
	3 : {
		"type": "Plastico",
		"color": "#ffffff"
	}
}
var current_bucket
var current_bucket_key = 0

func _ready() -> void:
	area_2d.body_entered.connect(_on_area_2d_body_entered)
	set_bucket()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if current_bucket.type == "PaperAndCardboard":
		if body is PaperAndCardboard: #PaperAndCardboard
			pick_up_sound.play()
			player.coins += 1
			print(player.coins)
	if current_bucket.type == "Metals":
		if body is Metals: #PaperAndCardboard
			pick_up_sound.play()
			player.coins += 4
			print(player.coins)
	if current_bucket.type == "Organico":
		if body is Organic: #PaperAndCardboard
			pick_up_sound.play()
			player.coins += 2
			print(player.coins)
	if current_bucket.type == "Plastico":
		if body is Plastic: #PaperAndCardboard
			pick_up_sound.play()
			player.coins += 3
			print(player.coins)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("change_bucket"):
		current_bucket_key += 1
		if current_bucket_key >= buckets.size():
			current_bucket_key = 0
		set_bucket()

func set_bucket():
	current_bucket = buckets[current_bucket_key]
	sprite_2d.self_modulate = current_bucket.color
	print(current_bucket.type)
