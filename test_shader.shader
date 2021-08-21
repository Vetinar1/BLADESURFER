shader_type canvas_item;



uniform float amount = 1.0;
uniform float glow = 4.0;
uniform float cutoff = 0.5;

uniform sampler2D offset_texture : hint_white;

void fragment(){
	vec4 color = textureLod(SCREEN_TEXTURE, SCREEN_UV, float(amount)/10.0) + texture(SCREEN_TEXTURE, SCREEN_UV);
	if (color.r > cutoff){
		COLOR = textureLod(SCREEN_TEXTURE, SCREEN_UV, float(amount)/10.0) + texture(SCREEN_TEXTURE, SCREEN_UV) * glow / 100.0;
	} else {
		COLOR = textureLod(SCREEN_TEXTURE, SCREEN_UV, 1.0);
	}
}