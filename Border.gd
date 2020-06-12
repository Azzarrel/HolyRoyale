extends Node2D


func _ready():
	update_border()

var map_position = Vector2(0, 0)
var tiles = []

func get_size():
		return self.tiles.size()

func contains(vec):
	return tiles.has(vec)

export var color = Color(1, 0, 0)

func set_color(color):
	self.color = color
	for line in $Lines.get_children():
		color.default_color = color
	
func set_alpha(alpha):
	self.color.a = alpha
	for line in $Lines.get_children():
		line.default_color.a = alpha

func add_tile(coord):
	if !tiles.has(coord):
		tiles.append(coord)

func get_surrounding():
	var result = {}
	for tile in self.tiles:
		var offsets
		if int(tile.y) % 2 != 0:
			offsets = [Vector2(0, -1), Vector2(+1, -1), Vector2(-1, 0), Vector2(+1, 0),Vector2(0, +1), Vector2(+1, 1)]
		else:
			offsets = [Vector2(0, -1), Vector2(-1, -1), Vector2(-1, 0), Vector2(+1, 0),Vector2(0, +1), Vector2(-1, 1)]
		for offset in offsets:
			if not self.contains(tile + offset):
				result[tile + offset] = true
				
	return result.keys()

func update_border():
	for child in $Lines.get_children():
		child.queue_free()
	#[Vector2(0, 0), Vector2(1, 0), Vector2(1, 1), Vector2(0, 1), Vector2(1, 2)]
	var hex = [
		Vector2(0, 48),
		Vector2(0, 16),
		Vector2(32, 0),
		Vector2(64, 16),
		Vector2(64, 48),
		Vector2(32, 64),
		Vector2(0, 48),
		Vector2(0, 16), ]
	
	var vertecies = {}
	
	
	for tile in tiles:
		var p_pos = $"/root/root/WorldMap/TileMap".map_to_world(map_position)
		for i in range(1, 7):
			var coords = $"/root/root/WorldMap/TileMap".map_to_world(tile) - p_pos + hex[i]
			var connected_vertecies = vertecies.get(coords, [0])
			
			
			connected_vertecies.append($"/root/root/WorldMap/TileMap".map_to_world(tile) - p_pos + hex[i-1])
			connected_vertecies.append($"/root/root/WorldMap/TileMap".map_to_world(tile) - p_pos + hex[i+1])
			connected_vertecies[0] += 1
			
			if connected_vertecies[0] == 3:
				vertecies.erase(coords)
			else:
				vertecies[coords] = connected_vertecies
	
	while not vertecies.empty():
		var final = []
		var prev
		var cur = vertecies.keys()[0]
		var first = cur
		while cur:
			final.append(cur)
			var next
			
			for v in vertecies[cur]:
				if v in vertecies.keys() && (not next or not prev or (cur - next).angle_to(cur - prev) > (cur - v).angle_to(cur - prev)):
					next = v
			vertecies.erase(cur)
			prev = cur
			cur = next
		final.append(first)
		vertecies.erase(first)
		var line = Line2D.new()
		line.points = final
		line.end_cap_mode = Line2D.LINE_CAP_ROUND
		line.begin_cap_mode = Line2D.LINE_CAP_ROUND
		line.joint_mode = Line2D.LINE_JOINT_ROUND
		line.default_color = self.color
		line.width = 4
		$Lines.add_child(line)
