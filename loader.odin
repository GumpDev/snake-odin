package main

import entities "entities"

loaders := []proc(){entities.snake}

initLoaders :: proc() {
	for loader in loaders {
		loader()
	}
}
