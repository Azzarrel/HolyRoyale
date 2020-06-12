extends Node2D

func set_type(type):
	$"Image".texture = type[3]
	self.type = type
	return self
	
var type = null

func get_yield():
	return type[1]
	
func get_slots():
	return type[2]

func get_cost():
	return type[3]
	
func get_upkeep():
	return type[3]
	
func get_passive_production():
	return type[6]
	
func can_be_placed_on_tile(tile, feature):
	for f in tile.features:
		if not can_share_tile(feature, f.type):
			return false
			
	if feature == Pasture:
		for f in tile.features:
			if f.type in animals: return true
		return false
	
	return true

func can_share_tile(a, b):
	if a in buildings and b in buildings:
		return false
	return true



# const Feature = [Bonus Yield, Slots, Texture]
const Farm =	["Farm",	{Enums.Resource.Food: 2}, 2, preload("res://features/farm.png"), 	{Enums.Resource.Materials: 10},  	{Enums.Resource.Materials: 1}, {Enums.Resource.Housing: 2}]
const Pasture =	["Pasture",	{Enums.Resource.Food: 2}, 1, preload("res://features/pasture.png"), {Enums.Resource.Materials: 10},  	{Enums.Resource.Materials: 1}, {}]
const Cattle =	["Cattle",	{Enums.Resource.Food: 2}, 0, preload("res://features/cattle.png"), {}, {}, {}]

const buildable =	[Farm, Pasture, Cattle]
const removble =	[Farm, Pasture]
const buildings =	[Farm, Pasture]
const animals = 	[Cattle]
