extends Node2D

@export var speed: float = 100.0  # prędkość w pikselach na sekundę

func _process(delta: float) -> void:
	# Ruch do przodu w kierunku, w którym obrócony jest pojazd (lokalna oś Y)
	position -= transform.y.normalized() * speed * delta

func _on_button_left_pressed() -> void:
	rotation += deg_to_rad(-90)
	
func _on_button_right_pressed() -> void:
	rotation += deg_to_rad(90)
