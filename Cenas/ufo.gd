extends Area2D

class_name Ufo

signal ufo_destroyed(points:int)
@export var speed = 200
@onready var sprite_2d = $Sprite2D
@onready var ufo_shooting = $UfoShooting
var explosion_texture = preload("res://Assets Space Invaders/Assets Space Invades/Ufo/Ufo-explosion.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Laser:
		area.queue_free()
		speed = 0
		sprite_2d.texture = explosion_texture
		await get_tree().create_timer(1).timeout
		queue_free()
		ufo_destroyed.emit(100)
