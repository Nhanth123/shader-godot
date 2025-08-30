shader_type canvas_item;
uniform sampler2D second_texture;

void flash_on_hit(){
	
}

void fragment() {
	vec4 original_text = texture(TEXTURE, UV);
	vec4 second_text = texture(second_texture, UV);
	original_text.rgb *= vec3(0.7, 0.8, 0.7);
	vec3 zombie_text = COLOR.rgb * vec3(vec2(0.7), 0.8);
	vec3 mixed_zombie_zebra = mix(original_text.rgb, second_text.rgb, 0.5);
	COLOR.rgb = mixed_zombie_zebra.rgb;
}
