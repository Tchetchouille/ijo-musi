shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.r = min(0.4, TIME * 0.4);
	COLOR.g = min(0.4, TIME * 0.4);
	COLOR.b = min(0.4, TIME * 0.4);
}
