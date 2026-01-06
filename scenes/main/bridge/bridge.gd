class_name Bridge
extends Node3D

func _on_target_body_entered(body: Node3D) -> void:
	if body is Player:
		Events.river_passed.emit()
