extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal selected(pos)
var border
export var enabled = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_selected(border, graphics):
	emit_signal("selected", null)
	if graphics is String:
		$Hex.show()
		$Sprite.hide()
	elif graphics is Texture:
		$Hex.hide()
		$Sprite.show()
		$Sprite.texture = graphics
	
	self.enabled = true
	self.border = border
	var position = yield(self, "selected")
	self.enabled = false
	return position

func _unhandled_input(event):
	if not self.enabled:
		return null
		
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			self.enabled = false
			self.hide()
			emit_signal("selected", null)
			get_tree().set_input_as_handled()
			
	if event is InputEventAction:
		print(event.action)
		if event.action == "ui_cancel":
			self.enabled = false
			self.hide()
			emit_signal("selected", null)
			get_tree().set_input_as_handled()
			
		
	if event is InputEventMouseMotion:
		var tm = $"../WorldMap/TileMap"
		var map_pos = tm.world_to_map($"/root/root/Camera2D".get_cursor_in_world(event))
		self.position = tm.map_to_world(map_pos)
	
		if self.border != null:
			if not self.border.has(map_pos):
				self.hide()
			else:
				self.show()
		else:
			self.show()
		
	if event is InputEventMouseButton:
		var tm = $"../WorldMap/TileMap"
		var map_pos = tm.world_to_map($"/root/root/Camera2D".get_cursor_in_world(event))
		if event.button_index == BUTTON_LEFT:
			if not event.pressed:
				if self.border != null and self.border.has(map_pos):
					get_tree().set_input_as_handled()
					self.hide()
					emit_signal("selected", map_pos)
			get_tree().set_input_as_handled()
