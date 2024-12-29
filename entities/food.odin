package entities

import core "../core"
import rand "core:math/rand"
import rl "vendor:raylib"

food :: proc() {
	position := rl.Vector2{rand.float32_range(50, 750), rand.float32_range(50, 550)}

	draw :: proc(gObj: ^core.GameObject) {
		rl.DrawRectangle(cast(i32)gObj.position.x, cast(i32)gObj.position.y, 15, 15, rl.GREEN)
	}

	update :: proc(self: ^core.GameObject) {
		snakeObj := core.getFirstByTag("snake")
		if snakeObj == nil {
			return
		}
		if rl.Vector2Distance(snakeObj.position, self.position) < 25 {
			eat := snakeObj.properties["eat"].(core.GameObjectProc)
			eat(snakeObj)
			core.unspawn(self)
		}
	}

	destroy :: proc(self: ^core.GameObject) {
		food()
	}

	gObj := core.GameObject {
		type     = core.ObjectType.D2,
		tags     = {"food"},
		position = position,
		draw     = draw,
		update   = update,
		destroy  = destroy,
	}

	core.spawn(gObj)
}
