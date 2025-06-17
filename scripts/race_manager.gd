class_name RaceManager extends Node2D

@onready var track_manager: TrackManager = $TrackManager
@onready var command_list_container: VBoxContainer = $"UI/CommandList"
@onready var car: Car = $Car

var starting_position = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	track_manager.init(starting_position)
	car.init(command_list_container)
	
