shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

vec2 square_imaginary(vec2 n){
	return vec2(
		pow(n.x,2.0)-pow(n.y,2.0),2.0*n.x*n.y
	);
}

void fragment() {
	float m = 30.0;
	vec2 z = vec2(0,0);
	vec2 u = (UV+(vec2(-0.5,-0.5)))*3.0;
	for (float i=0.0;i<m;i++){
		z=square_imaginary(z)+u;
		if(length(z)>2.0){
			ALBEDO=vec3(i/m,i/m,i/m);
		}
	}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
