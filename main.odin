package main

import "core"
import rl "vendor:raylib"

camera: rl.Camera2D

main :: proc() {
	camera = core.createCamera()
	initLoaders()
	rl.InitWindow(800, 600, "Snake")
	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() {
		core.runReady()
		core.runUpdate()
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)
		rl.BeginMode2D(camera)
		core.runDraw(core.ObjectType.D2)
		rl.EndMode2D()
		rl.DrawFPS(10, 10)
		core.runDraw(core.ObjectType.UI)
		rl.EndDrawing()
	}

	rl.CloseWindow()
}
