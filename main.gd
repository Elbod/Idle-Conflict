extends Sprite2D
#####PATHS##################
var characterlist = ConfigFile.new()
var progress = ConfigFile.new()
var characterlistload = characterlist.load("res://data/characters.ini")
var progressload = progress.load("res://data/progress.ini")
########STATGEN#############
var pulled = "false"
var gen_hp = 0
var gen_atk = 0
var gen_def = 0
var gen_mag = 0
var gen_spi = 0
var gen_dodge = 0
var gen_role = "true"
######GLOBAL VARIABLES######
var countdown_recruit = 10
var gold = 500
var wood = 0
var iron = 0
var genlevel = 1
var slotlist = []
var donothing = 0
var hire_target_slot = 0
var loadinggame = "true"


func _ready():
		$Seconds_timer.start()
		$Gold.text = str(gold) + "\n Gold."
		load_slots()

func load_slots():
	slotlist = []
	var counter = 1
	var maxslots = progress.get_value("Slots","open") - progress.get_value("Slots","active")
	while counter < 7:
		if progress.get_value("Slot " + str(counter),"name") == null and counter < maxslots + 1:
			slotlist.append(counter)
		else:
			donothing
		if counter < maxslots + 1 and progress.get_value("Slot " + str(counter),"name") != null and loadinggame != "false":
			hire_target_slot = counter
			pulled = progress.get_value("Slot "+str(hire_target_slot),"name")
			gen_role = progress.get_value("Slot "+str(hire_target_slot),"role")
			gen_atk = progress.get_value("Slot "+str(hire_target_slot),"atk")
			gen_def = progress.get_value("Slot "+str(hire_target_slot),"def")
			gen_mag = progress.get_value("Slot "+str(hire_target_slot),"mag")
			gen_spi = progress.get_value("Slot "+str(hire_target_slot),"spi")
			gen_dodge = progress.get_value("Slot "+str(hire_target_slot),"dodge")
			gen_hp = progress.get_value("Slot "+str(hire_target_slot),"hp")
			hire_assing_slot()
		if counter < maxslots + 1:
			var node = get_node("Slot" + str(counter))
			var png = load("res://assets/background/slot.png")
			node.texture = png
		counter += 1

func load_game():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_update_button_down():
	one_second_down()

func _on_Seconds_timer_timeout():
	one_second_down()

func one_second_down():
	if countdown_recruit > 0:
		countdown_recruit -= 1
		$Countdown_hiring.text = str(countdown_recruit) + " seconds"
	else:
		hire_ready()

func hire_ready():
		countdown_recruit = 60
		pulled = characterlist.get_value("id",str(randi_range(1,11)))
		var cardname = load("res://assets/portraits/" + str(pulled) + ".png")
		hire_generate_stats()
		$Recruit_hire.visible = true
		#### PRINTING INFO ON RECRUIT
		$Mystery.texture = cardname
		$Recruit_name.text = pulled
		$Recruit_role.text = gen_role
		$Recruit_stats1.text = "ATK: " + str(gen_atk) + "\nMAG: " + str(gen_mag) + "\nHP: " + str(gen_hp) 
		$Recruit_stats2.text = "DEF: " + str(gen_def) + "\nSPI: " + str(gen_spi) + "\nDODGE: " + str(gen_dodge) 

func hire_generate_stats():
	gen_hp = 20 + randi_range(1,5)
	gen_atk = 5 + randi_range(1,10)
	gen_def = 5 + randi_range(1,10)
	gen_mag = 5 + randi_range(1,10)
	gen_spi = 5 + randi_range(1,10)
	gen_dodge = 5 + randi_range(1,10)
	gen_role = characterlist.get_value(str(pulled),"role")


func _on_test_button_down():
	pass


func _on_recruit_hire_button_down():
	if gold > 100 and slotlist.size() > 0:
		gold -= 100
		$Gold.text = str(gold) + "\n Gold."
		$Recruit_hire.visible = false
		loadinggame = "false"
		if slotlist.size() > 0: 
			hire_target_slot = str(slotlist.pop_front())
			hire_assing_slot()
		else:
			print("false")

func hire_assing_slot():
	var node = get_node("Slot" + str(hire_target_slot) + "/Name")
	node.text = pulled
	node.visible = true
	node = get_node("Slot" + str(hire_target_slot) + "/Role")
	node.text = gen_role
	node.visible = true
	node = get_node("Slot" + str(hire_target_slot) + "/Stats1")
	node.text = "ATK: " + str(gen_atk) + "\nMAG: " + str(gen_mag) + "\nHP: " + str(gen_hp)
	node.visible = true
	node = get_node("Slot" + str(hire_target_slot) + "/Stats2")
	node.text ="DEF: " + str(gen_def) + "\nSPI: " + str(gen_spi) + "\nDODGE: " + str(gen_dodge) 
	node.visible = true
	var png = load("res://assets/portraits/" + str(pulled) + ".png")
	node = get_node("Slot" + str(hire_target_slot) + "/Avatar")
	node.texture = png
	node.visible = true
	if loadinggame == "false":
		progress.set_value("Slot "+hire_target_slot,"name",pulled)
		progress.set_value("Slot "+hire_target_slot,"role",gen_role)
		progress.set_value("Slot "+hire_target_slot,"atk",gen_atk)
		progress.set_value("Slot "+hire_target_slot,"def",gen_def)
		progress.set_value("Slot "+hire_target_slot,"mag",gen_mag)
		progress.set_value("Slot "+hire_target_slot,"spi",gen_spi)
		progress.set_value("Slot "+hire_target_slot,"dodge",gen_dodge)
		progress.set_value("Slot "+hire_target_slot,"hp",gen_hp)
	progress.save("res://data/progress.ini")



func _on_free_encounter_button_down():
	$Table.loadplayerslots()
	$Table.tableready()
