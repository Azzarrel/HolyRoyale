extends Node2D



# Called when the node enters the scene tree for the first time.
export var map_position = Vector2(5, 5)
export var city_name = "Citiesburgenheimtownville"
func _ready():
	self.position = $"/root/root/WorldMap/TileMap".map_to_world(map_position)
	
	$"/root/root/TurnManager".connect("end_turn", self, "_on_end_turn")
	
	$Border.map_position = self.map_position
	$Border.add_tile(map_position + Vector2(0, 0))
	$Border.update_border()


func get_size():
	return $Border.get_size()

var citizens = []
var citizens_on_tile = {}
var storage = {}

var base_yield = {
		Enums.Resource.Food:		1,
		Enums.Resource.Gold:		2,
		Enums.Resource.Materials:	1,
		Enums.Resource.Housing:		2,
	}


func get_capacity():
	return {
		Enums.Resource.Food:		10,
		Enums.Resource.Gold:		50,
		Enums.Resource.Materials:	10,
		Enums.Resource.Housing:		0,
	}

func get_yield():
	var total = base_yield.duplicate()
	for c in citizens:
		if c.map_position in self.tiles_with_progress.keys():
			continue
		var sub_yield = c.get_yield()
		for k in sub_yield.keys():
			total[k] = total.get(k, 0.0) + sub_yield[k]
			
	for pos in $Border.tiles:
		var features = $"/root/root/WorldMap/".get_features_at(pos)
		for f in features:
			for k in f.get_passive_production():
				total[k] = total.get(k, 0.0) + f.type[5].get(k, 0.0)
	return total

func accumulate():
	var y = self.get_yield()
	for k in y.keys():
		storage[k] = storage.get(k, 0) + y[k]

func consume():
	storage[Enums.Resource.Food] = max(storage.get(Enums.Resource.Food, 0) - citizens.size(), 0)
	storage[Enums.Resource.Housing] = max(storage.get(Enums.Resource.Housing, 0) - citizens.size(), 0)
	
func grow():
	grow_population()
	progress_building()
	

func grow_population():
	if storage.get(Enums.Resource.Food, 0) >= 10 and storage.get(Enums.Resource.Housing, 0) > 0:
		var c = preload("res://Citizen.tscn").instance()
		
		var button = Button.new()
		button.margin_left = 24;
		button.margin_right = 40;
		button.margin_top = 24;
		button.margin_bottom = 40;
		button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		button.theme = Theme.new()
		button.set("custom_styles/normal", StyleBoxFlat.new())
		button.get("custom_styles/normal").bg_color = Color(0, 0, 0, 0)
		button.connect("pressed", self, "place_citizen", [c])
		#button.z_index = -1
		c.add_child(button)
		
		storage[Enums.Resource.Food] -= 10
		self.add_child(c)
		citizens.push_back(c)

func progress_building():
	for pos in tiles_with_progress.keys().duplicate():
		var tile = tiles_with_progress[pos]
		for citizen in citizens_on_tile.get(pos, []):
			#tile.progress += citizen.get_claim_speed()
			
			var i = 0
			while true:
				var r = tile.next_cost(i)
				if r == null: break
				if r is String:
					tile.pay(r)
					break
				else:
					if self.storage.get(r, 0) >= 1:
						self.storage[r] -= 1
						tile.pay(r)
						break
					i += 1
					
			tile.indicator.value = tile.progress
			
		if tile.progress >= tile.max_progress:
			tile.indicator.get_parent().queue_free()
			if tile.target is String and tile.target == "claim":
				$Border.add_tile(pos)
			elif tile.target is Array:
				$"..".create_feature_at(tile.target, pos)
			tiles_with_progress.erase(pos)
	$Border.update_border()

func cap():
	var c = self.get_capacity()
	for k in storage.keys():
		storage[k] = min(c.get(k, 0), storage.get(k, 0))

func _on_select():
	$Border.set_alpha(1)
	for c in citizens:
		c.show()
	
	$"/root/root/UI/CityScreen".set_city(self)
	$"/root/root/UI/CityScreen".show()

func place_citizen(citizen):
	
	#Get a mask for where the citizen can be placed
	var border = $Border.tiles.duplicate(true)
	border.erase(self.map_position)
	
	#Remove all full tiles from the mask
	for tile in border.duplicate(true):
		if citizens_on_tile.get(tile, []).size() >= $"..".get_slots_at(tile):
			border.erase(tile)
			
	for tile in self.tiles_with_progress.keys():
		border.push_back(tile)
	
	var pos = yield($"/root/root/TileSelector".get_selected(border, "move_citizen"), 'completed')
	
	if citizen.map_position != null:
		citizens_on_tile[citizen.map_position].erase(citizen)
		organize_citizens(citizen.map_position)
	citizens_on_tile[pos] = citizens_on_tile.get(pos, [])
	citizens_on_tile[pos].push_back(citizen)
	citizen.place(pos)
	
	organize_citizens(pos)
	
func organize_citizens(tile):
	for index in citizens_on_tile[tile].size():
		var citizen = citizens_on_tile[tile][index]
		citizen.position = $"../TileMap".map_to_world(citizen.map_position) - $"../TileMap".map_to_world(self.map_position)
		if citizens_on_tile[tile].size() == 1:
			continue
		elif citizens_on_tile[tile].size() <= 2:
			citizen.position += [Vector2(-12, 0), Vector2(+12, 0)][index]
		elif citizens_on_tile[tile].size() <= 4:
			citizen.position += [Vector2(-12, -12), Vector2(+12, -12), Vector2(-12, +12), Vector2(+12, +12)][index]
	


var tiles_with_progress = {}

class ProgressTile:
	var progress = 0
	var max_progress
	var cost
	var indicator
	var target
	
	func _init(city, pos, cost, target):
		self.cost = cost.duplicate()
		self.target = target
		
		
		self.max_progress = 0
		for key in self.cost:
			self.max_progress += self.cost[key]
			
		
		var dummy = Node2D.new()
		
		var progress = TextureProgress.new()
		progress.texture_progress = preload("res://progress.png")
		progress.texture_under = preload("res://progress_bg.png")
		progress.max_value = self.max_progress
		progress.fill_mode = progress.FILL_CLOCKWISE
		progress.mouse_filter = Control.MOUSE_FILTER_IGNORE
		dummy.z_index = 1
		dummy.position = city.get_node("/root/root/WorldMap/TileMap").map_to_world(pos) - city.get_node("/root/root/WorldMap/TileMap").map_to_world(city.map_position) + Vector2(16, 16)
		self.indicator = progress
		
		city.add_child(dummy)
		dummy.add_child(progress)
		
	
	func next_cost(index):
		if index >= cost.keys().size(): return null
		return cost.keys()[index]
	
	func pay(key):
		if not key in cost:
			return false
		cost[key] -=1
		self.progress += 1
		if cost[key] <= 0:
			cost.erase(key)
		return true
		

func add_progress_tile(pos, cost, target):
	var tile = ProgressTile.new(self, pos, cost, target)
	tiles_with_progress[pos] = tile

func build_feature(feature):
	#Get a mask for where the citizen can be placed
	var border = $Border.tiles.duplicate(true)
	
	for pos in border.duplicate():
		var tile = $"/root/root/WorldMap".get_tile_at(pos)
		if not Feature.can_be_placed_on_tile(tile, feature):
			border.erase(pos)
	
	var pos = yield($"/root/root/TileSelector".get_selected(border, feature[3]), 'completed')
	
	if pos == null:
		return
		
	add_progress_tile(pos, feature[4], feature)

func claim_tile():
	#Get a mask for where the citizen can be placed
	var border = $Border.get_surrounding().duplicate(true)
	
	var pos = yield($"/root/root/TileSelector".get_selected(border, "claim"), 'completed')
	
	if pos == null:
		return
		
	var distance = (self.map_position - pos).length()
	add_progress_tile(pos, {Enums.Resource.Gold: 1, "progress": int(distance * distance)}, "claim")
	


func _on_deselect():
	$Border.set_alpha(0.1)
	for c in citizens:
		c.hide()
	$"/root/root/UI/CityScreen".hide()
	
func _on_end_turn():
	self.accumulate()
	self.consume()
	self.grow()
	self.cap()
	
