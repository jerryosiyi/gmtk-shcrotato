extends Camera2D


@export var tile_map: TileMapLayer

var limit_offset := 10

func _ready() -> void:
	var map_rect = tile_map.get_used_rect()
	var tile_size = tile_map.rendering_quadrant_size
	var world_size = map_rect.size * tile_size
	limit_left = -limit_offset
	limit_top = -limit_offset
	limit_right = world_size.x + limit_offset
	limit_bottom = world_size.y + limit_offset
