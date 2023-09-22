extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_test_button_down():
	var p1 = {
		hp = 20,
		atk = 2
	}
	var p2 = {
		hp = 12,
		atk = 7
	}
	var player = "p" + str(randi_range(1,2))
	var stat = ".hp"
	print(player.stat)
	
