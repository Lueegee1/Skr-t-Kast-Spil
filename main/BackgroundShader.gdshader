shader_type canvas_item;

uniform vec2 grid_size = vec2(64.0, 64.0);
uniform float line_thickness = 1.5;
uniform vec2 ball_position;
uniform float light_radius = 150.0;

void fragment() {
    vec2 uv = FRAGCOORD.xy;
    
    // Draw grid lines
    vec2 grid = abs(fract(uv / grid_size - 0.5) - 0.5) * grid_size;
    float line = min(grid.x, grid.y);
    
    // Basic grid color
    float base_brightness = smoothstep(line_thickness, 0.0, line);
    
    // Distance from ball
    float dist = distance(uv, ball_position);
    float glow = smoothstep(light_radius, 0.0, dist);
    
    // Combine glow and grid brightness
    float brightness = base_brightness * (0.3 + 0.7 * glow);
    
    COLOR = vec4(vec3(brightness), 1.0);
}
