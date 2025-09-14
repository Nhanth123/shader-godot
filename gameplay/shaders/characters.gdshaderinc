

void breath(inout vec2 v, float f){
	float m = 0.02;
	float breath_anim = sin(TIME * f) * 0.01;
	v *= 1.0 + breath_anim;
}


group_uniforms flash;
uniform float flash: hint_range(0.0, 1.0);
uniform vec3 flash_color: source_color;
group_uniforms;

void flash_on_hit(inout vec3 c) {
	c.rgb = mix(c.rgb, flash_color.rgb, clamp(flash, 0.0, 0.8));
}