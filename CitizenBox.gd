extends Panel

func init(citizen, city):
		$Place.connect("pressed", city, "place_citizen", [citizen])
