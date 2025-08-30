extends Sprite2D

const anims = {
	COUNTDOWN = "COUNTDOWN",
	EXPLOSION = "EXPLOSION",
	THROW = "THROW"
}
@onready var explosion_area: Area2D = $ExplosionArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var GroundDistructAnim = preload("res://components/grenade/ground_destruct/ground_distruct_anim.tscn")

var target: Node2D
signal explode

# Called when the node enters the scene tree for the first time.
func _ready():
	if target:
		var dis_to_target = global_position.distance_to(target.global_position);
		var FAR_THROW_DIS = 250.0;
		var FAR_THROW_DUR = 0.6;
		var THROW_DUR = FAR_THROW_DUR / FAR_THROW_DIS * dis_to_target;

		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", target.global_position, THROW_DUR).set_trans(Tween.TRANS_BOUNCE)

		var _anim_dur = 1.0 / THROW_DUR * 0.6

		#animation_player.play(anims.THROW, -1, anim_dur)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == anims.THROW:
		# animation_player.play(anims.COUNTDOWN)
		explode_grenade()
		queue_free()
	if anim_name == anims.COUNTDOWN:
		explode_grenade()
	if anim_name == anims.EXPLOSION:
		queue_free()
		
func explode_grenade():
	explode.emit()
	showExplosion()
	var groundDistructAnim = GroundDistructAnim.instantiate();
	get_tree().current_scene.add_child(groundDistructAnim)
	groundDistructAnim.global_position = global_position
	groundDistructAnim.play()
		
func showExplosion():
	z_index = 100
	#animation_player.play(anims.EXPLOSION)
	for body in explosion_area.get_overlapping_bodies():
		if body.is_in_group("zombie"):
			body.zombie_dies(true, true)
