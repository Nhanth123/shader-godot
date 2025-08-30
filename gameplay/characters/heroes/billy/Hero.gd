extends CharacterBody2D

const IS_SHOOTING = "IS_SHOOTING"
@onready var takeDamageArea: Area2D = $TakeDamageArea
@onready var shootingRange: Area2D = $ShootingRange
@onready var heroSprite: Sprite2D = $HeroSprite2D
@onready var shootingRangeRadius: CollisionShape2D = $ShootingRange/CollisionShape2D
@onready var camera: Camera2D = $Camera2D
@onready var healthbar: TextureProgressBar = $CanvasLayer/Control/VContainer/MarginHealthbar/TextureProgressBar
@onready var shootTimer: Timer = $TakeAndGiveDamageTimer
@onready var Grenade = preload("res://components/grenade/grenade.tscn");
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var BloodBig = preload("res://components/big_blood/blood_big.tscn")	
@onready var HeroBodyExplode = preload("res://characters/heroes/billy/effects/hero_body_explosion/hero_body_explode.tscn")	
@onready var mist =	$CanvasLayer/Mist;
var magnitude = 300
var night_vision_ratio = -0.0001;
var dmg = 30
const max_hitpoints = 100.0;
var hitpoints = 100.0: 
	set(val):
		if dead: return;
		hitpoints = val
		damage_taken.emit(hitpoints)
		# animationPlayer.play("VIEWPORT_BLOOD")
		#heroSprite.material.set("shader_parameter/dmg_progress", 1.0 - hitpoints / max_hitpoints);
		
		if hitpoints <= 0:

			hero_dies()
			dead = true;
			
var moveToPosition: Vector2 = position
var shootingTarget: CharacterBody2D
var dead = false;

	
func _process(_delta):
	if is_instance_valid(self):
		camera.global_position = global_position
		
signal damage_taken(hitpoints_left: int)

func _ready():
	self.damage_taken.connect(_update_canvas_layer_healthbar)

func _update_canvas_layer_healthbar(hitpoints_left):
	if dead: return;
	healthbar.value = hitpoints_left
	
func _input(event):
	if event.is_action_pressed("click") and !dead:
		moveToPosition = get_global_mouse_position()
		
func _physics_process(delta):
	#mist.material.set("shader_parameter/camera_pos", camera.get_screen_center_position());
	
	if dead: return;
	
	velocity = position.direction_to(moveToPosition) * magnitude

	if position.distance_to(moveToPosition) > 10:
		move_and_slide()
		
	if is_instance_valid(shootingTarget):
		var target_position = shootingTarget.transform.origin
		var new_transform = transform.looking_at(target_position)
		transform  = transform.interpolate_with(new_transform, 8.0 * delta)
		
	# reset to null when target is no more
	elif shootingTarget != null and !is_instance_valid(shootingTarget):
		shootingTarget = null
		
	#if night_vision_ratio >= 0.0  and night_vision_ratio <= 1.0:
		#RenderingServer.global_shader_parameter_set("night_vision_ratio", night_vision_ratio)
	
	
func _on_take_damage_timer_timeout():
	if dead: return;
	# target closest zombie 
	var zombies_in_range: Array[Node2D] = shootingRange.get_overlapping_bodies()
	var new_target = null
	for zombie_in_range in zombies_in_range:
		if zombie_in_range.is_in_group("zombie"):
			var distance = position.distance_to(zombie_in_range.position)
			if new_target == null or distance < position.distance_to(new_target.position):
				new_target = zombie_in_range
	
	shootingTarget = new_target
			
	# deal damage to target zombie
	if is_instance_valid(shootingTarget):
		animationPlayer.play(IS_SHOOTING)
		shootingTarget.hitpoints -= dmg


	# take damage if zombies in damage range
	var attacking_zombies = takeDamageArea.get_overlapping_bodies()
	for zombie in attacking_zombies:
		if zombie.is_in_group("zombie"):
			hitpoints -= zombie.dmg
			

func _on_button_grenade_pressed():
	print("grenade pressed")
	if is_instance_valid(shootingTarget):

		var grenade = Grenade.instantiate();
		grenade.global_position = global_position
		grenade.target = shootingTarget
		
		get_tree().current_scene.add_child(grenade)
		grenade.z_index = 0;
		grenade.connect("explode", _think_my_grenade_just_went_off)

func _think_my_grenade_just_went_off():
	camera.shake()
	pass;
	
func _on_night_vision_rifle_pressed():

	#var new_ratio = night_vision_ratio
	#if new_ratio <= 0.0:
		#new_ratio = 1.1
		#shootTimer.wait_time = 0.2
		#shootingRangeRadius.shape.radius = 500.0;
		#dmg = 5
	#else:
		#new_ratio = -0.1
		#shootTimer.wait_time = 1.0
		#shootingRangeRadius.shape.radius = 300.0;
		#dmg = 30
		#
	#var tween = get_tree().create_tween()
	#tween.tween_property(self, "night_vision_ratio", new_ratio, 2.0)
	pass
	
func hero_dies():
	var heroBodyExplode = HeroBodyExplode.instantiate()
	get_tree().current_scene.add_child(heroBodyExplode)
	heroBodyExplode.global_position = global_position
	heroBodyExplode.emitting = true

	var bloodBig = BloodBig.instantiate()
	get_tree().current_scene.add_child(bloodBig)
	bloodBig.global_position = global_position
	bloodBig.emitting = true
	#RenderingServer.global_shader_parameter_set("night_vision_ratio", 0.0)
	visible = false

