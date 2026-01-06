extends Node3D

@onready var _animation_player: AnimationPlayer = $Fade/AnimationPlayer
@onready var player: Player = $Player

func on_quest_done():
	_animation_player.play("fade_in")
	await _animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/levels/lvl1_ les_izba/level_les.tscn")

func _physics_process(_delta: float) -> void:
	if player.rotation_degrees.y > 15:
		player.rotation_degrees.y = 15
	if player.rotation_degrees.y < -15:
		player.rotation_degrees.y = -15

func _ready() -> void:
	Events.game_restarted.emit()
	Events.les_entered.connect(on_quest_done)

func _on_target_body_entered(body: Node3D) -> void:
	if body is Player:
		Events.les_entered.emit()
