package nessie

import "core:fmt"
import "core:strings"
import ray "vendor:raylib"

import "gui"

main :: proc() {
    fmt.println(context.user_ptr)
    ray.SetTraceLogLevel(ray.TraceLogLevel.NONE)
    ray.InitWindow(800, 600, cstring("Nessie"))
    ray.SetTargetFPS(60)

    sprite := ray.LoadRenderTexture(8, 8)
    ray.BeginTextureMode(sprite)
    ray.ClearBackground(ray.GRAY)
    ray.DrawLine(0, 0, 8, 0, ray.YELLOW)
    ray.EndTextureMode()

    camera := ray.Camera2D{}
    camera.offset = ray.Vector2{400, 300}
    camera.target.x = f32(sprite.texture.width) / 2
    camera.target.y = f32(sprite.texture.height) / 2
    camera.zoom = 50
    fmt.println(camera)

    for !ray.WindowShouldClose() {
        mouse_pos := ray.GetMousePosition()
        mouse_down := ray.IsMouseButtonDown(ray.MouseButton.LEFT)
        world_mouse := ray.GetScreenToWorld2D(mouse_pos, camera)

        gui.update(int(mouse_pos[0]), int(mouse_pos[1]), mouse_down)

        mouse_coords := fmt.tprintf("%v, %v", mouse_pos.x, mouse_pos.y)
        mouse_str := strings.clone_to_cstring(mouse_coords, context.temp_allocator)
        world_coords := fmt.tprintf("%v, %v", world_mouse.x, world_mouse.y)
        world_str := strings.clone_to_cstring(world_coords, context.temp_allocator)

        // Drawing
        ray.BeginDrawing()
        ray.ClearBackground(ray.BLUE)
        ray.DrawText(mouse_str, 10, 10, 20, ray.RAYWHITE)
        ray.DrawText(world_str, 10, 30, 20, ray.RAYWHITE)
        ray.BeginMode2D(camera)
        ray.DrawTexture(sprite.texture, 0, 0, ray.WHITE)
        ray.EndMode2D()
        fmt.println(gui.button(1, 5, 5))
        gui.button(2, 100, 100)
        ray.EndDrawing()

        gui.clean()
    }

    ray.CloseWindow()
}

@(test)
test :: proc() {
    fmt.println("Test")
}
