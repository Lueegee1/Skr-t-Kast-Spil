shader_type canvas_item;


void fragment() {
    // keep alpha but override color to white
    vec4 tex = texture(TEXTURE, UV);
    COLOR = vec4(1.0, 1.0, 1.0, tex.a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
