extends Node2D

@export var speed: float = 100.0  # prędkość w pikselach na sekundę

var waiting_time: float
var rotation_degree: float = deg_to_rad(0)

func _process(delta: float) -> void:
	# Ruch do przodu w kierunku, w którym obrócony jest pojazd (lokalna oś Y)
	position -= transform.y.normalized() * speed * delta



func _on_button_left_pressed() -> void:
	rotation_degree = deg_to_rad(-90)
	
func _on_button_right_pressed() -> void:
	rotation_degree = deg_to_rad(90)

func _on_button_000_pressed() -> void:
	waiting_time = 0.0
	
func _on_button_100_pressed() -> void:
	waiting_time = 1.0

func _on_button_200_pressed() -> void:
	waiting_time = 2.0

func _on_button_300_pressed() -> void:
	waiting_time = 3.0

func _on_add_driving_command_pressed() -> void:
	await get_tree().create_timer(waiting_time).timeout  # czeka 2 sekundy
	rotation += rotation_degree
