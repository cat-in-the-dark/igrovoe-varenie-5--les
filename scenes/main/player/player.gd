class_name Player
extends CharacterBody3D

@onready var _camera: Camera3D = $Camera3D
@export_range(0.0, 10.0) var joystick_sensitivity := 2.5
@export_range(0.0, 1.0) var mouse_sensitivity := 0.25

func _move_cmd() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_forward", "move_back", 0.4)

func _camera_cmd() -> Vector2:
	return Input.get_vector("camera_left", "camera_right", "camera_up", "camera_down", 0.2)
	
func _handle_camera_joystic_move() -> Vector3:
	var raw_input := self._camera_cmd()
	var _camera_input_direction := Vector2.ZERO
	_camera_input_direction.x = -raw_input.x * joystick_sensitivity
	#_camera_input_direction.y = -raw_input.y * joystick_sensitivity
	return Vector3(_camera_input_direction.y, _camera_input_direction.x, 0)

func _handle_move_direction() -> Vector3:
	var move_input := self._move_cmd()
	var forward := _camera.global_basis.z
	var right := _camera.global_basis.x
	var move_direction := forward * move_input.y + right * move_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	return move_direction

func _process(delta: float) -> void:
	var rot_dir = _handle_camera_joystic_move()
	self.global_rotation += rot_dir * delta
	
	var move_dir = _handle_move_direction()
	velocity = velocity.move_toward(move_dir * 4.0, 20.0 * delta)
	
	move_and_slide()
