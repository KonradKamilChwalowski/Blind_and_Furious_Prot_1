class_name TrackManager extends Node2D

# Tile bases
@export var road_tile_S: PackedScene
@export var road_tile_M: PackedScene
@export var road_tile_L: PackedScene
@export var road_tile_R: PackedScene

var track_segments_codes := ['S1','S3','L1','R1'] # Array of codes for track generator
var tile_height: float = 256  # Odstęp między kafelkami, dopasuj do wysokości kafelka
var current_tile_position: Vector2
var current_tile_direction := Vector2(0, -tile_height)
var current_rotation: int = 0

func init(start_position: Vector2):
	position = start_position
	current_tile_position = position
	build_the_track(generate_track_seed())
	#build_the_track()

func generate_track_seed(n: int = 4) -> String:
	var wynik := 'S1'
	for i in n:
		wynik += track_segments_codes[randi() % track_segments_codes.size()]
	
	# Add finishing line
	wynik += 'S1'
	wynik += 'M1'
	print(wynik)
	return wynik

	# Reads components from the seed, and than builds each one
func build_the_track(track_seed: String = "S2R1S1L1S1M1") -> void:
	var i_count = 0 # Counts if char is letter or number
	var action_type_1: String
	var action_type_2: String
	
	for seed_sign in track_seed:
		# Reads type and number of actions
		i_count += 1
		if (i_count % 2) == 1: # Not even sign
			action_type_1 = seed_sign
		else: # Even sign
			action_type_2 = seed_sign
		
		if (i_count % 2) == 0: # Even sign
			build_segment(action_type_1, action_type_2)

	# Builds one segment of the track (one segment can be build by multiple tiles)
func build_segment(action_type_1: String, action_type_2: String) -> void:
	print(current_rotation, current_tile_direction)
	if action_type_1 == 'S':
		for i in range(int(action_type_2)):
			var tile = road_tile_S.instantiate()
			add_child(tile)
			tile.position = current_tile_position
			tile.rotation += deg_to_rad(current_rotation)
			current_tile_position += current_tile_direction
	
	if action_type_1 == 'M':
		var tile = road_tile_M.instantiate()
		add_child(tile)
		tile.position = current_tile_position
		tile.rotation += deg_to_rad(current_rotation)
		current_tile_position += current_tile_direction
	
	if action_type_1 == 'L' and action_type_2 == '1':
		
		var tile = road_tile_L.instantiate()
		add_child(tile)
		tile.position = current_tile_position
		tile.rotation += deg_to_rad(current_rotation)
		# Rotation to the left
		current_rotation += -90
		current_tile_direction = current_tile_direction.rotated(deg_to_rad(-90))
		current_tile_position += current_tile_direction
		
	if action_type_1 == 'R' and action_type_2 == '1':
		
		var tile = road_tile_R.instantiate()
		add_child(tile)
		tile.position = current_tile_position
		tile.rotation += deg_to_rad(current_rotation)
		# Rotation to the left
		current_rotation += 90
		current_tile_direction = current_tile_direction.rotated(deg_to_rad(90))
		current_tile_position += current_tile_direction
