class_name RaceManager extends Node2D

@onready var track_manager: TrackManager = $TrackManager

var starting_position = Vector2(254,800)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	track_manager.init(starting_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
