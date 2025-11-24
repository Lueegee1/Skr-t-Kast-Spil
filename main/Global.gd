extends Node2D
var money = 0
var exp = 0 
var prestige = 0 
var in_menu: bool = false



const SAVE_FILE = "user://database.json"

var GameController
var Ball
var Inventory
var Ground
var Background
var settings
var Music

var prev_money = 0
var prev_exp = 0
var prev_prestige = 0

func _ready():
	load_game()
	print("Save file exists:", FileAccess.file_exists(SAVE_FILE))
	print("Save path:", SAVE_FILE)

func _process(_delta):
	if money != prev_money or exp != prev_exp or prestige != prev_prestige:
		save_game()
		prev_money = money
		prev_exp = exp
		prev_prestige = prestige
	print(exp)
	print(prestige)
	print(money)
	
func save_game():
	var data = {
		"money": money,
		"prestige": prestige,
		"exp": exp
	}

	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()
	
func load_game():
	if not FileAccess.file_exists(SAVE_FILE):
		return
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	if typeof(data) != TYPE_DICTIONARY: #ERROR checking
		return
	prestige = data.get("prestige", 0)
	money = data.get("money", 0)
	exp = data.get("exp", 0)
		
