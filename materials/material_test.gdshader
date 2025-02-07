shader_type spatial;

uniform sampler2D texer;
uniform sampler2D albedo_texture;

float random (vec2 uv) {
	float t = 1.0+float(int(TIME*10.0)%5)/5.0;
	int x = int(uv.x*200.0);
	int y = int(uv.y*200.0);
	vec2 v = vec2(float(x)/5.0,float(y)/5.0);
    return fract(sin(dot(v*t,
        vec2(12.9898,78.233))) * 43758.5453123);
}

void fragment()
{
	vec3 base_color = vec3(0.1, 0.1, 0.1);
	float r = random(UV);
	if(r>0.0){
		base_color = vec3(1, 0, 0);
	}
	if(r>0.3){
		base_color = vec3(0, 1, 0);
	}
	if(r>0.6){
		base_color = vec3(0, 0, 1);
	}
	ALBEDO = texture(albedo_texture,UV).xyz + (base_color * texture(texer,UV).xyz);
}
