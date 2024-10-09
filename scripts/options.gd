extends Control

func _on_regresar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_volumen_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/volume.tscn")
