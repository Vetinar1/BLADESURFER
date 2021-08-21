shader_type canvas_item;

uniform float amount = 0.0;

void fragment(){
	vec4 color = texture(TEXTURE, UV, amount);
	COLOR = color + texture(TEXTURE, UV);
}