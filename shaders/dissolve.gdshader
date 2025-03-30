shader_type canvas_item;

uniform sampler2D noise_text;
uniform float dissolve_pct: hint_range(0.0, 1.0, 0.1) = 0.0f;

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);
	vec4 final_color = original_color;
	vec4 noise = texture(noise_text, UV);
	
	if(dissolve_pct >= noise.r)
	{
		final_color.a = 0.0;
	}
	
	COLOR = final_color;
}
