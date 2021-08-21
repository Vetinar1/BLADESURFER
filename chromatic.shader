shader_type canvas_item;

uniform float offset = 1f;

uniform float amount = 1.0;
uniform float glow = 4.0;

uniform sampler2D offset_texture : hint_white;


void fragment(){
	vec4 green_channel = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 red_channel = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x + (offset * SCREEN_PIXEL_SIZE.x), SCREEN_UV.y));
	vec4 blue_channel = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x - (offset * SCREEN_PIXEL_SIZE.x), SCREEN_UV.y));
	COLOR = vec4(red_channel.r, green_channel.g, blue_channel.b, 1f) + vec4(1.0, 1.0, 1.0, 1.0);// + textureLod(SCREEN_TEXTURE, SCREEN_UV, float(amount)/10.0) + texture(SCREEN_TEXTURE, SCREEN_UV) * glow / 100.0);
}