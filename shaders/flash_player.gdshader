shader_type canvas_item;

uniform vec4 flash_color: source_color = vec4(1.0);
uniform float flash_pct: hint_range(0.0, 1.0, 0.1) = 0.0;

void fragment() {
	vec4 orginal_color = texture(TEXTURE, UV);
	COLOR = mix(orginal_color, flash_color, flash_pct);
	COLOR.a *= orginal_color.a;
}

