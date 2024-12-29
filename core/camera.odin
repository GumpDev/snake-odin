package core

import rl "vendor:raylib"

camera2d: rl.Camera2D
camera2dInitialized := false
camera3d: rl.Camera3D
camera3dInitialized := false

initCamera2d :: proc(camera: rl.Camera2D) {
	camera2dInitialized = true
	camera2d = camera
}

initCamera3d :: proc(camera: rl.Camera3D) {
	camera3dInitialized = true
	camera3d = camera
}
