class_name IzbaDoor
extends Node3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		# enter in backward movement
		if body.move_input.y >= 0.90:
			Events.izba_entered.emit()
