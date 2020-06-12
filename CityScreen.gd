extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for feature in preload("res://Feature.gd").buildable:
		var button = Button.new()
		button.text = feature[0]
		button.icon = feature[3]
		button.connect("pressed", self, "build_feature", [feature])
		$BuildingScroll/GridContainer.add_child(button)
	pass # Replace with function body.

var city

func update():
	$CityName.text = city.city_name
	
	var panel = $CitizenScroll/CitizensPanel
	for c in panel.get_children():
		c.queue_free()
	panel.show()
	
	for c in city.citizens:
		var b = preload("res://CitizenBox.tscn").instance()
		b.init(c, city)
		panel.add_child(b)
		
	var storage = self.city.storage
	var capacity = self.city.get_capacity()
	for k in storage.keys():
		var bar = self.get_node("ResourcePanel/Storage/" + Enums.get_resource_name(k))
		
		if bar == null:
			bar = preload("res://StorageBar.tscn").instance()
			bar.init(k)
			bar.name = Enums.get_resource_name(k)
			$ResourcePanel/Storage.add_child(bar)
			
		var percent = 0
		if capacity.get(k, 0) != 0:
			percent = (float(storage[k]) / float(capacity[k])) * 100
			bar.show()
		else:
			bar.hide()
		
		bar.set_value(percent)
	
	var y = city.get_yield()
	for k in y.keys():
		var bar = self.get_node("ResourcePanel/Yield/" + Enums.get_resource_name(k))
		
		if bar == null:
			bar = preload("res://Yield.tscn").instance()
			bar.init(k)
			bar.name = Enums.get_resource_name(k)
			$ResourcePanel/Yield.add_child(bar)
		bar.set_value(y[k])

func set_city(city):
	if city == self.city:
		return
	self.city = city
	self.update()

func claim_tile():
	self.city.claim_tile()
	
func build_feature(feature):
	self.city.build_feature(feature)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TurnManager_end_turn():
	if self.city != null: self.update()
