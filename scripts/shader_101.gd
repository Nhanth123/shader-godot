extends Node

func _process(_delta: float) -> void:
	var TIME = Time.get_ticks_msec() / 1000.0
	print("TIME: " + str(TIME))
