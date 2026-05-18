// Code shamelessly stolen from: https://www.youtube.com/watch?v=5MfcliFqjnE
shader_type spatial;

uniform vec4 out_color : source_color = vec4(0.0, 0.2, 0.4, 1.0);
uniform float amount : hint_range(0.2, 1.5) = 0.8;
uniform float beer_factor = 0.2;
uniform float ripple_speed = 0.1;
uniform sampler2D depth_texture : hint_depth_texture, repeat_disable, filter_nearest;

float generateOffset(float x, float z, float val1, float val2, float time){
	float speed = 1.0;
	
	float radX = ((mod(x+z*x*val1,amount)/amount)+(time*speed)*mod(x*0.8+z,1.5))*2.0*3.14;
	float radZ = ((mod(val2*(z*x+x*z),amount)/amount)+(time*speed)*2.0*mod(x,2.0))*2.0*3.14;
 
	return amount*0.5*(sin(radZ)+cos(radX));

}

vec3 applyDistortion(vec3 vertex, float time){
	float dx = generateOffset(vertex.x, vertex.z, 0.2, 0.1, time);
	float dy = generateOffset(vertex.x, vertex.z, 0.1, 0.3, time);
	float dz = generateOffset(vertex.x, vertex.z, 0.15, 0.2, time);
	return vertex + vec3(dx, dy, dz);
}

void vertex() {
	VERTEX = applyDistortion(VERTEX, TIME * ripple_speed);
}

void fragment() {
	NORMAL = normalize(cross(dFdx(VERTEX), dFdy(VERTEX)));
	METALLIC = 0.8;
	SPECULAR = 0.5;
	ROUGHNESS = 0.1;
	ALBEDO = out_color.xyz;
	float depth = texture(depth_texture, SCREEN_UV).r;
	depth = depth*2.0-1.0;
	depth = PROJECTION_MATRIX[3][2]/(depth+PROJECTION_MATRIX[2][2]);
	depth = depth+VERTEX.z;
	depth = exp(-depth*beer_factor);
	ALPHA = clamp(1.0-depth,0.0,1.0);
}
