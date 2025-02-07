shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

const float TWO_PI = 6.28318530718;
uniform float line_width = 0.01;

vec4 polygon(vec2 uv, float width, int sides)
{
	uv = uv * 2.0 - 1.0;//calculating center point
	uv.x*=4.0;
	float angle = atan(uv.x, uv.y);
	float radius = TWO_PI / float(sides);

	float dist = cos(floor(0.5 + angle / radius) * radius - angle) * length(uv);
	float poly = 1.0;
	float dw = abs(width-dist);
	if(dw<line_width){
		poly=0.0;
	}
	return vec4(vec3(poly), 1.0);
}

void fragment() {
	float stretch = 1.0;
	vec2 suv = vec2(UV.x,UV.y*stretch);
	ALBEDO = vec3(1,1,1);
	for(int i = 0; i<50;i++){
		float w = 0.1+(float(i)/10.0);
		ALBEDO *= polygon(suv,w,100).xyz;
	}
}
