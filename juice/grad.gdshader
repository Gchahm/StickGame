shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
	vec4 color = texture(screen_texture, SCREEN_UV);
	
	color.r += UV.y * 0.1;
	color.g += UV.x * 0.1;
	
	COLOR = color;
}
