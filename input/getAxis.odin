package input

import rl "vendor:raylib"

getAxis :: proc(
	up: rl.KeyboardKey,
	down: rl.KeyboardKey,
	left: rl.KeyboardKey,
	right: rl.KeyboardKey,
) -> rl.Vector2 {
	if rl.IsKeyPressed(right) {
		return rl.Vector2{1, 0}
	} else if rl.IsKeyPressed(left) {
		return rl.Vector2{-1, 0}
	} else if rl.IsKeyPressed(up) {
		return rl.Vector2{0, -1}
	} else if rl.IsKeyPressed(down) {
		return rl.Vector2{0, 1}
	}
	return rl.Vector2{0, 0}
}
