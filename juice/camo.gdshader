shader_type canvas_item;

uniform sampler2D colors : repeat_enable;
uniform sampler2D pattern : repeat_enable;
uniform float lcd : hint_range(0.0, 1.0);

void fragment() {
	float speed = 0.1;
	float scale = 2.5;
	
	
	
	
	float t = TIME * speed;
	
	vec2 uv = UV + vec2(sin(t), cos(t));
	vec4 color = texture(pattern, uv / scale);
	
	vec2 uv2 = UV + vec2(cos(t + 0.5), sin(t + 0.5));
	vec4 color2 = texture(pattern, uv2 / scale);
	
	color = mix(color, color2, 0.5);
	
	float rnf = 64.0;
	
	color.rgb = (round((color.rgb * 256.0) / rnf) * rnf) / 256.0;
	
	vec4 c = texture(colors, vec2(color.b, 0.0));
	
	color = c;
	
	
	
	
	float r = length(texture(TEXTURE, UV).rgb);
	color.r += sin(TIME);
	color.b += cos(-TIME);
	color.b += cos(TIME);
	
	
	color.rgb *= pow(r, 1.0);
	color.a = texture(TEXTURE, UV).a;
	


	COLOR = mix(color, texture(TEXTURE, UV), 1.0 - lcd);
	COLOR.rgb *= 1.0;

}
