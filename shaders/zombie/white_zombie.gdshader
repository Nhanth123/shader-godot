shader_type canvas_item;
uniform sampler2D sampled_texture;

void vertex() {

}

void fragment() {
	vec3 zombie_text = COLOR.rbg * vec3(vec2(0.7), 0.8);
	vec3 zebra_text = texture(sampled_texture, UV).rgb;
	COLOR.rgb = mix(zombie_text, zebra_text, 0.12);
}
