local landmineUtils = {}

function landmineUtils.makeLandmine(attributes, attack)
    local name = attributes.name .. "-landmine-rampant-arsenal"
    
    data:extend({
	    {
		type = "item",
		name = name,
		icon = attributes.icon or "__base__/graphics/icons/gun-turret.png",
		icon_size = 32,
		flags = attributes.itemFlags or {"goes-to-quickbar"},
		subgroup = attributes.subgroup or "gun",
		order = attributes.order or "b[turret]-a[gun-turret]",
		place_result = name,
		stack_size = attributes.stackSize or 50
	    },
	    {
		type = "land-mine",
		name = name,
		icon = attributes.icon or "__base__/graphics/icons/land-mine.png",
		icon_size = 32,
		flags =
		    {
			"placeable-player",
			"placeable-enemy",
			"player-creation",
			"placeable-off-grid",
			"not-on-map"
		    },
		minable = {mining_time = 1, result = name},
		mined_sound = { filename = "__core__/sound/deconstruct-small.ogg" },
		max_health = 15,
		corpse = "small-remnants",
		collision_box = {{-0.4,-0.4}, {0.4, 0.4}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
		dying_explosion = "explosion-hit",
		resistances = attributes.resistances,
		picture_safe = attributes.pictureSafe or
		    {
			filename = "__base__/graphics/entity/land-mine/land-mine.png",
			priority = "medium",
			tint = attributes.tint,
			width = 32,
			height = 32
		    },
		picture_set = attributes.pictureSet or
		    {
			filename = "__base__/graphics/entity/land-mine/land-mine-set.png",
			priority = "medium",
			tint = attributes.tint,
			width = 32,
			height = 32
		    },
		picture_set_enemy = attributes.pictureSetEnemy or
		    {
			filename = "__base__/graphics/entity/land-mine/land-mine-set-enemy.png",
			priority = "medium",
			tint = attributes.tint,
			width = 32,
			height = 32
		    },
		trigger_radius = attributes.triggerRadius or 2.5,
		ammo_category = "landmine",
		action = attack or
		    {
			type = "direct",
			action_delivery =
			    {
				type = "instant",
				source_effects =
				    {
					{
					    type = "nested-result",
					    affects_target = true,
					    action =
						{
						    type = "area",
						    radius = 6,
						    force = "enemy",
						    action_delivery =
							{
							    type = "instant",
							    target_effects =
								{
								    {
									type = "damage",
									damage = { amount = 300, type = "explosion"}
								    },
								    {
									type = "create-sticker",
									sticker = "stun-sticker"
								    }
								}
							}
						},
					},
					{
					    type = "create-entity",
					    entity_name = "explosion"
					},
					{
					    type = "damage",
					    damage = { amount = 1000, type = "explosion"}
					}
				    }
			    }
		    }
	    }
    })


    return name
end

return landmineUtils
