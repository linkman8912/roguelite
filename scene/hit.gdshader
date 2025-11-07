shader_type canvas_item;

uniform bool show_white = false; // You can toggle this in code or the Inspector

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    if (show_white) {
        // Show the sprite as pure white (keeping transparency)
        COLOR = vec4(1.0, 1.0, 1.0, tex.a);
    } else {
        // Show the normal texture
        COLOR = tex;
    }
}
