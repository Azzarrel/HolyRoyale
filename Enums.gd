extends Node

enum Resource {
	Food,
	Gold,
	Raw_Material,
	Materials,
	Mana,
	Faith,
	Science,
	Weapons,
	Amunition,
	Magical_Weapons,
	Ore,
	Armor,
	Housing,
	Culture,
	Faith,
	Glory,
	Influence,
	Wool,
	Leather
}

const ResourceIcons = {
	Resource.Food: preload("res://apple.png"),
	Resource.Gold: preload("res://gold.png"),
	
}

const ResourceColors = {
	Resource.Food: Color.lawngreen,
	Resource.Gold: Color.gold,
}

func get_resource_name(id):
	return Resource.keys()[int(id)]
	
func get_resource_color(id):
	return ResourceColors.get(id, Color(0, 0, 0))
	
func get_resource_icon(id):
	return ResourceIcons.get(id, preload("res://icon.png"))
	
enum Proffession {
	Hunter, # (Food, Leather)
	Gatherer, # (Early Game Profession, Food on empty Tiles)
	Farmer, # (Food/ Leather/ Wool/ Luxuries)
	Ranger, # (can create ‘game’ Resource, increases Production for neighbouring Forest Tiles)
	Fishermen, # (Food, Luxuries)
	Shepard, # (can be placed on empty meadows, increases yield for wool in neighbouring Pastures)
	Lumberjack, # (Resources)
	Craftsman, # (Resources => Materials)
	Blacksmith, # (Ore, Materials => Weapons, Armor, Materials)
	Bowmaker, # (Materials => Projectiles)
	Engineer, # (Projectiles => Siege Weapons/Materials => Labour/Science)
	Builder, # (Materials => Labour)
	Merchant, # (Gold/Gold based on Trade Routes through this city)
	Mason, # (Materials)
	Miner, # (Materials/Ore/Gold/ Luxuries)
	Noble, #(In Palace, Stability, Happiness)
	Envoy, # (Stability/ Needed for Diplomacy)
	Magistrate, # (Happiness [Suppression]/  Stability/ Culture)
	Artist, # (Musician/Playwright/Poet) (Culture/ Happiness)
	Wizard, # (Faith/Glory/Influence/Science/Tombs/[‘Mage Weapons]’)
	Priest, # (Faith, Happiness, Stability)
	Explorer #(Faster Land Development, +1 Vision)
}
