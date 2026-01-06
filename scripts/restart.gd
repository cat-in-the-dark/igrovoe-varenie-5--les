extends Node

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file("res://scenes/levels/enter_les/lvl0.tscn")
