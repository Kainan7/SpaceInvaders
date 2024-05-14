extends Node2D

class_name UfoShooting 

@onready var spawn_timer = $SpawnTimer
var projectile_scene = preload("res://Cenas/invader_shot.tscn")
var can_ufo_shot = true



func _ready():
	spawn_timer.setup_timer()

func _on_spawn_timer_timeout():
	var projectile = projectile_scene.instantiate()
	var projectile_sprite = projectile.get_node("Sprite2D") as Sprite2D
	projectile_sprite.modulate = Color(0.62, 0.2, 0.2, 1)
	get_tree().root.add_child(projectile)
	projectile.global_position = global_position
	
