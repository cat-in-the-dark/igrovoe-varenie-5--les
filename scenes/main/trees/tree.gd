extends Node3D

@onready var sprites: Array[Sprite3D] = [
	$Tree1, $Tree2, $Elka, $Kust
]

func _ready() -> void:
	# disable all sprites because we have always one enabled for godot editor visualisation
	for sprite in sprites:
		sprite.visible = false

	var sprite: Sprite3D = sprites.pick_random()
	sprite.visible = true
