extends Element
var active:bool = true
var player:CharacterBody2D

func load_properties(properties):
	player = properties[0].get_parent()
	var armorShape = RectangleShape2D.new()
	armorShape.set_size(player.playerSize)
	$ArmorHitbox/CollisionShape2D.shape = armorShape


func _physics_process(delta: float) -> void:
	$ArmorHitbox.global_position = player.global_position


func _on_armor_hitbox_area_entered(area: Area2D) -> void:
	print("hit armor")
	if area.is_in_group('Projectile'):
		active = false
