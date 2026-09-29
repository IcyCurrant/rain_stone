shader_type canvas_item;

uniform float line_wid = 30.0;
uniform float speed = 10.0;

void fragment() {
	float wid = 10.0/512.0;
	float height = 10.0/512.0;
	
	vec2 coords = vec2(wid * floor(UV.x/height), height * floor(UV.y/wid));
	COLOR = texture(TEXTURE, UV);
	//COLOR *= vec4(vec2(UV.x * line_wid,UV.y), sin(10.0 * TIME), 1.0);
	COLOR *= texture(TEXTURE, coords);
}