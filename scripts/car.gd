class_name Car extends Area2D

@onready var speedometer: Label = get_node("../UI/Speedometer")

var speed: float = 0.0
var max_speed: float = 600.0
var acceleration: float = 25.0
var waiting_time: float
var rotation_degree: float = 0.0
var is_executing: bool = false
var command_list_container: VBoxContainer
var command_queue: Array = []
var is_on_track: int = 0

func init(cls: VBoxContainer) -> void:
	command_list_container = cls
	await get_tree().create_timer(1.0).timeout # The game is not starting on turn on

func _process(delta: float) -> void:
	# Ruch do przodu w kierunku, w którym obrócony jest pojazd (lokalna oś Y)
	if is_on_track > 0:
		position -= transform.y.normalized() * speed * delta
	if speed < max_speed:
		speed += acceleration * delta
	
	# Update Speedometer
	speedometer.text = "SPEED: %.f" % float(speed/4)



#BUTTONS
func _on_button_left_pressed() -> void:
	rotation_degree = -90
	
func _on_button_right_pressed() -> void:
	rotation_degree = 90

func _on_button_000_pressed() -> void:
	waiting_time = 0.0
	
func _on_button_100_pressed() -> void:
	waiting_time = 1.0

func _on_button_200_pressed() -> void:
	waiting_time = 2.0

func _on_button_300_pressed() -> void:
	waiting_time = 3.0

func _on_add_driving_command_pressed() -> void:
	# ADD new type var - "command", wchich is 2D (delay, rotation) type - to the array
	var command = {
		"delay": waiting_time,
		"rotation": rotation_degree}
	command_queue.append(command)
	
	# Add command to the Label
	var label := Label.new()
	label.text = "Za %.1fs: skręć o %d°" % [waiting_time, rotation_degree]
	command_list_container.add_child(label)
	
	#if there was no command before, execute immediatly
	if not is_executing:
		execute_next_command()

func execute_next_command() -> void:
	# If empty, than there is nothing to do
	if command_queue.is_empty():
		is_executing = false
		return
	# Not empty
	is_executing = true
	var cmd = command_queue.pop_front()
	if command_list_container.get_child_count() > 0:
		command_list_container.get_child(0).queue_free()
		
	await get_tree().create_timer(cmd.delay).timeout
	rotation += deg_to_rad(cmd.rotation)
	
	execute_next_command()

func _on_jump_button_pressed() -> void:
	position -= transform.y.normalized()




#	Collisions
func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	is_on_track += 1
	print("Wszedł w area: ", area.name)

func _on_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	is_on_track -= 1
	print("Opuścił area: ", area.name)
