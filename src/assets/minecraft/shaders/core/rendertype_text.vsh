#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

out float sphericalVertexDistance;
out float cylindricalVertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out float height; // genesis
out float isShadow; // genesis
out float customType; // genesis

void custom(int type, bool shadow) {
    customType = type;
    height = (gl_VertexID%4 == 0 || gl_VertexID%4 == 3) ? 1 : 0;
    isShadow = shadow ? 1 : 0;
}

bool roughlyEquals(float a, float b) {
    return abs(a - b) < 0.01;
}

void main() {
    // vanilla
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    sphericalVertexDistance = fog_spherical_distance(Position);
    cylindricalVertexDistance = fog_cylindrical_distance(Position);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;
    // genesis
    customType = 0;
    ivec3 iColor = ivec3(Color.xyz * 255.1);
    if (iColor == ivec3(59, 43,  6)) { custom(1, false); } else
    if (iColor == ivec3(33, 25,  5)) { custom(2, false); } else
    if (iColor == ivec3(64, 51,  3)) { custom(3, false); } else
    if (iColor == ivec3(14, 10, 1)) { custom(1, true); } else
    if (iColor == ivec3( 8,  6, 1)) { custom(2, true); } else
    if (iColor == ivec3(16, 12, 0)) { custom(3, true); }
}
