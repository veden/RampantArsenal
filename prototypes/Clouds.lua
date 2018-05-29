local clouds = {}

local cloudUtils = require("utils/CloudUtils")

local makeCloud = cloudUtils.makeCloud

function clouds.enable()

    makeCloud(
	{
	    name = "big-toxic",
	    duration = 240,
	    inDuration = 45,
	    outDuration = 30,
	    movementModifier = 0,
	    spreadRadius = 2,
	    tint = {r=0,g=0.3,b=0.5,a=0.8},
	    scale = 3
	},
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
				    radius = 12,
				    action_delivery =
					{
					    type = "instant",
					    target_effects =
						{
						    {
							type = "damage",
							damage = { amount = 110, type = "poison" }
						    },
						    {
							type = "create-sticker",
							sticker = "big-toxic-sticker-rampant-arsenal"
						    }
						}
					}
				}
			}
		}
    })

    makeCloud(
	{
	    name = "big-repair",
	    duration = 240,
	    inDuration = 45,
	    outDuration = 30,
	    movementModifier = 0,
	    spreadRadius = 2,
	    tint = {r=0.5,g=0.3,b=0,a=0.8},
	    scale = 3
	},
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
				    radius = 12,
				    entity_flags = {"player-creation"},
				    action_delivery =
					{
					    type = "instant",
					    target_effects =
						{
						    type = "damage",
						    damage = { amount = -110, type = "healing" }
						}
					}
				}
			}
		}
    })

    makeCloud(
	{
	    name = "big-paralysis",
	    duration = 180,
	    inDuration = 45,
	    outDuration = 30,
	    movementModifier = 0,
	    spreadRadius = 2,
	    tint = {r=0,g=0,b=0.8,a=0.8},
	    scale = 2
	},
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
				    radius = 9.5,
				    entity_flags = {"breaths-air"},
				    action_delivery =
					{
					    type = "instant",
					    target_effects =
						{
						    type = "create-sticker",
						    sticker = "big-paralysis-sticker-rampant-arsenal"
						}
					}
				}
			}
		}
    })


end

return clouds
