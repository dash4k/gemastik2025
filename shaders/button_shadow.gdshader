shader_type canvas_item;

uniform vec4 drop_shadow_color : source_color = vec4(vec3(0.1), 0.5);
uniform vec2 shadow_offset = vec2(0.0, 0.2);
uniform float hovering : hint_range(0.0, 1.0) = 0.0;
uniform float pressed : hint_range(0.0, 1.0) = 0.0;
uniform float press_depth : hint_range(0.0, 10.0) = 3.0;

void vertex() {
    // Optional: Remove this entirely for pure color-based feedback
    // Move the button down when pressed to simulate depth
    if (pressed > 0.5) {
        VERTEX += shadow_offset * press_depth;
    }
}

vec4 sample_texture(sampler2D texture, vec2 uv) {
    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        return vec4(0.0);
    }
    return texture(texture, uv);
}

vec4 mixcolor(vec4 colA, vec4 colB) {
    return vec4(colA.rgb + colB.a * (colB.rgb - colA.rgb), colA.a + colB.a);
}

void fragment() {
    float max_offset = max(abs(shadow_offset.x), abs(shadow_offset.y));
    vec2 uv = UV * (1.0 + 2.0 * max_offset) - vec2(max_offset);
    vec4 original_color = sample_texture(TEXTURE, uv);
    
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
    if (pressed < 0.5) {
        vec4 shadow_color = vec4(
            drop_shadow_color.rgb,
            sample_texture(TEXTURE, uv - shadow_offset).a * drop_shadow_color.a
        );
        if (shadow_color.a > 0.0) {
            final_color = mixcolor(shadow_color, original_color);
        }
    }
    
    COLOR = final_color;
}