extends Node2D


export var world_seed = 1337
export var size = Vector2(100, 100)

# Called when the node enters the scene tree for the first time.
func _ready():
	populate()
	var c = $City
	self.cities[c.map_position] = c

func populate():
	# Instantiate
	var noise = OpenSimplexNoise.new()

	# Configure
	noise.seed = world_seed
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	
	for x in range(0, size.x): for y in range(0, size.y):
		if noise.get_noise_2d(x, y) > 0: $TileMap.set_cell(x, y, 1)
		else: $TileMap.set_cell(x, y, 0)



class Tile:
	var pos
	var id
	var features
	func _init(pos, id, features):
		self.pos = pos
		self.id = id
		self.features = features


var units = {}
var features = {}
var cities = {}

func move_unit(unit, from, to):
	if from != null:
		self.units[from].erase(unit)
	var l = self.units.get(to, [])
	l.push_back(unit)
	units[to] = l

func get_features_at(vec):
	return features.get(vec, [])

var tile_yields = {
	1: {Enums.Resource.Food: 1}
	}

func get_yield_from_id(id):
	return tile_yields.get(id, {}).duplicate(true)

func get_tile_at(vec):
	var id = $TileMap.get_cellv(vec)
	return Tile.new(vec, id, get_features_at(vec))
	
func get_yield_at(vec):
	var result = get_yield_from_id($TileMap.get_cellv(vec))
	for feat in get_features_at(vec):
		var yields = feat.get_yield()
		for key in yields.keys():
			#If tile bonus yield is negative, only decrease the total yield down to 0
			result[key] = max(0, result.get(key, 0) + yields[key])
			
	return result
	
func get_slots_at(vec):
	var features = get_features_at(vec)
	var result = 1
	for f in features:
		result += f.get_slots()
	return max(0, result)

var last_tile = Vector2(0, 0)


func create_feature_at(feature_type, pos):
	var t = get_tile_at(pos)
	var feature = preload("res://Feature.tscn").instance()
	feature.position = $"TileMap".map_to_world(pos) + Vector2(32, 32)
	feature.set_type(feature_type)
	features[pos] = [feature]
	self.add_child(feature)


func _unhandled_input(event):
	if event is InputEventMouseButton:
		var cam = $"/root/root/Camera2D"
		var coord = $"TileMap".world_to_map(cam.get_cursor_in_world(event))
		
		if event.button_index == BUTTON_RIGHT:
			pass
		elif event.button_index == BUTTON_LEFT:
			
			var tile = coord
			var unit_on_tile = units.get(tile, []).pop_front()
			if unit_on_tile != null:
				$"../Player".selected_unit = unit_on_tile
				units[tile].push_back(unit_on_tile)
			$"../Player".selected_tile = coord
			if coord in cities:
				var c = cities[coord]
				c._on_select()
			if last_tile != coord:
				if last_tile in cities:
					var c = cities[last_tile]
					c._on_deselect()
			last_tile = coord


func _on_TurnManager_end_turn():
	pass # Replace with function body.
