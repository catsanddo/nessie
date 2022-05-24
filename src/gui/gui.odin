package catgui

import "core:fmt"
import ray "vendor:raylib"

ID :: uint

@(private)
UI_Context :: struct {
    mouse_x: int,
    mouse_y: int,
    mouse_down: bool,

    hot, active: ID,
}

@(private) ui_context := UI_Context{}

@(private)
point_touch :: proc(x, y, w, h: int) -> bool {
    return ui_context.mouse_x >= x && ui_context.mouse_x < x + w && 
        ui_context.mouse_y >= y && ui_context.mouse_y < y + h
}

update :: proc(mouse_x, mouse_y: int, mouse_down: bool) {
    ui_context.hot = 0

    ui_context.mouse_x = mouse_x
    ui_context.mouse_y = mouse_y
    ui_context.mouse_down = mouse_down
}

clean :: proc() {
    if !ui_context.mouse_down {
        ui_context.active = 0
    } else if ui_context.active == 0 {
        ui_context.active = max(uint)
    }
}

button :: proc(id: ID, x, y: int) -> (result: bool) {
    if point_touch(x, y, 64, 64) && (ui_context.active == 0 || ui_context.active == id) {
        ui_context.hot = id
    }
    if ui_context.active == id && !ui_context.mouse_down {
        if ui_context.hot == id do result = true
        ui_context.active = 0
    }
    if ui_context.hot == id && ui_context.mouse_down {
        ui_context.active = id;
    }

    if ui_context.active == id {
        ray.DrawRectangle(i32(x), i32(y), 64, 64, ray.LIGHTGRAY)
    } else if ui_context.hot == id {
        ray.DrawRectangle(i32(x), i32(y), 64, 64, ray.GRAY)
    } else {
        ray.DrawRectangle(i32(x), i32(y), 64, 64, ray.GREEN)
    }

    return result
}
