package core

import time "core:time"
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
	[dynamic]rl.Vector2,
	rl.Vector3,
	proc(),
	GameObjectProc,
}

GameObjectProc :: #type proc(gObj: ^GameObject)

GameObject :: struct {
	_id:        i64,
	tags:       [dynamic]string,
	type:       ObjectType,
	is_loaded:  bool,
	position:   rl.Vector2,
	properties: map[string]PropertiesTypes,
	ready:      GameObjectProc,
	draw:       GameObjectProc,
	update:     GameObjectProc,
	destroy:    GameObjectProc,
}

gameObjects := [dynamic]GameObject{}

spawn :: proc(gObj: GameObject) -> i64 {
	_id := time.time_to_unix_nano(time.now())
	n := append(&gameObjects, gObj)
	gameObjects[len(gameObjects) - 1]._id = _id
	return _id
}

unspawn :: proc(gObj: ^GameObject) {
	for i := 0; i < len(gameObjects); i += 1 {
		if (gameObjects[i]._id == gObj._id) {
			if gObj.destroy != nil {
				gObj.destroy(&gameObjects[i])
			}
			free(gObj)
			unordered_remove(&gameObjects, i)
			break
		}
	}
}

getByTag :: proc(tag: string) -> [dynamic]^GameObject {
	gObjs := [dynamic]^GameObject{}
	for &gObj in gameObjects {
		if gObj.tags != nil {
			for _tag in gObj.tags {
				if _tag == tag {
					append(&gObjs, &gObj)
					break
				}
			}
		}
	}
	return gObjs
}

getFirstByTag :: proc(tag: string) -> ^GameObject {
	gObjs := [dynamic]^GameObject{}
	for &gObj in gameObjects {
		if gObj.tags != nil {
			for _tag in gObj.tags {
				if _tag == tag {
					return &gObj
				}
			}
		}
	}
	return nil
}

get :: proc(id: i64) -> ^GameObject {
	for i := 0; i < len(gameObjects); i += 1 {
		if (gameObjects[i]._id == id) {
			return &gameObjects[i]
		}
	}
	return nil
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
