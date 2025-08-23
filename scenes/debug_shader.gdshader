shader_type canvas_item;

uniform sampler2D arrow;

void vertex() {
	VERTEX *= 1.0 + abs(sin(UV.y * TIME));
	VERTEX.x += UV.y * 2.0 + float(VERTEX_ID) * sin(TIME * 5.0) * 10.0;
	VERTEX = -vec2(128.0 / 10.0 + cos(TIME) * VERTEX.x + sin(TIME) * VERTEX.y, 128.0 / 10.0 + sin(TIME) * VERTEX.x + -cos(TIME) * VERTEX.y);
}

void fragment() {
	vec3 c = vec3(UV * 1.6 * abs(cos(0.5 * TIME)), UV.y + 1.3 * abs(sin(0.5 * TIME)));
	vec3 t = texture(TEXTURE, vec2(UV.x + sin(TIME * 15.0) * UV.y * 0.1, UV.y)).bbb;
	vec3 ar = texture(arrow, UV).rgb;
	COLOR.rgb = mix(c, t, UV.y * sin(TIME));
	
	if (UV.x > 0.5){
		COLOR.rgb = vec3(1.0, 0.0, 0.0);
	}
	
	COLOR.rgb = mix(ar, COLOR.rgb, 0.5);
	
}