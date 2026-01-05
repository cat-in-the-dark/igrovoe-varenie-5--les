extends Node3D

@onready var _animation_player: AnimationPlayer = $Fade/AnimationPlayer
@onready var player: Player = $Player
var is_done = false

func _physics_process(_delta: float) -> void:
	if player.rotation_degrees.y > 15:
		player.rotation_degrees.y = 15
	if player.rotation_degrees.y < -15:
		player.rotation_degrees.y = -15

func on_quest_done():
	is_done = true
	_animation_player.play("fade_in")
	await _animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/levels/lvl1_ les_izba/level_les.tscn")

func _on_target_body_entered(body: Node3D) -> void:
	if body is Player and not is_done:
		on_quest_done()
