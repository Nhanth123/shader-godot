extends TextureRect

@export var camera: Camera2D;
@onready var original_viewport_size = get_rect().size;

func _ready():
	get_viewport().size_changed.connect(_on_viewport_resized)
	
	#if camera.zoom.y == camera.zoom.x:
		#material.set("shader_parameter/zoom", camera.zoom.x);
		#material.set("shader_parameter/viewport_scale", Vector2(1.0, 1.0));

func get_viewport_resize():
	return  get_rect().size / original_viewport_size
	
func _on_viewport_resized():
	var _new_viewport_size = get_viewport_resize();
	#material.set("shader_parameter/viewport_scale", new_viewport_size);
