extends Camera2D

@export var target: Node2D  # tu przypiszesz Car w edytorze

func _process(delta: float) -> void:
	if target:
		global_position = target.global_position
