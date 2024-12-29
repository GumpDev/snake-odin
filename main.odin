package main

import "core"
import rl "vendor:raylib"

SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 600

main :: proc() {
	core.initCamera2d(rl.Camera2D{offset = {0, 0}, rotation = 0, target = {0, 0}, zoom = 1.0})
	initLoaders()
	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Snake")
	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() {
		core.runReady()
		core.runUpdate()
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)
		if core.camera2dInitialized {
			rl.BeginMode2D(core.camera2d)
			core.runDraw(core.ObjectType.D2)
			rl.EndMode2D()
		}
		if core.camera3dInitialized {
			rl.BeginMode3D(core.camera3d)
			core.runDraw(core.ObjectType.D3)
			rl.EndMode3D()
		}
		rl.DrawFPS(10, 10)
		core.runDraw(core.ObjectType.UI)
		rl.EndDrawing()
	}

	rl.CloseWindow()
}
