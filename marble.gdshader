shader_type spatial;

uniform sampler2D t;


void fragment() {
	float tvalue=texture(t,UV).x;
	if (tvalue<0.5 && tvalue>0.3){
		ALBEDO=texture(t,UV).xyz;
	}
}
