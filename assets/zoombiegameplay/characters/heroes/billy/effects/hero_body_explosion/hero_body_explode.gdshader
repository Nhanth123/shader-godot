shader_type canvas_item;
render_mode blend_mix;
uniform int particles_anim_h_frames;
uniform int particles_anim_v_frames;
uniform sampler2D noise;

void vertex() {
	float h_frames = float(particles_anim_h_frames);
	float v_frames = float(particles_anim_v_frames);
	VERTEX.xy /= vec2(h_frames, v_frames);
	float particle_total_frames = float(particles_anim_h_frames * particles_anim_v_frames);
	float particle_frame = floor(INSTANCE_CUSTOM.z * float(particle_total_frames));
	particle_frame = clamp(particle_frame, 0.0, particle_total_frames - 1.0);
	UV /= vec2(h_frames, v_frames);
	UV += vec2(mod(particle_frame, h_frames) / h_frames, floor((particle_frame + 0.5) / h_frames) / v_frames);
}

void fragment(){

	COLOR.r = texture(noise, UV).r * 1.2;
	COLOR.a *= smoothstep(0.3, distance(UV, vec2(0.5)), 0.9);
	COLOR.gb *= 0.6;
	
	vec4 shadow = texture(TEXTURE, UV * 1.4);
	shadow.rgb = vec3(0.1);
	shadow.a *= 0.2;
	
	COLOR = mix(COLOR, shadow, shadow.a) * 0.8;
	
}
