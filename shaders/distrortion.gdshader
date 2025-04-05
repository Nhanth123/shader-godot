shader_type canvas_item;

uniform vec2 offset1 = vec2(0.1);
uniform vec2 offset2 = vec2(0.2);

uniform sampler2D noise_texture1: repeat_enable;
uniform sampler2D noise_texture2: repeat_enable;

void fragment() 
{
	vec4 noise_color1 = texture(noise_texture1, UV + offset1 * TIME);
	vec4 noise_color2 = texture(noise_texture2, UV + offset2 * TIME);
	
	float final_noise = noise_color1.r + noise_color2.r;
	vec4 final_color = vec4(vec3(final_noise), 1.0);
	
	COLOR = final_color;
}

