extends Node2D
var money = 0
var exp = 0 
var prestige = 0 
var in_menu: bool = false
var saved_launch_angle
var saved_air_resistance
var saved_gravity
var saved_ground_friction
var saved_ground_elasticity


const SAVE_FILE = "user://database.json"

var GameController
var Ball
var Inventory
var Ground
var Background
var settings
var Music
var ball_loaded := false

var prev_money = 0
var prev_exp = 0
var prev_prestige = 0

func _ready():
	load_game()
	await wait_for_ball()
	apply_ball_stats()

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
		"exp": exp,
		"launch_angle": Global.Ball.launch_angle,
		"air_resistance": Global.Ball.air_resistance,
		"gravity": Global.Ball.gravity,
		"ground_friction": Global.Ball.ground_friction,
		"ground_elasticity": Global.Ball.ground_elasticity
	}
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()
	
func wait_for_ball():
	while ball_loaded == false:
		await get_tree().process_frame

func apply_ball_stats():
	if Ball == null:
		return

	Ball.launch_angle = saved_launch_angle
	Ball.air_resistance = saved_air_resistance
	Ball.gravity = saved_gravity
	Ball.ground_friction = saved_ground_friction
	Ball.ground_elasticity = saved_ground_elasticity

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
	saved_launch_angle = data.get("launch_angle",45)
	saved_air_resistance = data.get("air_resistance", 0.5)
	saved_gravity	= data.get("gravity", 1.0)
	saved_ground_friction = data.get("ground_friction", 0.1)
	saved_ground_elasticity = data.get("ground_elasticity", 0.5)
		
