shader_type canvas_item;

uniform sampler2D mask_text;

void fragment() 
{
	vec4 mask_color = texture(mask_text, UV);
	vec4 original_color = texture(TEXTURE, UV);
	
	if (original_color.a > 0.0)
	{
		COLOR.a = mask_color.r;
	}
}
