shader_type canvas_item;

#include "res://gameplay/shaders/debug_utils.gdshaderinc"
#include "res://gameplay/shaders/characters.gdshaderinc"

#define BREATH_PACE 4.0

group_uniforms zebra_zombie_tex;
uniform sampler2D second_texture;
group_uniforms;

void breath(inout vec2 v){
	float m = 0.01;
	float f = 4.0;
	float breath_anim = sin(TIME * f) * 0.01;
	v *= 1.0 + breath_anim;
}

void vertex() {
	breath(VERTEX, BREATH_PACE);
}

void apply_zebra_zombie_text(inout vec3 c, vec2 uv, sampler2D tex){
	vec4 original_text = texture(tex, uv);
	vec4 second_text = texture(second_texture, uv);
	original_text.rgb *= vec3(0.7, 0.8, 0.7);
	vec3 zombie_text = c.rgb * vec3(vec2(0.7), 0.8);
	vec3 mixed_zombie_zebra = mix(original_text.rgb, second_text.rgb, 0.5);
	c.rgb = mixed_zombie_zebra.rgb;
}

void fragment() {
	apply_zebra_zombie_text(COLOR.rgb, UV, TEXTURE);
	flash_on_hit(COLOR.rgb);
	
	#ifdef DEBUG_MODE_ON
	debug_draw_dots_at_vertices(UV, COLOR, TEXTURE);
	#endif
	
}
