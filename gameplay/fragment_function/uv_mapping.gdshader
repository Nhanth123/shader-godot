shader_type canvas_item;


void fragment() {
	vec2 scaled_uv = UV * 2.0;
	vec4 mapped_tex = texture(TEXTURE, scaled_uv);
	COLOR = mapped_tex;
}
