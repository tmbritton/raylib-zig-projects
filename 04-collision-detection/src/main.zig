// raylib-zig (c) Nikolas Wipper 2023

const rl = @import("raylib");

pub fn willCollide(rect1: rl.Rectangle, rect2: rl.Rectangle, dx: f32, dy: f32) bool {
    const nextRect1 = rl.Rectangle{
        .x = rect1.x + dx,
        .y = rect1.y + dy,
        .width = rect1.width,
        .height = rect1.height,
    };

    return nextRect1.checkCollision(rect2);
}

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

    //const Rectangle = struct { x: i32, y: i32, width: i32, height: i32, color: rl.Color };
    const RenderRect = struct {
        box: rl.Rectangle,
        color: rl.Color,
    };

    const bounds = ScreenBounds{
        .top = 0,
        .right = (screenWidth - rectangleWidth),
        .bottom = (screenHeight - rectangleWidth),
        .left = 0,
    };

    var playerRectangle = RenderRect{
        .box = rl.Rectangle{
            .x = @as(f32, (screenWidth / 2) - (rectangleWidth / 2)),
            .y = @as(f32, (screenHeight / 3) - (rectangleWidth / 3)),
            .width = 20,
            .height = 20,
        },
        .color = rl.Color.red,
    };

    const collisionRectangle = RenderRect{
        .box = rl.Rectangle{
            .x = 200,
            .y = 200,
            .width = 40,
            .height = 60,
        },
        .color = rl.Color.sky_blue,
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
            if (playerRectangle.box.x < bounds.right and !willCollide(playerRectangle.box, collisionRectangle.box, speed, 0)) {
                playerRectangle.box.x += speed;
            }
        }
        if (rl.isKeyDown(rl.KeyboardKey.key_down)) {
            if (playerRectangle.box.y < bounds.bottom and !willCollide(playerRectangle.box, collisionRectangle.box, 0, speed)) {
                playerRectangle.box.y += speed;
            }
        }
        if (rl.isKeyDown(rl.KeyboardKey.key_left)) {
            if (playerRectangle.box.x > bounds.left and !willCollide(playerRectangle.box, collisionRectangle.box, -speed, 0)) {
                playerRectangle.box.x -= speed;
            }
        }
        if (rl.isKeyDown(rl.KeyboardKey.key_up)) {
            if (playerRectangle.box.y > bounds.top and !willCollide(playerRectangle.box, collisionRectangle.box, 0, -speed)) {
                playerRectangle.box.y -= speed;
            }
        }

        // Draw
        //----------------------------------------------------------------------------------
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.white);

        //rl.drawRectangle(playerRectangle.box.x, playerRectangle.box.y, playerRectangle.box.width, playerRectangle.box.height, playerRectangle.color);
        //rl.drawRectangle(collisionRectangle.box.x, collisionRectangle.box.y, collisionRectangle.box.width, collisionRectangle.box.height, collisionRectangle.color);
        rl.drawRectangleRec(playerRectangle.box, playerRectangle.color);
        rl.drawRectangleRec(collisionRectangle.box, collisionRectangle.color);
        rl.drawText("Move that rectangle!", 20, 20, 20, rl.Color.light_gray);
        //----------------------------------------------------------------------------------
    }
}
