shader_type canvas_item;

uniform float amount = 1.0;

void fragment(){
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV, amount);
	COLOR = color + texture(SCREEN_TEXTURE, SCREEN_UV);
}