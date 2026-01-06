class_name KillZone
extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		Events.killzone_touched.emit()
