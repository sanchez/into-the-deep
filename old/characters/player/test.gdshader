shader_type canvas_item;

uniform vec4 color_1 = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 color_2 = vec4(0.0, 1.0, 0.0, 1.0);
uniform vec4 color_3 = vec4(0.0, 0.0, 1.0, 1.0);

uniform int pixelSize = 8;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	ivec2 size = textureSize(SCREEN_TEXTURE, 0);
	vec2 factor = vec2(size) / float(pixelSize);
	vec2 uv = round(UV * factor) / factor;
	COLOR = texture(SCREEN_TEXTURE, uv);
}
