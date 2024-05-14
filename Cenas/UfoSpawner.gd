extends Node2D

class_name UfoSpawner

signal ufo_destroyed(points:int)
@onready var spawn_timer = $SpawnTimer
var ufo_scene =preload("res://Cenas/ufo.tscn")
var ufo_destroyed_count = 0
var can_ufo_spawn = true

# Called when the node enters the scene tree for the first time.
func _ready():
	(spawn_timer as SpawnTimer).setup_timer()


func _on_spawn_timer_timeout():
	if can_ufo_spawn:
		var ufo = ufo_scene.instantiate() as Ufo
		get_tree().root.add_child(ufo)
		ufo.global_position = position
		ufo.ufo_destroyed.connect(on_ufo_destroyed)
		add_child(ufo)


func on_ufo_destroyed(points:int):
	ufo_destroyed.emit(points)
	ufo_destroyed_count += 1
