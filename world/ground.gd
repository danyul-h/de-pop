extends TileMapLayer

@export var objects : TileMapLayer

func get_surrounding_coords(coords: Array[Vector2i]):
	var surrounding_coords : Array[Vector2i] = coords.duplicate()
	for coord in coords:
		for i in [-1, 0, 1]:
			for j in [-1, 0, 1]:
				surrounding_coords.append(Vector2i(coord.x + i, coord.y + j))
	return surrounding_coords
		
func get_border_coords(coords: Array[Vector2i]):
	var border_coords := Array()
	#for coord in coords:
	return border_coords
	
func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	if coords in get_surrounding_coords(objects.get_used_cells()):
		return true
	return false

func _tile_data_runtime_update(_coords: Vector2i, tile_data: TileData) -> void:
	tile_data.set_navigation_polygon(0, null)
