extends Element
var armor_is_active:bool = true
@export var player:CharacterBody2D
var player_hitbox:Area2D

func load_properties(properties):
	player_hitbox = properties[0]
	player = player_hitbox.get_parent()
	var armorShape = RectangleShape2D.new()
	armorShape.set_size(player.playerSize)
	$ArmorHitbox/CollisionShape2D.shape = armorShape
	player.get_child(0).monitoring = false


func _physics_process(delta: float) -> void:
	$ArmorHitbox.global_position = player.global_position


func regenerate_armor():
	player_hitbox.monitoring = false
	armor_is_active = true

func break_armor():
	$ArmorCooldownTimer.start()
	player_hitbox.monitoring = true
	armor_is_active = false

func _on_armor_hitbox_area_entered(area: Area2D) -> void:
	if armor_is_active:
		var object = area.get_parent()
		if object.is_in_group('Projectile'):
			object.die()
			break_armor()

func _on_armor_cooldown_timer_timeout() -> void:
	regenerate_armor()
	
