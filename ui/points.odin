package ui

import core "../core"
import fmt "core:fmt"
import strings "core:strings"
import rl "vendor:raylib"

points := 0

pointsUI :: proc() {
	draw :: proc(self: ^core.GameObject) {
		fmt.printfln("teste")
		sb := strings.builder_make()
		strings.write_int(&sb, points)
		rl.DrawText(
			strings.to_cstring(&sb),
			cast(i32)self.position.x,
			cast(i32)self.position.y,
			20,
			rl.GREEN,
		)
	}

	gObj := core.GameObject {
		type     = core.ObjectType.UI,
		draw     = draw,
		position = rl.Vector2{400, 10},
	}

	core.spawn(gObj)
}
