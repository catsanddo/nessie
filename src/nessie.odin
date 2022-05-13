package nessie

import "core:fmt"
import "core:strings"
import ray "vendor:raylib"

main :: proc() {
    ray.InitWindow(800, 600, cstring("Nessie"))
    ray.SetTargetFPS(60)

    for !ray.WindowShouldClose() {
        mouse_pos := ray.GetMousePosition()

        mouse_coords := fmt.tprintf("%v, %v", mouse_pos.x, mouse_pos.y)
        mouse_str := strings.clone_to_cstring(mouse_coords, context.temp_allocator)

        // Drawing
        ray.BeginDrawing()
        ray.ClearBackground(ray.BLUE)
        ray.DrawText(mouse_str, 10, 10, 20, ray.RAYWHITE)
        ray.EndDrawing()
    }

    ray.CloseWindow()
}
