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
	    tint = {r=0.5,g=0,b=0.5,a=0.8},
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
	    name = "massive-fire",
	    duration = 300,
	    inDuration = 45,
	    outDuration = 30,
	    movementModifier = 0,
	    spreadRadius = 2,
	    tint = {r=0.5,g=0.3,b=0,a=0.8},
	    scale = 6
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
				    radius = 18,
				    action_delivery =
					{
					    type = "instant",
					    target_effects =
						{
						    {
							type = "damage",
							damage = { amount = 110, type = "fire" },
							apply_damage_to_trees = false
						    },
						    {
							type = "create-sticker",
							sticker = "small-fire-sticker-rampant-arsenal"
						    },
						    {
							type = "create-fire",
							entity_name = "fire-flame",
							initial_ground_flame_count = 4
						    }						    
						}
					}
				}
			}
		}
    })
    
    makeCloud(
	{
	    name = "big-poison",
	    duration = 240,
	    inDuration = 45,
	    outDuration = 30,
	    movementModifier = 0,
	    spreadRadius = 2,
	    tint = {r=0,g=0.8,b=0,a=0.8},
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
				    radius = 13,
				    entity_flags = {"breaths-air"},
				    action_delivery =
					{
					    type = "instant",
					    target_effects =
						{
						    type = "damage",
						    damage = { amount = 32, type = "poison"}
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
	    name = "massive-repair",
	    duration = 240,
	    inDuration = 45,
	    outDuration = 30,
	    movementModifier = 0,
	    spreadRadius = 2,
	    tint = {r=0.5,g=0.3,b=0,a=0.8},
	    scale = 5
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
				    radius = 20,
				    entity_flags = {"player-creation"},
				    action_delivery =
					{
					    type = "instant",
					    target_effects =
						{
						    type = "damage",
						    damage = { amount = -100, type = "healing" }
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


    local toxicCloud = makeCloud(
	{
	    name = "toxic",
	    duration = 240,
	    inDuration = 45,
	    outDuration = 30,
	    movementModifier = 0,
	    spreadRadius = 2,
	    tint = {r=0.5,g=0,b=0.5,a=0.8},
	    scale = 2.5
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
				    radius = 10,
				    action_delivery =
					{
					    type = "instant",
					    target_effects =
						{
						    {
							type = "damage",
							damage = { amount = 80, type = "poison" }
						    },
						    {
							type = "create-sticker",
							sticker = "toxic-sticker-rampant-arsenal"
						    }
						}
					}
				}
			}
		}
    })

    local paralysisCloud = makeCloud(
	{
	    name = "paralysis",
	    duration = 180,
	    inDuration = 45,
	    outDuration = 30,
	    movementModifier = 0,
	    spreadRadius = 2,
	    tint = {r=0,g=0,b=0.8,a=0.8},
	    scale = 1.5
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
				    radius = 6.5,
				    entity_flags = {"breaths-air"},
				    action_delivery =
					{
					    type = "instant",
					    target_effects =
						{
						    type = "create-sticker",
						    sticker = "paralysis-sticker-rampant-arsenal"
						}
					}
				}
			}
		}
    })

    local repairCloud = makeCloud(
	{
	    name = "repair",
	    duration = 240,
	    inDuration = 45,
	    outDuration = 30,
	    movementModifier = 0,
	    spreadRadius = 2,
	    tint = {r=0.5,g=0.3,b=0,a=0.8},
	    scale = 2.5
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
				    radius = 10,
				    entity_flags = {"player-creation"},
				    action_delivery =
					{
					    type = "instant",
					    target_effects =
						{
						    type = "damage",
						    damage = { amount = -80, type = "healing" }
						}
					}
				}
			}
		}
    })

    local healingCloud = makeCloud(
	{
	    name = "healing",
	    duration = 180,
	    inDuration = 45,
	    outDuration = 30,
	    movementModifier = 0,
	    spreadRadius = 2,
	    tint = {r=0.8,g=0,b=0,a=0.8},
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
				    radius = 12,
				    force = "ally",
				    entity_flags = {"breaths-air"},
				    action_delivery =
					{
					    type = "instant",
					    target_effects =
						{
						    type = "damage",
						    damage = { amount = -80, type = "healing" }
						}
					}
				}
			}
		}
    })
    
    local smallRepairCloud = makeCloud(
	{
	    name = "small-repair",
	    duration = 500,
	    inDuration = 10,
	    outDuration = 10,
	    movementModifier = 0,
	    cooldown = 50,
	    spreadRadius = 2,
	    tint = {r=0.5,g=0.3,b=0,a=0.1},
	    scale = 1
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
				    radius = 4,
				    entity_flags = {"player-creation"},
				    action_delivery =
					{
					    type = "instant",
					    target_effects =
						{
						    type = "damage",
						    damage = { amount = -80, type = "healing" }
						}
					}
				}
			}
		}
    })

end

return clouds
