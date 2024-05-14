extends Node

class_name PointsCounter

signal on_points_increased(points: int)
var points = 0
@onready var invader_spawner = $"../Invader_Spawner" as InvaderSpawner
@onready var ufo_spawner = $"../UfoSpawner" as UfoSpawner

func _ready():
	invader_spawner.invader_destroyed.connect(increased_points)
	ufo_spawner.ufo_destroyed.connect(increased_points)
	
func increased_points(add_to_points: int):
	points += add_to_points
	on_points_increased.emit(points)
