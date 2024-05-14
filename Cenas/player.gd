extends Area2D

class_name Player


signal player_destroyed
@export var speed = 300 #velocidade com que o player se move
var direction = Vector2.ZERO
var bounding_size_x
var start_bound #onde começa
var end_bound #onde termina
@onready var collistion_rect: CollisionShape2D = $CollisionShape2D
@onready var animation_player = $AnimationPlayer
@onready var shooting = $Shooting
@onready var shooting_ufo = $UfoShooting


func _ready(): #funcao para ate onde o jogador vai 
	bounding_size_x = collistion_rect.shape.get_rect().size.x
	var rect = get_viewport().get_visible_rect()
	var camera = get_viewport().get_camera_2d()
	var camera_position = camera.position
	
	start_bound = (bounding_size_x - rect.size.x) / 2
	end_bound = (bounding_size_x + rect.size.x) / 2

func _process(delta): #Funcao para o movimento nas teclas para o jogador
	var input = Input.get_axis("move_left", "move_right")
	if input > 0:
		direction = Vector2.RIGHT
	elif input < 0:
		direction = Vector2.LEFT
	else:
		direction = Vector2.ZERO
	
	var delta_movement = direction.x * speed * delta
	
	#condicao para fazer a barreira para o jogador nao ir alem da tela
	if(position.x + delta_movement < start_bound + bounding_size_x * transform.get_scale().x ||
	position.x + delta_movement > end_bound - bounding_size_x * transform.get_scale().x):
		return
	
	#fazendo o player se mover
	position.x += delta_movement
	
func on_player_destroyed():
	speed = 0
	shooting.can_player_shoot = false
	shooting_ufo = false
	animation_player.play("destroy_player")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "destroy_player":
		await get_tree().create_timer(1).timeout
		player_destroyed.emit()
		queue_free()
		
		
