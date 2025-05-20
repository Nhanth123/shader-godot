extends Node3D

@onready var sphere = $SphereExample

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("set_color"):
		var sphere_mat = sphere.get_active_material(0)
		var random_color = Vector3(randf(), randf(), randf())
		sphere_mat.set_shader_parameter("sphere_color", random_color)
