#version 300 es

precision mediump float;
uniform sampler2D tex;

in vec2 v_texcoord;
out vec4 fragColour;

void main() {
    vec4 colour = texture2D(tex, v_texcoord);
    float new_colour = (colour.r + colour.g + colour.b) / 3.0;
    fragColour = vec4(new_colour, new_colour, 0.0, 1.0);
}
