extends CharacterBody2D

var magnitude = 100
var target_hero: CharacterBody2D
@onready var zombieSprite: Sprite2D = $ZombieSprite2D
@onready var BloodBig = preload("res://gameplay/components/big_blood/blood_big.tscn")	
@onready var ZombieBodyExplode = preload("res://gameplay/characters/enemies/zombie_walker/effects/zombie_body_explode/zombie_body_explode.tscn")	
@onready var lightOccluder2D: LightOccluder2D = $LightOccluder2D
@onready var shadow: Sprite2D = $Shadow;
@onready var animation_player: AnimationPlayer = $AnimationPlayer;
@onready var blood_small = $BloodSmall
var hp_left = 1.0:
	set(val):
		hp_left = val;
		if hp_left <= 0.0:
			queue_free()
			pass
		elif hp_left < 0.3:
			lightOccluder2D.visible = false;
			shadow.visible = false	
var max_hitpoints = 40.0;
var hitpoints = 40.0:
	set(val):
		hitpoints = val

		if hitpoints <= 0.0:
			# emit location of deadth for world_blood_shader
			zombie_dies()
			pass
			 #queue_free() # remove when enabling zombie_dies
		else:
			# take damage shader
			animation_player.play("flash_hit")
			blood_small.emitting = true
			
		damage_effect()			
var dmg = 10
		
func _physics_process(_delta):
	if target_hero != null and is_instance_valid(target_hero) and !target_hero.dead:
		velocity = position.direction_to(target_hero.position) * magnitude
		look_at(target_hero.position)
		
		if position.distance_to(target_hero.position) > 1:
			move_and_slide()

func set_hp_left_shader(val: float):
	hp_left = val;
	#zombieSprite.material.set("shader_parameter/hp_left", val);
	
func damage_effect():
	var amount_of_damage = (hitpoints / max_hitpoints) + 0.3;
	var tween_amount = amount_of_damage if(hitpoints > 0.0) else 0.0
	var tween_anim_time = 0.3 if(hitpoints > 0.0) else 0.4

	var tween = get_tree().create_tween()
	tween.tween_method(set_hp_left_shader, hp_left, tween_amount, tween_anim_time)
	
func die():
	self.hitpoints = 0;
	
func zombie_dies(free = false, big = false):
	
	var zombieBodyExplode = ZombieBodyExplode.instantiate()
	get_parent().add_child(zombieBodyExplode)
	zombieBodyExplode.global_position = global_position
	if big:
		zombieBodyExplode.amount = 15
		
	zombieBodyExplode.emitting = true

	var bloodBig = BloodBig.instantiate()
	get_parent().add_child(bloodBig)
	bloodBig.global_position = global_position
	bloodBig.emitting = true
	
	#ShaderService.zombie_died.emit(global_position)
	
	if free:
		queue_free()
