extends Node2D


@onready var Camera = $UI/Camera2D
@onready var RigidBody = $LaunchSite/RigidBody2D
@onready var XpLabel = $UI/Camera2D/CanvasLayer/XpLabel
@onready var MoneyLabel = $UI/Camera2D/CanvasLayer/MoneyLabel
@onready var PrestigeLabel = $UI/Camera2D/CanvasLayer/PrestigeLabel
@onready var Upgrades = $UI/Camera2D/CanvasLayer/VBoxContainer
@onready var angle = $UI/Camera2D/CanvasLayer/VBoxContainer/Angle
@onready var shapes = ["4kant", "5kant", "6kant", "7kant", "8kant","9kant","10kant"]
@onready var settings_menu = preload("res://main/settings.tscn")
@onready var music_player = $Musicmanager
var possible_angles = [45,45]


var offsetXP = Vector2(0,0)
var offsetMoney = Vector2(200,0)
var offsetPrestige = Vector2(400,0)
var offsetUpgrades = Vector2(800,0)
var angle_price = 5
var friction_price = 5 
var elasticity_price = 5
var speed_price = 5
var air_resistance_price = 5
var shape_price = 5
var gravity_price = 5
var change_shape_price = 5
var shape_number = 0
var num := 1
@onready var object = $LaunchSite/RigidBody2D/Sprite2D 
@onready var collisionshape = $LaunchSite/RigidBody2D/CollisionPolygon2D

func _ready() -> void:
	#music
#	music_player.play_main_theme(load("res://Assets/Sound/Main theme loopable.wav"))
	object.texture = load("res://Assets/Sprites/shapes without glare/%d.png" % num)
	object.scale = Vector2(0.1,0.1)
	collision_follow_sprite(object, collisionshape)
	

func _rounding(num):
	var exponent = int(log(num+1)/log(10))
	var suffixes = ["","K","M","B","T","Qu","Qi","Sx","Sp","O","N","Dc"]
	for i in range(suffixes.size()):
		if (3*i) <= exponent and exponent <(3+3*i):
			exponent = 3*i
			return str((round(float(num)/(10**exponent)*10))/10) + suffixes[i]
		else:
			pass

func _process(_delta: float):# update position and money, xp and prestige
	Camera.global_position = RigidBody.global_position #updates camera position
	XpLabel.text = "Xp: " + _rounding(Global.exp)
	MoneyLabel.text = "Money: " + _rounding(Global.money)
	PrestigeLabel.text = "Prestige: " + _rounding(Global.prestige)
	XpLabel.position = offsetXP
	MoneyLabel.position = offsetMoney
	PrestigeLabel.position = offsetPrestige
	Upgrades.position = offsetUpgrades
	
	

func buy_and_upgrade(cost: float, property_name: String, upgrade_value: float, multiplier: float, min_value := -INF, max_value := INF):
	if Global.money > cost:
		if  Global.Ball[property_name] + upgrade_value > min_value and Global.Ball[property_name] + upgrade_value < max_value:
			Global.Ball[property_name] += upgrade_value
			Global.money -= cost
			cost *= multiplier

func _on_angle_changed(value: float):
	if not Global.in_menu:
		Global.Ball.launch_angle = value


func _on_angle_upgrade_pressed():
	if not Global.in_menu:
		if Global.money > angle_price:
			if angle.min_value > 0 and angle.max_value < 90:
				angle.min_value = angle.min_value - 5
				angle.max_value = angle.max_value + 5
				angle_price *= 2
		


func _on_gravity_upgrade_pressed():
	if not Global.in_menu:
		buy_and_upgrade(gravity_price,"gravity", -0.05, 2)

func _on_friction_upgrade_pressed():
	if not Global.in_menu:
		buy_and_upgrade(friction_price, "ground_friction", -0.05, 2, 0.000001)

func _on_elasticity_upgrade_pressed():
	if not Global.in_menu:
		buy_and_upgrade(elasticity_price, "ground_elasticity", 5, 2)

func _on_speed_upgrade_pressed():
	if not Global.in_menu:
		buy_and_upgrade(speed_price, "launch_speed", 100, 2)


func _on_air_resistance_upgrade_pressed():
	if not Global.in_menu:
		buy_and_upgrade(air_resistance_price, "air_resistance", -0.001, 2)


func _on_shape_changed():
	if num < 6:
		num += 1
		object.texture = load("res://Assets/Sprites/shapes without glare/%d.png" % num)
		object.scale = Vector2(0.1, 0.1)  
		object.modulate = Color.WHITE
		collision_follow_sprite(object, collisionshape)




func _on_settings_button_pressed():
	var menu = settings_menu.instantiate()
	var main = get_node("/root/Gamecontroller")
	main.add_child(menu)
	Global.in_menu = true
	#$UI/Camera2D/CanvasLayer/VBoxContainer.visible = false
	
func collision_follow_sprite(sprite: Sprite2D, collider: CollisionPolygon2D):
	var tex := sprite.texture
	if tex == null:
		return

	# Convert texture → image
	var img: Image = tex.get_image()
	var outline := []

	var width := img.get_width()
	var height := img.get_height()

	for y in range(height):
		for x in range(width):
			var a := img.get_pixel(x, y).a
			if a > 0.1:
				var is_edge := false
				for ny in range(-1, 2):
					for nx in range(-1, 2):
						if nx == 0 and ny == 0:
							continue
						var px := x + nx
						var py := y + ny
						if px >= 0 and py >= 0 and px < width and py < height:
							if img.get_pixel(px, py).a <= 0.1:
								is_edge = true
				if is_edge:
					outline.append(Vector2(x, y))
	if outline.size() > 8:
		var hull = Geometry2D.convex_hull(outline)
		var center = Vector2.ZERO
		for point in hull:
			center += point
		center /= hull.size()
		for i in range(hull.size()):
			var local_point = hull[i] - center
			local_point.y = -local_point.y  
			hull[i] = local_point * sprite.scale
		collider.polygon = hull
		var tex_size = Vector2(width, height)
		var sprite_offset = (tex_size / 2 - center)
		sprite_offset.y = -sprite_offset.y
		collider.position = sprite_offset * sprite.scale
