#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out float height; // genesis
out float isShadow; // genesis
out float customType; // genesis

void custom(int type) {
    customType = type;
    height = (gl_VertexID%4 == 0 || gl_VertexID%4 == 3) ? 1 : 0;
}

bool roughlyEquals(float a, float b) {
    return abs(a - b) < 0.01;
}

bool isRegularTextDepth(float depth) {
    return (
        roughlyEquals(depth, 2200.03) || // Actionbar
        roughlyEquals(depth, 2400.06) || // Subtitle
        roughlyEquals(depth, 2400.12) || // Title
        roughlyEquals(depth, 50.03) ||   // Opened Chat
        roughlyEquals(depth, 2650.03) || // Closed Chat
        roughlyEquals(depth, 200.03) ||  // Advancement Screen
        roughlyEquals(depth, 400.03) ||  // Items
        roughlyEquals(depth, 1000.03) || // Bossbar
        roughlyEquals(depth, 2800.03) || // Scoreboard List
        roughlyEquals(depth, 2000)       // Scoreboard Sidebar (Has no shadow, remove tint for consistency)
    );
}

bool isShadowDepth(float depth) {
    return (
        roughlyEquals(depth, 2200) || // Actionbar
        roughlyEquals(depth, 2400) || // Subtitle | Title
        roughlyEquals(depth, 50) ||   // Opened Chat
        roughlyEquals(depth, 2650) || // Closed Chat
        roughlyEquals(depth, 200) ||  // Advancement Screen
        roughlyEquals(depth, 400) ||  // Items
        roughlyEquals(depth, 1000) || // Bossbar
        roughlyEquals(depth, 2800)    // Scoreboard List
    );
}

void main() {
    // vanilla
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = fog_distance(Position, FogShape);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;
    // genesis
    customType = 0;
    if (isRegularTextDepth(Position.z)) {
        isShadow = 0;
        ivec3 iColor = ivec3(Color.xyz * 255.1);
        if (iColor == ivec3(59, 43,  6)) { custom(1); } else
        if (iColor == ivec3(33, 25,  5)) { custom(2); } else
        if (iColor == ivec3(64, 51,  3)) { custom(3); }
    } else if (isShadowDepth(Position.z)) {
        isShadow = 1;
        ivec3 iColor = ivec3(Color.xyz * 255.1);
        if (iColor == ivec3(14, 10, 1)) { custom(1); } else
        if (iColor == ivec3( 8,  6, 1)) { custom(2); } else
        if (iColor == ivec3(16, 12, 0)) { custom(3); }
    }
}
