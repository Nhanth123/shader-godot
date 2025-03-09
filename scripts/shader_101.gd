extends Node

@onready var sprite_2d: Sprite2D = $Sprite2D

#func _process(_delta: float) -> void:
	#var TIME = Time.get_ticks_msec() / 1000.0
	#print("TIME: " + str(TIME))

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("set_speed"):
		var new_speed = randf_range(1.0, 10.0)
		var new_color = Vector4(1.0, 0.0, 0.0, 1.0)
		sprite_2d.material.set_shader_parameter("my_color", new_color)
		#print(new_speed)
