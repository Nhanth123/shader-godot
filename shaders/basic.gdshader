shader_type canvas_item;

void vertex()
{
	if(VERTEX.y < 0.0 && VERTEX.x < 0.0)
	{
		vec2 circle = vec2(cos(TIME) * 100.0, sin(TIME) * 100.0);
		VERTEX += vec2(-200.0, -50.0) + circle;
	}

}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
