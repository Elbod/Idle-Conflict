extends Area2D
####PATHS#######
var characterlist = ConfigFile.new()
var progress = ConfigFile.new()
var characterlistload = characterlist.load("res://data/characters.ini")
###############
var slots = ConfigFile.new()
var p0 = {
		name = null,
		role = null,
		atk = 0,
		def = 0,
		mag = 0,
		spi = 0,
		dodge = 0,
		hp = 0,
	}
var p1 = {
		name = null,
		role = null,
		atk = 0,
		def = 0,
		mag = 0,
		spi = 0,
		dodge = 0,
		hp = 0,
	}
var p2 = {
		name = null,
		role = null,
		atk = 0,
		def = 0,
		mag = 0,
		spi = 0,
		dodge = 0,
		hp = 0,
	}
var p3 = {
		name = null,
		role = null,
		atk = 0,
		def = 0,
		mag = 0,
		spi = 0,
		dodge = 0,
		hp = 0,
	}
var p4 = {
		name = null,
		role = null,
		atk = 0,
		def = 0,
		mag = 0,
		spi = 0,
		dodge = 0,
		hp = 0,
	}
var p5 = {
		name = null,
		role = null,
		atk = 0,
		def = 0,
		mag = 0,
		spi = 0,
		dodge = 0,
		hp = 0,
	}
var p6 = {
		name = null,
		role = null,
		atk = 0,
		def = 0,
		mag = 0,
		spi = 0,
		dodge = 0,
		hp = 0,
	}
var p7 = {
		name = null,
		role = null,
		atk = 0,
		def = 0,
		mag = 0,
		spi = 0,
		dodge = 0,
		hp = 0,
	}
var p8 = {
		name = null,
		role = null,
		atk = 0,
		def = 0,
		mag = 0,
		spi = 0,
		dodge = 0,
		hp = 0,
	}
var p9 = {
		name = null,
		role = null,
		atk = 0,
		def = 0,
		mag = 0,
		spi = 0,
		dodge = 0,
		hp = 0,
	}	
var playerindex = [p0,p1,p2,p3,p4,p5,p6,p7,p8,p9]
var turnorder = []
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func loadplayerslots():
	var progressload = progress.load("res://data/progress.ini")
	var number = 1
	turnorder = []
	while number < 7:
		if progress.get_value("Slot "+str(number),"name") != null:
			playerindex[number].name = progress.get_value("Slot "+str(number),"name")
			playerindex[number].role = progress.get_value("Slot "+str(number),"role")
			playerindex[number].atk = progress.get_value("Slot "+str(number),"atk")
			playerindex[number].def = progress.get_value("Slot "+str(number),"def")
			playerindex[number].mag = progress.get_value("Slot "+str(number),"mag")
			playerindex[number].spi = progress.get_value("Slot "+str(number),"spi")
			playerindex[number].dodge = progress.get_value("Slot "+str(number),"dodge")
			playerindex[number].hp = progress.get_value("Slot "+str(number),"hp")
			var node = get_node("CollisionShape2D/bslot" + str(number))
			var png = load("res://assets/portraits/" + progress.get_value("Slot "+str(number),"name") + ".png")
			node.texture = png
			node.visible = true
			turnorder.append(playerindex[number])
			print(turnorder)
		number += 1
	number = 7
	
func tableready():
	pass
