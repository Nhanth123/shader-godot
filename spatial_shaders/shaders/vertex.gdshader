shader_type spatial;


void vertex()
{
	VERTEX  += vec3(sin(TIME), 0.0, 0.9);
}