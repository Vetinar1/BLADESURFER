shader_type canvas_item;

uniform float amount = 0.0;

void fragment(){
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV, amount);
	COLOR = color;
}