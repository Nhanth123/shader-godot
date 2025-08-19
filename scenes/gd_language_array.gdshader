shader_type canvas_item;

const float f[3] = float[](0.5, 0.45, 0.25);
const vec3 v[] = { vec3(2) };

void fragment(){
	float float_arr[3] = float[3] (1.0, 0.5, 0.6);
	
	int int_arr[3] = int[] (2,1, 0);
	
	vec2 vec2_arr[] = {vec2(1,0), vec2(2,1), vec2(1,2)};
	
	int len = vec2_arr.length();
	vec2 value = vec2_arr[len - 1];
	
	
}