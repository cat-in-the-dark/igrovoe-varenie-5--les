class_name Tile
extends Node3D

@onready var tree_prefab: PackedScene = preload("res://scenes/main/trees/tree.tscn")

var size: float = 24
var spacing: float = 4
var jitter: float = 1

func generate_points(x: float, y: float) -> Array[Vector2]:
	var points: Array[Vector2] = []
	for xi in range(x, x+size, spacing):
		for yi in range(y, y+size, spacing):
			points.append(Vector2(
				xi + jitter * spacing * (randf() - 0.5),
				yi + jitter * spacing * (randf() - 0.5)
			))
	return points

func spawn_object(points: Array[Vector2]):
	for i in len(points):
		var point = points[i]
		var obj: Node3D = tree_prefab.instantiate()
		self.add_child(obj)
		obj.position = Vector3(point.x, 0, point.y)
		if i % 5 == 0:
			# next frame for performance
			await get_tree().process_frame

func  _ready() -> void:
	var points = generate_points(0, 0)
	spawn_object(points)
