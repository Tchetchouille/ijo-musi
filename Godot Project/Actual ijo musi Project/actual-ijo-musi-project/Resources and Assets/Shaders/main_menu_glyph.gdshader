shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.r = 0.25 + abs(cos(TIME * 2.0) * 0.25);
	COLOR.g = 0.4 + abs(cos(TIME * 2.0) * 0.4);
	COLOR.b = 0.8 + abs(cos(TIME * 2.0) * 0.2);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
