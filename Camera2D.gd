extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var speed = 500


func _unhandled_input(event):
	if Input.is_action_pressed("ui_drag") and event is InputEventMouseMotion:
		self.position -= event.relative * self.zoom
		get_tree().set_input_as_handled()
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			self.zoom /= 1.1
			#self.position = get_cursor_in_world(event)
		if event.button_index == BUTTON_WHEEL_DOWN:
			self.zoom *= 1.1
			#self.position = get_cursor_in_world(event)

func _process(delta):
	if Input.is_action_pressed("ui_left"):
			self.position.x -= speed * delta * self.zoom.x
	if Input.is_action_pressed("ui_right"):
			self.position.x += speed * delta * self.zoom.x
	if Input.is_action_pressed("ui_up"):
			self.position.y -= speed * delta * self.zoom.y
	if Input.is_action_pressed("ui_down"):
			self.position.y += speed * delta * self.zoom.y

func get_cursor_in_world(event):
	return (event.global_position - get_viewport().size / 2) * self.zoom + self.position
