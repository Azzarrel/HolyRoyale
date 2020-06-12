extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if $"../Player".selected_tile != null:
		self.show()
		self.position = $"../WorldMap/TileMap".map_to_world($"../Player".selected_tile)
	else:
		self.hide()
