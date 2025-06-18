class_name RaceManager extends Node2D

@onready var track_manager: TrackManager = $TrackManager
@onready var command_list_container: VBoxContainer = $"UI/CommandList"
@onready var car: Car = $Car
@onready var minimap_view: SubViewport = $"MinimapLayer/MinimapViewport/MinimapView"
@onready var minimap_camera: Camera2D = $"MinimapLayer/MinimapViewport/MinimapView/MinimapCamera"

var starting_position = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	track_manager.init(starting_position)
	car.init(command_list_container)
	minimap_view.world_2d = get_viewport().world_2d
	minimap_camera.zoom = Vector2(0.05, 0.05)
	minimap_camera.make_current()

func _process(delta: float) -> void:
	pass
