shader_type canvas_item;

void fragment() {
    // Get the UV coordinates (0 to 1 range)
    vec2 uv = UV;

    // Center of the circle (0.5, 0.5 = middle of the image)
    vec2 center = vec2(0.5, 0.5);

    // Distance from current pixel to the center
    float dist = distance(uv, center);

    // Circle radius (0.5 = full height/width, smaller = smaller circle)
    float radius = 0.5;

    // If pixel is outside the circle, discard it (transparent)
    if (dist > radius) {
        discard;
    }

    // Otherwise, draw the texture color
    COLOR = texture(TEXTURE, uv);
}
