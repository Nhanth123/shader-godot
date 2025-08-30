extends Sprite2D

@export var camera: Camera2D
@onready var scale_factor_viewport = Vector2(camera.get_viewport().size) / get_rect().size;
var death_positions = []
var death_time = []


func _ready():
	# Initialize size of Sprite2D with viewport
	set_scale(scale_factor_viewport + Vector2(0.3, 0.3))
	# Listen to resize events of viewport
	get_viewport().size_changed.connect(_on_viewport_resized)
	
	ShaderService.zombie_died.connect(on_zombie_death)
	# Initialize the shader parameters
	#material.set_shader_parameter("death_positions", PackedVector2Array(death_positions))

func get_viewport_resize():
	return Vector2(camera.get_viewport().size) / get_rect().size
	
func _physics_process(_delta):
	global_position = camera.get_screen_center_position()
	
func _on_viewport_resized():
	set_scale(get_viewport_resize() + Vector2(0.3, 0.3))
	
func on_zombie_death(death_pos):
	death_positions.append(death_pos)
	var time_of_death = int(Time.get_ticks_msec() / 1000.0);

	death_time.append(time_of_death)
	if death_positions.size() > 60:
		death_positions.pop_front() # Keep the array size within limits
		death_time.pop_front()
		print("limit reached, remove oldest in array")
	
	# Update the shader parameter
	#material.set_shader_parameter("death_positions", PackedVector2Array(death_positions))
	#material.set_shader_parameter("death_time", PackedInt32Array(death_time))
	#material.set_shader_parameter("death_count", death_positions.size())
	
