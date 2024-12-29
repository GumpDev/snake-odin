package core

import rl "vendor:raylib"

ObjectType :: enum {
	D3,
	D2,
	UI,
}

PropertiesTypes :: union {
	i32,
	f32,
	string,
	rl.Vector2,
	rl.Vector3,
}
GameObjectProc :: #type proc(gObj: ^GameObject)

GameObject :: struct {
	type:       ObjectType,
	is_loaded:  bool,
	position:   rl.Vector2,
	properties: map[string]PropertiesTypes,
	ready:      GameObjectProc,
	draw:       GameObjectProc,
	update:     GameObjectProc,
}

gameObjects := [dynamic]GameObject{}

registerGameObject :: proc(gObj: GameObject) {
	append(&gameObjects, gObj)
}

runReady :: proc() {
	for &obj in gameObjects {
		if obj.ready != nil && !obj.is_loaded {
			obj.ready(&obj)
			obj.is_loaded = true
		}
	}
}

runUpdate :: proc() {
	for &obj in gameObjects {
		if obj.update != nil {
			obj.update(&obj)
		}
	}
}

runDraw :: proc(objType: ObjectType) {
	for &obj in gameObjects {
		if obj.draw != nil && obj.type == objType {
			obj.draw(&obj)
		}
	}
}
