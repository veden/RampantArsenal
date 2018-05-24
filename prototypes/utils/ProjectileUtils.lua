local projectileUtils = {}


function projectileUtils.makeProjectile(attributes)
    local name = attributes.name .. "-projectile-rampant-arsenal"

    data:extend({{
		type = "projectile",
		name = name,
		flags = {"not-on-map"},
		collision_box = attributes.collisionBox or {{-0.3, -1.1}, {0.3, 1.1}},
		acceleration = attributes.acceleration or 0,
		direction_only = attributes.directionOnly,
		piercing_damage = attributes.piercingDamage or 300,
		action = attributes.action or 
		    {
			type = "direct",
			action_delivery =
			    {
				type = "instant",
				target_effects =
				    {
					{
					    type = "damage",
					    damage = {amount = 200 , type = "physical"}
					},
					{
					    type = "damage",
					    damage = {amount = 100 , type = "explosion"}
					},
					{
					    type = "create-entity",
					    entity_name = "explosion"
					}
				    }
			    }
		    },
		final_action = attributes.finalAction or
		    {
			type = "direct",
			action_delivery =
			    {
				type = "instant",
				target_effects =
				    {
					{
					    type = "create-entity",
					    entity_name = "small-scorchmark",
					    check_buildability = true
					}
				    }
			    }
		    },
		animation = attributes.animation or
		    {
			filename = "__base__/graphics/entity/laser/laser-to-tint-medium.png",
			tint = {r=1.0, g=0.0, b=0.0},
			frame_count = 1,
			scale = 5,
			width = 12,
			height = 33,
			priority = "high",
			blend_mode = "additive"
		    },
    }})
    
    return name
end

return projectileUtils
