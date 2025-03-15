shader_type canvas_item;

void fragment() {
	COLOR = vec4(0.8, 0.8, 0.8, 0.5);
	vec4 original_color = texture(TEXTURE, UV);
	float grayscale = (original_color.r + original_color.g + original_color.b) / 3.0;
	COLOR = vec4(vec3(grayscale), original_color.a);
}