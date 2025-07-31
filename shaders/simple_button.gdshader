shader_type canvas_item;

uniform float hovering : hint_range(0.0, 1.0) = 0.0;
uniform float pressed : hint_range(0.0, 1.0) = 0.0;


vec4 sample_texture(sampler2D texture, vec2 uv) {
    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        return vec4(0.0);
    }
    return texture(texture, uv);
}

void fragment() {
    vec4 original_color = sample_texture(TEXTURE, UV);

    // Determine final brightness based on state priority
    float final_brightness;
    if (pressed > 0.5) {
        // When pressed, use press brightness (ignore hover)
        final_brightness = 0.6;
    } else if (hovering > 0.5) {
        // When hovering but not pressed, use hover brightness
        final_brightness = 0.8;
    } else {
        // Normal state
        final_brightness = 1.0;
    }
    original_color.rgb *= final_brightness;

    vec4 final_color = original_color;

    // Show shadow only when not pressed
    COLOR = final_color;
}