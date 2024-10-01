extends Node

var trash: PackedScene
var spawn_interval: float = 2.0
@onready var spawn_timer: Timer = $SpawnTimer
@onready var camera_2d: Camera2D = $Camera2D
var camera_size : Vector2
var trash_scenes = [
	"res://scenes/bottle_1.tscn",
	"res://scenes/fruit_trash_1.tscn",
	"res://scenes/key_trash.tscn",
	"res://scenes/toilet_paper.tscn"
]
@onready var hp: Label = $Control/CanvasLayer/VBoxContainer/HP
@onready var coins: Label = $Control/CanvasLayer/VBoxContainer/COINS
@onready var player: Player = $Player
@onready var tile_map: TileMap = $TileMap

func _ready() -> void:
	##
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_index = rng.randi_range(0, trash_scenes.size() - 1)
	trash = load(trash_scenes[random_index])
	##
	spawn_timer.start()
	var viewport_size = get_viewport().size
	camera_size = Vector2(viewport_size.x / camera_2d.zoom.x, viewport_size.y / camera_2d.zoom.y)
	#get_viewport().set_size(camera_size)

func _on_spawn_timer_timeout() -> void:
	if trash:
		var new_trash = trash.instantiate()
		new_trash = new_trash as Trash
		new_trash.player = player
		var viewport_rect = get_viewport().get_visible_rect()
		new_trash.position = Vector2(randf_range(camera_size.x / 2 * -1, camera_size.x / 2), camera_size.y / 2 * -1)
		print(new_trash.position.x)
		add_child(new_trash)
	##
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_index = rng.randi_range(0, trash_scenes.size() - 1)
	trash = load(trash_scenes[random_index])
	##

func _process(delta: float) -> void:
	hp.text = "HP " + str(player.hp)
	coins.text = "COINS " + str(player.coins)

func _physics_process(delta: float) -> void:
	if player.hp <= 0:
		get_tree().reload_current_scene()
