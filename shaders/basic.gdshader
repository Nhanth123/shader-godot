shader_type canvas_item;

void vertex()
{
	//if(VERTEX.y < 0.0 && VERTEX.x < 0.0)
	//{
		//vec2 circle = vec2(cos(TIME) * 100.0, sin(TIME) * 100.0);
		//VERTEX += vec2(-200.0, -50.0) + circle;
	//}

}

void fragment()
{
	// Called for every pixel the material is visible on.
	vec4 color_1 = vec4(1.0, 0.0, 0.0, 1.0);
	vec4 color_2 = vec4(0.0, 1.0, 0.0, 1.0);
	float mix_pct = (sin(TIME * 3.0) + 1.0) * 0.5;
	vec4 mix_color = mix(color_1, color_2, mix_pct);

	COLOR = texture(TEXTURE, UV) * mix_color;

	//COLOR = vec4(UV.x, UV.y, 0.0, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
