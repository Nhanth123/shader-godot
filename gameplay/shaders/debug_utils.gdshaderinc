//#define DEBUG_MODE_ON;

// The complete file will be empty when we comment out DEBUG_MODE_ON
#ifdef DEBUG_MODE_ON
// ONLY ADD CODE BELOW THIS LINE


const float dot_size = 0.02; // Size of the red dots

void debug_draw_dots_at_vertices(vec2 uv, inout vec4 color, sampler2D original_texture) {
    

	// Positions of the four corners
    vec2 corners[4];
    corners[0] = vec2(0.0, 0.0); // Bottom left
    corners[1] = vec2(1.0, 0.0); // Bottom right
    corners[2] = vec2(1.0, 1.0); // Top right
    corners[3] = vec2(0.0, 1.0); // Top left

    // Check if the current fragment is close to any corner
	bool is_near_corner = false;
	vec3 corder_specific_color = vec3(1,1,1);
    for (int i = 0; i < 4; i++) {
        if (distance(uv, corners[i]) < dot_size) {
            is_near_corner = true;
			corder_specific_color = vec3(corners[i], 1);
            break;
        }
    }

    // Color the fragment red if it's near a corner, otherwise use the texture color
    color = is_near_corner ? vec4(corder_specific_color, 1.0) : color;

}

// ONLY ADD CODE ABOVE THIS LINE
#endif