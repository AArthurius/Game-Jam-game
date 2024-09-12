extends Node

const BASIC_SHIELD_PICKUP = preload("res://Scenes/Pickups/basic_shield_pickup.tscn")
const ROCKETS_PICKUP = preload("res://Scenes/Pickups/rockets_pickup.tscn")

var pickups:Array = [BASIC_SHIELD_PICKUP, ROCKETS_PICKUP]

func random_pickup():
	if randi_range(0, 100) <= 30:
		var pickup = randomize_pickup().instantiate()
		pickup.position = $"..".global_position
		get_tree().root.get_child(0).get_node("Environment").get_node("Pickups").add_child(pickup)

func randomize_pickup():
	var pick: int = randi() % pickups.size() - 1
	
	return pickups[pick]
