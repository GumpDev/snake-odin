package core

import rl "vendor:raylib"

createCamera :: proc() -> rl.Camera2D {
	return rl.Camera2D{offset = {0, 0}, rotation = 0, target = {0, 0}, zoom = 1.0}
}
