class_name TrackManager extends Node2D

@export var road_tile_base: PackedScene

func init(start_position: Vector2):
	var tile_height = 256  # Odstęp między kafelkami, dopasuj do wysokości kafelka

	for i in range(5):
		var tile = road_tile_base.instantiate()
		add_child(tile)
		tile.position = start_position - Vector2(0, i * tile_height)
