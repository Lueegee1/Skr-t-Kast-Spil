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
@onready var foreground = $UI/Camera2D/CanvasLayer/Foreground
var possible_angles = [45,45]

# Upgrade Button Nodes
@onready var upgbtn1 = $UI/Camera2D/CanvasLayer/VBoxContainer/Rrrelooc
@onready var name1 = $UI/Camera2D/CanvasLayer/VBoxContainer/Coolerrrr 
@onready var upgbtn2 = $UI/Camera2D/CanvasLayer/VBoxContainer/Rrrelooc2
@onready var name2 = $UI/Camera2D/CanvasLayer/VBoxContainer/Coolerrrr2
@onready var upgbtn3 = $UI/Camera2D/CanvasLayer/VBoxContainer/Rrrelooc3
@onready var name3 = $UI/Camera2D/CanvasLayer/VBoxContainer/Coolerrrr3
@onready var upgbtn4 = $UI/Camera2D/CanvasLayer/VBoxContainer/Rrrelooc4
@onready var name4 = $UI/Camera2D/CanvasLayer/VBoxContainer/Coolerrrr4
@onready var upgbtn5 = $UI/Camera2D/CanvasLayer/VBoxContainer/Rrrelooc5
@onready var name5 = $UI/Camera2D/CanvasLayer/VBoxContainer/Coolerrrr5
@onready var upgbtn6 = $UI/Camera2D/CanvasLayer/VBoxContainer/Rrrelooc6
@onready var name6 = $UI/Camera2D/CanvasLayer/VBoxContainer/Coolerrrr6
@onready var upgbtn7 = $UI/Camera2D/CanvasLayer/VBoxContainer/Rrrelooc7
@onready var name7 = $UI/Camera2D/CanvasLayer/VBoxContainer/Coolerrrr7

var offsetXP = Vector2(0,0)
var offsetMoney = Vector2(200,0)
var offsetPrestige = Vector2(400,0)
var offsetUpgrades = Vector2(800,0)
var offsetForeground = Vector2(576,324)

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
var button_labels = []
var map

@onready var object = $LaunchSite/RigidBody2D/Sprite2D 
@onready var collisionshape = $LaunchSite/RigidBody2D/CollisionPolygon2D

# ---------------------------------------------------------
# Load your font ONCE
# ---------------------------------------------------------
var ui_font := preload("res://Assets/Roboto-Medium.ttf")

# ---------------------------------------------------------
# Fixed attach_text()
# ---------------------------------------------------------
func attach_text(parent: Node, txt: String, offset := Vector2(0,0), font_size := 24):
	var lbl := Label.new()
	lbl.text = txt
	if parent is Control:
		lbl.size = parent.size
	else:
		lbl.size = Vector2(80, 40)
	lbl.position = offset
	lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	lbl.add_theme_font_override("font", ui_font)
	lbl.add_theme_font_size_override("font_size", font_size)
	parent.add_child(lbl)
	return lbl



func _ready() -> void:
	Global.UI = self
	object.texture = load("res://Assets/Sprites/shapes without glare/%d.png" % num)
	object.scale = Vector2(0.1,0.1)
	collision_follow_sprite(object, collisionshape)

	# Name texts with custom position + font size
	attach_text(name1, "Increase possible angles", Vector2(-168, -17), 30)
	attach_text(name2, "Reduce gravity on object", Vector2(-168, -17), 30)
	attach_text(name3, "Reduce objects friction", Vector2(-160, -17), 30)
	attach_text(name4, "Increase ground elasticity", Vector2(-170, -17), 30)
	attach_text(name5, "Increase initial launch speed", Vector2(-187, -17), 30)
	attach_text(name6, "Decrease air resistance", Vector2(-160, -17), 30)
	attach_text(name7, "Change object shape", Vector2(-140, -17), 30)

	# Buttons
	button_labels = [
		attach_text(upgbtn1, str(angle_price), Vector2(-20,-20), 34),
		attach_text(upgbtn2, str(gravity_price), Vector2(-20,-20), 34),
		attach_text(upgbtn3, str(friction_price), Vector2(-20,-20), 34),
		attach_text(upgbtn4, str(elasticity_price), Vector2(-20,-20), 34),
		attach_text(upgbtn5, str(speed_price), Vector2(-20,-20), 34),
		attach_text(upgbtn6, str(air_resistance_price), Vector2(-20,-20), 34),
		attach_text(upgbtn7, str(change_shape_price), Vector2(-20,-20), 34),
	]
	map = {
		upgbtn1: $UI/Camera2D/CanvasLayer/VBoxContainer/AngleUpgrade,
		upgbtn2: $UI/Camera2D/CanvasLayer/VBoxContainer/GravityUpgrade,
		upgbtn3: $UI/Camera2D/CanvasLayer/VBoxContainer/FrictionUpgrade,
		upgbtn4: $UI/Camera2D/CanvasLayer/VBoxContainer/ElasticityUpgrade,
		upgbtn5: $UI/Camera2D/CanvasLayer/VBoxContainer/SpeedUpgrade,
		upgbtn6: $UI/Camera2D/CanvasLayer/VBoxContainer/AirResistanceUpgrade,
		upgbtn7: $UI/Camera2D/CanvasLayer/VBoxContainer/Shape,
	}


func _rounding(num):
	var exponent = int(log(num+1)/log(10))
	var suffixes = ["","K","M","B","T","Qu","Qi","Sx","Sp","O","N","Dc"]
	for i in range(suffixes.size()):
		if (3*i) <= exponent and exponent < (3+3*i):
			exponent = 3*i
			return str((round(float(num)/(10**exponent)*10))/10) + suffixes[i]
	return str(num)

func _process(_delta: float):
	Camera.global_position.x = RigidBody.global_position.x + 288
	Camera.global_position.y = RigidBody.global_position.y - 162

	XpLabel.text = _rounding(Global.exp)
	MoneyLabel.text = _rounding(Global.money)
	PrestigeLabel.text = ""

	XpLabel.position = offsetXP
	MoneyLabel.position = offsetMoney
	PrestigeLabel.position = offsetPrestige
	Upgrades.position = offsetUpgrades
	foreground.position = offsetForeground

	shopPosUpdate()
	update_upgrade_labels()
	for sprite_button in map.keys():
		var btnInputOffset = Vector2(45,10)
		var btn = map[sprite_button]
		btn.position = sprite_button.position - btnInputOffset
	$UI/Camera2D/CanvasLayer/VBoxContainer/Settings.position = Vector2(250,20)

var list_start_pos := Vector2(233, 150)
var name_to_button_gap := 30
var entry_gap := 70
var button_x_offset := 51

func shopPosUpdate():
	var ordered_items = [
		name1, upgbtn1,
		name2, upgbtn2,
		name3, upgbtn3,
		name4, upgbtn4,
		name5, upgbtn5,
		name6, upgbtn6,
		name7, upgbtn7
	]
	var y_offset := list_start_pos.y
	for i in range(0, ordered_items.size(), 2):
		var name_node = ordered_items[i]
		var button_node = ordered_items[i + 1]
		name_node.position = Vector2(list_start_pos.x, y_offset)
		button_node.position = Vector2(list_start_pos.x + button_x_offset, y_offset + name_to_button_gap)
		y_offset += entry_gap


func buy_and_upgrade(cost_ref: String, property_name: String, upgrade_value: float, multiplier: float, min_value := -INF, max_value := INF):
	var cost = self.get(cost_ref)
	if Global.money > cost:
		if Global.Ball[property_name] + upgrade_value > min_value and Global.Ball[property_name] + upgrade_value < max_value:
			Global.Ball[property_name] += upgrade_value
			Global.money -= cost
			cost *= multiplier
			self.set(cost_ref, cost)

func _on_angle_changed(value: float):
	if not Global.in_menu:
		Global.Ball.launch_angle = value

func _on_angle_upgrade_pressed():
	if not Global.in_menu:
		if Global.money > angle_price:
			if angle.min_value > 0 and angle.max_value < 90:
				angle.min_value -= 5
				angle.max_value += 5
				angle_price *= 2

func update_upgrade_labels():
	button_labels[0].text = _rounding(angle_price)
	button_labels[1].text = _rounding(gravity_price)
	button_labels[2].text = _rounding(friction_price)
	button_labels[3].text = _rounding(elasticity_price)
	button_labels[4].text = _rounding(speed_price)
	button_labels[5].text = _rounding(air_resistance_price)
	button_labels[6].text = _rounding(change_shape_price)

func _on_gravity_upgrade_pressed():
	if not Global.in_menu:
		buy_and_upgrade("gravity_price", "gravity", -0.05, 2, 0.1)


func _on_friction_upgrade_pressed():
	if not Global.in_menu:
		buy_and_upgrade("friction_price", "ground_friction", -0.05, 2, 0.000001)

func _on_elasticity_upgrade_pressed():
	if not Global.in_menu: 
		buy_and_upgrade("elasticity_price", "ground_elasticity", 0.1, 2,0,0.9)

func _on_speed_upgrade_pressed():
	if not Global.in_menu:
		buy_and_upgrade("speed_price", "launch_speed", 100, 2)

func _on_air_resistance_upgrade_pressed():
	if not Global.in_menu:
		buy_and_upgrade("air_resistance_price", "air_resistance", -0.001, 2)

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

func collision_follow_sprite(sprite: Sprite2D, collider: CollisionPolygon2D):
	var tex := sprite.texture
	if tex == null:
		return

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

		# compute image center of the hull
		var center = Vector2.ZERO
		for point in hull:
			center += point
		center /= hull.size()
		var polygon_points := []
		for point in hull:
			var local_point = (point - center) * sprite.scale
			polygon_points.append(local_point)
		collider.polygon = polygon_points

		var tex_size = Vector2(width, height)
		var sprite_offset = (tex_size / 2.0 - center) * sprite.scale
		collider.position = sprite_offset
