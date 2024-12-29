package main

import entities "entities"
import ui "ui"

loaders := []proc(){entities.snake, entities.food, ui.pointsUI}

initLoaders :: proc() {
	for loader in loaders {
		loader()
	}
}
