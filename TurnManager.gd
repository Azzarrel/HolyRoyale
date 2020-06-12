extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


signal end_turn

var turn_number = 0

func _on_end_turn():
	turn_number += 1
	#$"../TurnNumberDisplay".text = "Turn: " + str(turn_number)
	emit_signal("end_turn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
