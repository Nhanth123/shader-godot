shader_type spatial;

uniform vec3 sphere_color: source_color = vec3(1.0);

void fragment() 
{
	ALBEDO = vec3(0.0, 0.0, 1.0);
	ALPHA = 1.;
}