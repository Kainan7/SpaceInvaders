extends Node

class_name LifeManager

signal life_lost(lifes_left: int)
@export var lifes = 3
@onready var player: Player = $"../Player"
var player_scene = preload("res://Cenas/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	(player as Player).player_destroyed.connect(player_lifes)

func player_lifes():
	lifes -= 1
	life_lost.emit(lifes)
	if lifes != 0:
		var player = player_scene.instantiate() as Player
		player.global_position = Vector2(0, 302)
		player.player_destroyed.connect(player_lifes)
		get_tree().root.add_child(player)
		
		
		
		
		
		
