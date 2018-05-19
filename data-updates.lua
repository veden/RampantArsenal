
local constants = require("libs/Constants")

data.raw.fluid["alien-goo"].emissions_multiplier = 3
data.raw.fluid["alien-goo"].fuel_value = "2.5MJ"

data.raw["assembling-machine"]["centrifuge"].fluid_boxes =
    {
	{
	    production_type = "input",
	    pipe_covers = pipecoverspictures(),
	    base_area = 10,
	    base_level = -1,
	    pipe_connections = {{ type="input", position = {-1, -2} }}
	},
	{
	    production_type = "input",
	    pipe_covers = pipecoverspictures(),
	    base_area = 10,
	    base_level = -1,
	    pipe_connections = {{ type="input", position = {1, -2} }}
	},
	{
	    production_type = "output",
	    pipe_covers = pipecoverspictures(),
	    base_level = 2,
	    pipe_connections = {{ position = {-1, 2} }}
	},
	{
	    production_type = "output",
	    pipe_covers = pipecoverspictures(),
	    base_level = 2,
	    pipe_connections = {{ position = {1, 2} }}
	}
    }

print(serpent.dump(mods))

print(constants.ENABLE_NORMAL_GOO)
print(constants.ENABLE_MORE_GOO)

-- data:extend({

-- 	{
-- 	    type = "projectile",
-- 	    name = "cannon-projectile2",
-- 	    flags = {"not-on-map"},
-- 	  --  collision_box = {{-0.3, -1.1}, {0.3, 1.1}},
-- 	    --collision_box = {{-0.0, -0.0}, {0.0, 0.0}},
-- 	    collision_mask = {"layer-11"},
-- 	    acceleration = 0,
-- 	    piercing_damage = 0,
-- --	    direction_only = true,
-- 	    action =
-- 		{{
-- 			type = "area",
-- 			force = "enemy",
-- 			radius = 1,
-- 			action_delivery =
-- 			    {
-- 				type = "instant",
-- 				target_effects =
-- 				    {
-- 					{
-- 					    type = "damage",
-- 					    damage = {amount = 200 , type = "physical"}
-- 					},
-- 					{
-- 					    type = "damage",
-- 					    damage = {amount = 100 , type = "explosion"}
-- 					},
-- 					{
-- 					    type = "create-entity",
-- 					    entity_name = "explosion"
-- 					}
-- 				    }
-- 			    }
-- 		 },
-- 		    {
-- 		    type = "area",
-- 		    collision_mask = {"layer-11"},
-- 		    radius = 1,
-- 		    action_delivery =
-- 			{
-- 			    type = "instant",
-- 			    target_effects =
-- 				{
-- 				    {
-- 					type = "damage",
-- 					damage = {amount = 200 , type = "physical"}
-- 				    },
-- 				    {
-- 					type = "damage",
-- 					damage = {amount = 100 , type = "explosion"}
-- 				    },
-- 				    {
-- 					type = "create-entity",
-- 					entity_name = "explosion"
-- 				    }
-- 				}
-- 			}
-- 		}
-- 		    },
-- 	    final_action =
-- 		{
-- 		    type = "direct",
-- 		    force = "enemy",
-- 		    action_delivery =
-- 			{
-- 			    type = "instant",
-- 			    target_effects =
-- 				{
-- 				    {
-- 					type = "create-entity",
-- 					entity_name = "small-scorchmark",
-- 					check_buildability = true
-- 				    }
-- 				}
-- 			}
-- 		},
-- 	    animation =
-- 		{
-- 		    filename = "__base__/graphics/entity/bullet/bullet.png",
-- 		    frame_count = 1,
-- 		    width = 3,
-- 		    height = 50,
-- 		    priority = "high"
-- 		},
-- 	}
-- })


-- data.raw["ammo"]["firearm-magazine"].ammo_type = {
--     category = "bullet",
--     target_type = "position",
--     clamp_position = true,
--     action =
-- 	{
-- 	    type = "direct",
-- 	    force = "enemy",
-- 	    action_delivery =
-- 		{
-- 		    type = "projectile",
-- 		    projectile = "cannon-projectile2",
-- 		    starting_speed = 1,
-- 		    direction_deviation = 0.1,
-- 		    range_deviation = 0.5,
-- 		    max_range = 15,
-- 		    min_range = 5,
-- 		    source_effects =
-- 			{
-- 			    type = "create-explosion",
-- 			    entity_name = "explosion-gunshot"
-- 			},
-- 		}
-- 	},
-- }

-- for _,k in pairs(data.raw["simple-entity"]) do
--     if not k.collision_mask then
-- 	k.collision_mask = {}
--     end
--     k.collision_mask[#k.collision_mask+1] = "layer-11"
-- end

-- for _,k in pairs(data.raw["tree"]) do
--     if not k.collision_mask then
-- 	k.collision_mask = {}
--     end
--     k.collision_mask[#k.collision_mask+1] = "layer-11"
-- end
