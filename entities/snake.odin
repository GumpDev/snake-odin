package entities

import core "../core"
import fmt "core:fmt"
import rl "vendor:raylib"

snake :: proc() {
	properties: map[string]core.PropertiesTypes = {
		"direction" = rl.Vector2{1, 0},
	}

	draw :: proc(gObj: ^core.GameObject) {
		rl.DrawRectangle(cast(i32)gObj.position.x, cast(i32)gObj.position.y, 25, 25, rl.RED)
	}

	update :: proc(gObj: ^core.GameObject) {
		if rl.IsKeyPressed(rl.KeyboardKey.D) {
			gObj.properties["direction"] = rl.Vector2{1, 0}
		} else if rl.IsKeyPressed(rl.KeyboardKey.A) {
			gObj.properties["direction"] = rl.Vector2{-1, 0}
		} else if rl.IsKeyPressed(rl.KeyboardKey.W) {
			gObj.properties["direction"] = rl.Vector2{0, -1}
		} else if rl.IsKeyPressed(rl.KeyboardKey.S) {
			gObj.properties["direction"] = rl.Vector2{0, 1}
		}

		direction := gObj.properties["direction"].(rl.Vector2)
		gObj.position += direction * 50.0 * rl.GetFrameTime()
	}

	core.registerGameObject(
		core.GameObject {
			type = core.ObjectType.D2,
			draw = draw,
			update = update,
			properties = properties,
		},
	)
}
