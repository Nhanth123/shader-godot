extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func preload_shaders_with_progress(shaders):
	# might not work yet, not tested
	# idea show a cool fragmented halucination shader with a zombie head in middle as loading indicator
	var total_shaders = shaders.size()
	for i in range(total_shaders):
		var shader_path = shaders[i]
		load(shader_path)
		# Optionally, do something each poll, like updating a loading bar
		await get_tree().idle_frame
		update_progress((i + 1) / total_shaders)
		
	show_loading_complete() # Hide loader or show a message when done

func update_progress(done_loading_amount):
	pass

func show_loading_complete():
	pass
	
	
