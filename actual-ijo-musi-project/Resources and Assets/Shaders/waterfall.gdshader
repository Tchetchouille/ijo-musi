// The waterfall is not transparent because it leads to rendering order issues.
shader_type spatial;

uniform vec4 out_color : source_color = vec4(0.0, 0.2, 0.4, 1.0);
uniform float fall_speed = 25.0;
uniform float offset = 0.1;


vec3 current(vec3 vertex, float time, float speed, float intensity){
	float x = vertex.x + cos(vertex.y + time * speed) * intensity;
	float y = vertex.y;
	float z = vertex.z + cos(vertex.y + time * speed) * intensity / 2.0;
	return vec3(x, y, z);
}

void vertex() {
	VERTEX = current(VERTEX, TIME, fall_speed, offset);
}

void fragment() {
	NORMAL = normalize(cross(dFdx(VERTEX), dFdy(VERTEX)));
	METALLIC = 0.8;
	SPECULAR = 0.5;
	ROUGHNESS = 0.1;
	ALBEDO = out_color.xyz;
	}

