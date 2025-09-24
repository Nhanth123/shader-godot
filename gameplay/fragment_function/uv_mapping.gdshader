shader_type canvas_item;


void fragment() {
	vec2 scaled_uv = UV * 2.0;
	vec4 mapped_tex = texture(TEXTURE, scaled_uv);
	COLOR = mapped_tex;

	//if (UV.x < 1.0) {
		//COLOR = vec4(1);
	//}

	//COLOR = UV.y > 0.5 ? vec4(1.0, 0.0, 0.0, 1.0): COLOR.rbga;

	float columns  = 2.0;
	float t = TIME;
	vec2 titled_uv = mod(UV * columns + t, 2.0);
	vec4 c_tex = texture(TEXTURE, titled_uv);
	COLOR = c_tex;
}
