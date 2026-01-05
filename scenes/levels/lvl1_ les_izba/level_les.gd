extends Node

@onready var _animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer

func _ready() -> void:
	Events.izba_entered.connect(func on_izba_entered() -> void:
		await get_tree().create_timer(1.0).timeout
		_animation_player.play("fade_in")
		await _animation_player.animation_finished
		get_tree().change_scene_to_file("res://scenes/levels/lvl0_enter_les/lvl0.tscn")
	)
