// raylib-zig (c) Nikolas Wipper 2023

const rl = @import("raylib");

pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 800;
    const screenHeight = 450;
    const rectangleWidth = 20;

    const ScreenBounds = struct {
        top: i32,
        right: i32,
        bottom: i32,
        left: i32,
    };

    const bounds = ScreenBounds{
        .top = 0,
        .right = (screenWidth - rectangleWidth),
        .bottom = (screenHeight - rectangleWidth),
        .left = 0,
    };

    const Vector2d = struct { x: i32, y: i32 };

    var position = Vector2d{
        .x = (screenWidth / 2) - (rectangleWidth / 2),
        .y = (screenHeight / 2) - (rectangleWidth / 2),
    };

    const speed = 2;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig (test) Move Rectangle");

    defer rl.closeWindow(); // Close window and OpenGL context

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        if (rl.isKeyDown(rl.KeyboardKey.key_right)) {
            if (position.x < bounds.right) {
                position.x += speed;
            }
        }
        if (rl.isKeyDown(rl.KeyboardKey.key_down)) {
            if (position.y < bounds.bottom) {
                position.y += speed;
            }
        }
        if (rl.isKeyDown(rl.KeyboardKey.key_left)) {
            if (position.x > bounds.left) {
                position.x -= speed;
            }
        }
        if (rl.isKeyDown(rl.KeyboardKey.key_up)) {
            if (position.y > bounds.top) {
                position.y -= speed;
            }
        }

        // Draw
        //----------------------------------------------------------------------------------
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.white);

        rl.drawRectangle(position.x, position.y, rectangleWidth, rectangleWidth, rl.Color.red);

        rl.drawText("Move that rectangle!", 20, 20, 20, rl.Color.light_gray);
        //----------------------------------------------------------------------------------
    }
}
