extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"../../WorldMap".cities.has($"../../Player".selected_tile):
		self.text = str($"../../WorldMap".cities[$"../../Player".selected_tile].get_yield())
	elif $"../../Player".selected_tile != null:
		self.text = str($"../../Player".selected_tile) + ": " + str($"../../WorldMap".get_yield_at($"../../Player".selected_tile))
