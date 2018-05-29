local cloudUtils = {}

function cloudUtils.makeCloud(attributes, attack)
    local name = attributes.name .. "-cloud-rampant-arsenal"

    data:extend({
	    {
		type = "smoke-with-trigger",
		name = name,
		flags = {"not-on-map"},
		show_when_smoke_off = true,
		animation =
		    {
			filename = "__base__/graphics/entity/cloud/cloud-45-frames.png",
			flags = { "compressed" },
			priority = "low",
			width = 256,			
			height = 256,
			frame_count = 45,
			animation_speed = 0.5,
			line_length = 7,
			scale = attributes.scale or 3,
		    },
		slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = true,
		duration = attributes.duration or 60 * 20,
		fade_away_duration = attributes.outDuration or 2 * 60,
		spread_duration = attributes.inDuration or 10,
		color = attributes.tint or { r = 0.2, g = 0.9, b = 0.2 },
		action = attack or 
		    {
			type = "direct",
			action_delivery =
			    {
				type = "instant",
				target_effects =
				    {
					type = "nested-result",
					action =
					    {
						type = "area",
						radius = 11,
						entity_flags = {"breaths-air"},
						action_delivery =
						    {
							type = "instant",
							target_effects =
							    {
								type = "damage",
								damage = { amount = 8, type = "poison"}
							    }
						    }
					    }
				    }
			    }
		    },
		action_cooldown = attributes.cooldown or 30
	    }
    })
    
    return name
end

return cloudUtils
