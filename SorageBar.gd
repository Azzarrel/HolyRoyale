extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func init(resource):
	$TextureRect.texture = Enums.get_resource_icon(resource)
	$TextureProgress.tint_progress = Enums.get_resource_color(resource)
	
func set_value(value):
	$TextureProgress.value = value
