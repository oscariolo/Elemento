extends Element
var active:bool = true
@export var player:CharacterBody2D

func load_properties(properties):
	player = properties[0].get_parent()
	var armorShape = RectangleShape2D.new()
	armorShape.set_size(player.playerSize + Vector2(2,0)) #slighlty bigger hitbox to avoid overlapping detection
	$ArmorHitbox/CollisionShape2D.shape = armorShape


func _physics_process(delta: float) -> void:
	$ArmorHitbox.global_position = player.global_position


func _on_armor_hitbox_area_entered(area: Area2D) -> void:
	if active:
		var object = area.get_parent()
		if object.is_in_group('Projectile'):
			object.die()
			active = false
			$ArmorCooldownTimer.start()


func _on_armor_cooldown_timer_timeout() -> void:
	active = true
