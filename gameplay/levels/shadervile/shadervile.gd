extends Node2D
@onready var Zombie = preload("res://characters/enemies/zombie_walker/zombie.tscn")
@onready var spawnspots = [$SpawnLeftTop, $SpawnRightBottom, $SpawnRightTop, $SpawnLeftBottom]
@onready var hero = $Hero;

func _on_timer_timeout():
	if get_node_or_null("Hero") != null:
		for spot in spawnspots:
			var zombie = Zombie.instantiate()
			zombie.target_hero = hero
			add_child(zombie)
			zombie.z_index = 0;
			zombie.global_position = spot.global_position
