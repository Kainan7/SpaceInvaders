extends Node2D

class_name InvaderSpawner

signal invader_destroyed(points:int)
signal game_won
signal game_lost

const ROWS = 5
const COLLUMNS = 11

const HORIZONTAL_SPACING = 32
const VERTICAL_SPACING = 32
const INVADER_HEIGHT = 24
const START_Y_POSITION = -50
const INVADER_POSITION_X_INCREMENT = 10
const INVADER_POSITION_Y_INCREMENT = 20

var movement_direction = 1
@onready var movement_timer = $MovementTimer
@onready var shot_timer = $ShotTimer
var invader_scene = preload("res://Cenas/invader.tscn")
var invader_shot_scene = preload("res://Cenas/invader_shot.tscn")
var invader_destroyed_count = 0
var invader_total_count = ROWS * COLLUMNS
var can_invader_shoot = true


func _ready():
	var invader_1_res = preload("res://Resources/invader_1.tres")
	var invader_2_res= preload("res://Resources/invader_2.tres")
	var invader_3_res= preload("res://Resources/invader_3.tres")
	var invader_config 
	
	for row in ROWS:
		if row == 0:
			invader_config = invader_1_res
		elif row == 1 || row == 2:
			invader_config = invader_2_res
		elif row == 3 || row == 4:
			invader_config = invader_3_res
		
		var row_width = (COLLUMNS*invader_config.width*3) + (COLLUMNS-1) * HORIZONTAL_SPACING 
		var start_x = (position.x - row_width) / 2
		
		for col in COLLUMNS:
			var x = start_x + (col * invader_config.width * 3) + (col * HORIZONTAL_SPACING)
			var y = START_Y_POSITION + (row * INVADER_HEIGHT) + (row * VERTICAL_SPACING)
			var spawn_position = Vector2(x,y)
			spawn_invader(invader_config, spawn_position)

func spawn_invader(invader_config, spawn_position: Vector2):
	var invader = invader_scene.instantiate() as Invader
	invader.config = invader_config
	invader.global_position = spawn_position
	invader.invader_destroyed.connect(on_invader_destroyed)
	add_child(invader)


func _on_movement_timer_timeout():
	position.x += INVADER_POSITION_X_INCREMENT * movement_direction


func _on_left_wall_area_entered(area):
	if (movement_direction == -1):
		position.y += INVADER_POSITION_Y_INCREMENT
		movement_direction *= -1


func _on_right_wall_area_entered(area):
	if (movement_direction == 1):
		position.y += INVADER_POSITION_Y_INCREMENT
		movement_direction *= -1


func _on_shot_timer_timeout():
	if can_invader_shoot:
		var random_child_position = get_children().filter(func (child): return child as Invader).map(func (invader): return invader.global_position).pick_random()
		var invader_shot = invader_shot_scene.instantiate() as InvaderShot
		get_tree().root.add_child(invader_shot)
		invader_shot.global_position = random_child_position
	
	
func on_invader_destroyed(points:int):
	invader_destroyed.emit(points)
	invader_destroyed_count += 1
	if invader_destroyed_count == invader_total_count:
		game_won.emit()
		movement_timer.stop()
		shot_timer.stop()


func _on_buttom_wall_area_entered(area):
	game_lost.emit(0)
	movement_timer.stop()
	movement_direction.stop()
	
