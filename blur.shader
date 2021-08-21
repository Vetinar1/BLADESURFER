shader_type canvas_item;

void fragment(){
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV, 0.5);
	COLOR = color;//vec4(0.0, 0.0, 0.0, 0.0);
}