extends Control

func init(resource):
	$TextureRect.texture = Enums.get_resource_icon(resource)
	
func set_value(value):
	if value > 0:
		$Label.text = "+" + str(value)
	else:
		$Label.text = str(value)
