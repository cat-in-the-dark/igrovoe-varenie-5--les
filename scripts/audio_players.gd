extends Node

@onready var backgound: AudioStreamPlayer = $Background
@onready var golosa: AudioStreamPlayer = $Golosa
@onready var arfa: AudioStreamPlayer = $Arfa

func on_les_entered() -> void:
	golosa.bus = "Master"
	
func on_izba_entered() -> void:
	pass

func _ready() -> void:
	Events.les_entered.connect(on_les_entered)
	Events.izba_entered.connect(on_izba_entered)
