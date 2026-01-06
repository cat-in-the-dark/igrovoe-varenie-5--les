extends Node

@onready var _animation_player: AnimationPlayer = $Fade/AnimationPlayer
@onready var player: Player = $Player
@onready var izba: IzbaDoor = $IzbaDoor

var izba_distance: float

func _ready() -> void:
	Events.izba_entered.connect(func on_izba_entered() -> void:
		await get_tree().create_timer(1.0).timeout
		_animation_player.play("fade_in")
		await _animation_player.animation_finished
		get_tree().change_scene_to_file("res://scenes/levels/win/win.tscn")
	)
	izba_distance = izba.global_position.distance_to(player.global_position)

func is_looking_at(observer: Node3D, target: Node3D, threshold: float = 0.90) -> bool:
	var direction_to_target = (target.global_position - observer.global_position).normalized()
	var forward = -observer.global_transform.basis.z  # forward в Godot — это -Z
	return forward.dot(direction_to_target) > threshold

func is_in_field_of_view(observer: Node3D, target: Node3D, fov_degrees: float = 60.0) -> bool:
	var direction_to_target = (target.global_position - observer.global_position).normalized()
	var forward = -observer.global_transform.basis.z
	var angle = forward.angle_to(direction_to_target)
	return angle < deg_to_rad(fov_degrees)

func _physics_process(_delta: float) -> void:
	# to avoid jumping once you look at izba. But play sound with some threshold of view
	var is_looking = is_looking_at(player, izba)
	if is_looking:
		izba.set_volume(false)
	else:
		izba.set_volume(true)

	var is_in_fov = is_in_field_of_view(player, izba)
	var dir := (izba.global_position - player.global_position).normalized()
	if is_in_fov:
		izba.global_position = player.global_position + dir * izba_distance
	else:
		var dist = izba.global_position.distance_to(player.global_position)
		if dist > izba_distance:
			izba.global_position = player.global_position + dir * izba_distance 
