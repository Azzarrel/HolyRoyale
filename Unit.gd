extends Node2D

export var map_position = Vector2(0, 0)


func _ready():
	$"../WorldMap".move_unit(self, null, self.map_position)
	self.position = $"../WorldMap/TileMap".map_to_world(self.map_position) + Vector2(32, 32)
	$"../TurnManager".connect("end_turn", self, "_on_turn_end")
	pass # Replace with function body.

func _on_turn_end():
	self.move_to(self.map_position + Vector2(1, 0))
	
func move_to(pos):
	$"../WorldMap".move_unit(self, self.map_position, pos)
	self.position = $"../WorldMap/TileMap".map_to_world(pos) + Vector2(32, 32)
	self.map_position = pos
