extends Node2D


export(Vector2) var map_position =  null

# Called when the node enters the scene tree for the first time.
func _ready():
	self.place(map_position)
	pass # Replace with function body.


var modifiers = {}

func is_placed():
	return self.map_position != null

func get_claim_speed():
	return 1

func place(pos):
	if pos == null: return
	self.map_position = pos

func get_yield():
	if self.map_position == null:
		return {}
	var base = $"../..".get_yield_at(self.map_position)
	var result = {}
	for k in base.keys():
		result[k] = base[k] * modifiers.get(k, 1)
		
	return result
