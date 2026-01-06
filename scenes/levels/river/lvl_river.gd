extends Node3D

@onready var _animation_player = $Fade/AnimationPlayer

func restart():
	_animation_player.play("fade_in_red")
	await _animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/levels/river/lvl_river.tscn")

func on_river_passed():
	await get_tree().create_timer(1.0).timeout
	_animation_player.play("fade_in")
	await _animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/levels/izba/level_les.tscn")

func _ready() -> void:
	Events.killzone_touched.connect(restart)
	Events.river_passed.connect(on_river_passed)
