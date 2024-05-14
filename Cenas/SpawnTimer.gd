extends Timer
class_name SpawnTimer

@export var min_timer = 1
@export var max_timer = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func setup_timer():
	var random_timer = randi_range(min_timer, max_timer)
	self.wait_time =random_timer
	self.stop()
	self.start()
