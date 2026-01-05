extends Node3D

@export var tile_size: int = 32
@export var tile_prefab: PackedScene

@onready var player: Node3D = $Player

var tiles: Dictionary[Vector2i, Tile] = {}

func world_to_tile_index(pos: Vector3) -> Vector2i:
	var ix = int(floor(pos.x / tile_size))
	var iy = int(floor(pos.z / tile_size))
	return Vector2i(ix, iy)
	
func tile_index_to_world(idx: Vector2i) -> Vector3:
	return Vector3(idx.x * tile_size, 0, idx.y * tile_size)

func _ready() -> void:
	for ch in find_children("*", "Tile", false):
		if ch is Tile:
			var idx := world_to_tile_index(ch.position)
			tiles[idx] = ch
	print(tiles)

func spawn_tile(idx: Vector2i):
	if tiles.get(idx):
		print("Already has a tile here...")
		return
	var tile: Node3D = tile_prefab.instantiate()
	self.add_child(tile)
	tile.position = tile_index_to_world(idx)
	tiles[idx] = tile
	print("New tile at ", idx, " total: ", len(tiles))

func _process(_delta: float) -> void:
	var player_tile = world_to_tile_index(player.position)
	
	for idx in tiles.keys():
		var idx_delta: Vector2i = player_tile - idx
		if abs(idx_delta.x) >= 2 or abs(idx_delta.y) >= 2:
			remove_child(tiles[idx])
			tiles.erase(idx)
			print('Deleted child ', idx)
	
	for i in range(player_tile.x - 1, player_tile.x + 2):
		for j in range(player_tile.y - 1, player_tile.y + 2):
			var idx := Vector2i(i, j)
			if not tiles.get(idx):
				spawn_tile(idx)
