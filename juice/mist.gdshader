shader_type canvas_item;

uniform sampler2D noise_texture : repeat_enable;

void fragment() {
	// mist
	vec2 uv = UV;
	uv.x += TIME * 0.01;
	float r = texture(noise_texture, uv).r;
	
	vec2 uv2 = UV;
	uv.y += TIME * 0.01;
	r = r * texture(noise_texture, uv).r;
	
	

	
	
	COLOR.a = r * 0.25;
	
	// vin
	
	float vin_power = distance(UV, vec2(0.5, 0.5));
	vin_power = pow(vin_power, 1.0);
	
	//COLOR = mix(COLOR, vec4(0.0, 0.0, 0.0, 1.0), vin_power);
}
