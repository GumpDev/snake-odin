package entities

import core "../core"
import input "../input"
import ui "../ui"
import rl "vendor:raylib"

snake :: proc() {
	properties: map[string]core.PropertiesTypes = {
		"direction" = rl.Vector2{1, 0},
		"speed"     = 100.0,
		"tail"      = [dynamic]rl.Vector2{},
		"eat"       = cast(core.GameObjectProc)eat,
	}

	addTail :: proc(gObj: ^core.GameObject, size: int) {
		direction := gObj.properties["direction"].(rl.Vector2)
		tail := gObj.properties["tail"].([dynamic]rl.Vector2)
		for i := 0; i < size; i += 1 {
			pos := gObj.position - (direction * 5 * cast(f32)i)
			append_elem(&tail, pos)
		}
		gObj.properties["tail"] = tail
	}

	eat :: proc(gObj: ^core.GameObject) {
		speed := gObj.properties["speed"].(f32)
		speed += 5
		gObj.properties["speed"] = speed
		ui.points += 10
		addTail(gObj, 10)
	}

	updateTail :: proc(gObj: ^core.GameObject) {
		tail := gObj.properties["tail"].([dynamic]rl.Vector2)
		for i := len(tail) - 1; i >= 0; i -= 1 {
			if i == 0 {
				tail[0] = gObj.position
			} else {
				tail[i] = tail[i - 1]
			}
		}
	}

	draw :: proc(gObj: ^core.GameObject) {
		rl.DrawRectangle(cast(i32)gObj.position.x, cast(i32)gObj.position.y, 25, 25, rl.RED)

		tail := gObj.properties["tail"].([dynamic]rl.Vector2)
		for _tail in tail {
			rl.DrawRectangle(cast(i32)_tail.x, cast(i32)_tail.y, 25, 25, rl.RED)
		}
	}

	wallLimit :: proc(gObj: ^core.GameObject) {
		if gObj.position.x > 800 - 25 {
			gObj.position.x = 0
		}
		if gObj.position.x < 0 {
			gObj.position.x = 800 - 25
		}
		if gObj.position.y > 600 - 25 {
			gObj.position.y = 0
		}
		if gObj.position.y < 0 {
			gObj.position.y = 600 - 25
		}
	}

	update :: proc(gObj: ^core.GameObject) {
		dir := input.getAxis(
			rl.KeyboardKey.W,
			rl.KeyboardKey.S,
			rl.KeyboardKey.A,
			rl.KeyboardKey.D,
		)

		if dir.x != 0 || dir.y != 0 {
			gObj.properties["direction"] = dir
		}

		speed := gObj.properties["speed"].(f32)
		direction := gObj.properties["direction"].(rl.Vector2)
		gObj.position += direction * speed * rl.GetFrameTime()
		wallLimit(gObj)
		updateTail(gObj)
	}

	gObj := core.GameObject {
		tags       = {"snake"},
		type       = core.ObjectType.D2,
		draw       = draw,
		update     = update,
		properties = properties,
	}

	core.spawn(gObj)
}
