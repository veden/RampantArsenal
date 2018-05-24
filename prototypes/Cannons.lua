local cannons = {}

local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")

local makeFluidTurret = turretUtils.makeFluidTurret
local makeAmmoTurret = turretUtils.makeAmmoTurret
local makeRecipe = recipeUtils.makeRecipe
local makeTechnology = technologyUtils.makeTechnology

local function cannonMkISheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/cannon-mk1-sheet.png",
			priority = "high",
			width = 128,
			height = 128,
			line_length = 8,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0.3, -0.6},
		    }
		}
	}    
end


local function shotgunTurretSheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/shotgun-turret-sheet.png",
			priority = "high",
			width = 90,
			height = 90,
			line_length = 8,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0.3, -0.5},
		    }
		}
	}    
end

local function cannonMkIISheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/cannon-mk2-sheet.png",
			priority = "high",
			width = 128,
			height = 128,
			line_length = 8,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0.37, -0.7},
		    }
		}
	}    
end

local function cannonMkIIPlace(lineLength, directionCount, frameCount, backward)
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/cannon-mk2-place.png",
			priority = "high",
			width = 128,
			height = 128,
			line_length = lineLength or 1,
			axially_symmetrical = false,
			direction_count = directionCount or 4,
			frame_count = frameCount or 1,
			run_mode = (backward and "backward") or "forward",
			shift = {0.37, -0.7},
		    }
		}
	}    
end


local function largeCannonSheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/cr-sheet.png",
			priority = "high",
			width = 256,
			height = 256,
			line_length = 8,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0, -0.2},
		    }
		}
	}
end


function cannons.enable()
    local entity = {
	name = "cannon",
	icon = "__RampantArsenal__/graphics/icons/cannonTurret.png",
	miningTime = 1,
	health = 400,	
	collisionBox = {{-1.2, -1.2 }, {1.2, 1.2}},
	selectionBox = {{-1.4, -1.4 }, {1.4, 1.4}},
	foldedAnimation = cannonMkISheet(),
	foldingAnimation = cannonMkISheet(),
	preparedAnimation = cannonMkISheet(),
	preparingAnimation = cannonMkISheet()
    }
    local _,cannonTurretItem = makeAmmoTurret(entity,
					      {
						  type = "projectile",
						  ammo_category = "cannon-shell",
						  cooldown = 150,
						  damage_modifier = 2,
						  projectile_creation_distance = 1.39375,
						  turn_range = 0.40,
						  projectile_center = {0, -0.0875}, -- same as gun_turret_attack shift
						  shell_particle =
						      {
						  	   name = "shell-particle",
						  	   direction_deviation = 0.1,
						  	   speed = 0.01,
						  	   speed_deviation = 0.03,
						  	   center = {-0.0625, 0},
						  	   creation_distance = -1.925,
						  	   starting_frame_speed = 0.2,
						  	   starting_frame_speed_deviation = 0.1
						      },
						  range = 30,
						  sound = make_heavy_gunshot_sounds(),
    })

    local entity1 = {
	name = "rapid-cannon",
	icon = "__RampantArsenal__/graphics/icons/rapidCannonTurret.png",
	miningTime = 1,
	health = 400,
	foldedAnimation = cannonMkIIPlace(),
	preparingAnimation = cannonMkIIPlace(8, 4, 8),
	preparedAnimation = cannonMkIISheet(),
	foldingAnimation = cannonMkIIPlace(8, 4, 8, true)
    }
    local _,rapidCannonTurretItem = makeAmmoTurret(entity1, {
						       type = "projectile",
						       ammo_category = "cannon-shell",
						       cooldown = 30,
						       turn_range = 0.40,
						       projectile_creation_distance = 1.39375,
						       projectile_center = {0, -0.0875}, -- same as gun_turret_attack shift
						       -- shell_particle =
						       --     {
						       -- 	   name = "shell-particle",
						       -- 	   direction_deviation = 0.1,
						       -- 	   speed = 0.1,
						       -- 	   speed_deviation = 0.03,
						       -- 	   center = {-0.0625, 0},
						       -- 	   creation_distance = -1.925,
						       -- 	   starting_frame_speed = 0.2,
						       -- 	   starting_frame_speed_deviation = 0.1
						       --     },
						       range = 30,
						       sound = make_heavy_gunshot_sounds(),
    })

    
    local entity2 = {
    	name = "suppression-cannon",
    	icon = "__RampantArsenal__/graphics/icons/suppressionCannonTurret.png",
    	miningTime = 1,
    	health = 400,
    	collisionBox = {{-1.7, -2.2 }, {1.7, 2.2}},
    	selectionBox = {{-2, -2.5 }, {2, 2.5}},
	pipeConnections = {
	    { position = {-2.5, 2.0} },
	    { position = {2.5, 2.0} }
	},
    	foldedAnimation = largeCannonSheet(),
    	preparingAnimation = largeCannonSheet(),
    	preparedAnimation = largeCannonSheet(),
    	foldingAnimation = largeCannonSheet()
    }
    local a,suppressionCannonTurretItem = makeFluidTurret(entity2     )

    --,
    -- {
    -- 							      type = "projectile",
    -- 							      ammo_category = "cannon-shell",
    -- 							      cooldown = 45,
    -- 							      projectile_creation_distance = 1.39375,
    -- 							      projectile_center = {0, -0.0875}, -- same as gun_turret_attack shift
    -- 							      -- shell_particle =
    -- 							      --     {
    -- 							      -- 	   name = "shell-particle",
    -- 							      -- 	   direction_deviation = 0.1,
    -- 							      -- 	   speed = 0.1,
    -- 							      -- 	   speed_deviation = 0.03,
    -- 							      -- 	   center = {-0.0625, 0},
    -- 							      -- 	   creation_distance = -1.925,
    -- 							      -- 	   starting_frame_speed = 0.2,
    -- 							      -- 	   starting_frame_speed_deviation = 0.1
    -- 							      --     },
    -- 							      range = 18,
    -- 							      ammo_type =
    -- 								  {
    -- 								      type = "projectile",
    -- 								      category = "cannon-shell",
    
    -- 								      action =
    -- 									  {
    -- 									      {
    -- 										  type = "direct",
    -- 										  action_delivery =
    -- 										      {
    -- 											  {
    -- 											      type = "projectile",
    -- 											      projectile = "laser",
    -- 											      starting_speed = 0.35
    -- 											  }
    -- 										      }
    -- 									      }
    -- 									  }
    -- 								  },
    -- 							      sound = make_heavy_gunshot_sounds(),
    -- }

    
    local entity3 = {
	name = "shotgun-turret",
	icon = "__RampantArsenal__/graphics/icons/shotgunTurret.png",
	miningTime = 1,
	health = 400,
	foldedAnimation = shotgunTurretSheet(),
	preparingAnimation = shotgunTurretSheet(),
	preparedAnimation = shotgunTurretSheet(),
	foldingAnimation = shotgunTurretSheet()
    }
    local _,shotgunTurretItem = makeAmmoTurret(entity3, {
						   type = "projectile",
						   ammo_category = "shotgun-shell",
						   cooldown = 45,
						   damage_modifier = 1.5,
						   projectile_creation_distance = 1.39375,
						   projectile_center = {0, -0.0875}, -- same as gun_turret_attack shift
						   -- shell_particle =
						   --     {
						   -- 	   name = "shell-particle",
						   -- 	   direction_deviation = 0.1,
						   -- 	   speed = 0.1,
						   -- 	   speed_deviation = 0.03,
						   -- 	   center = {-0.0625, 0},
						   -- 	   creation_distance = -1.925,
						   -- 	   starting_frame_speed = 0.2,
						   -- 	   starting_frame_speed_deviation = 0.1
						   --     },
						   range = 18,
						   sound = make_heavy_gunshot_sounds(),
    })

    local cannonRecipe = makeRecipe({
	    name = "cannon",
	    icon = "__RampantArsenal__/graphics/icons/cannonTurret.png",
	    enabled = true,
	    ingredients = {
		{"steel-plate", 1}
	    },
	    result = cannonTurretItem,
    })

    local rapidCannonRecipe = makeRecipe({
	    name = "rapid-cannon",
	    icon = "__RampantArsenal__/graphics/icons/rapidCannonTurret.png",
	    enabled = true,
	    ingredients = {
		{"steel-plate", 1}
	    },
	    result = rapidCannonTurretItem,
    })

    local suppresionCannonRecipe = makeRecipe({
    	    name = "suppression-cannon",	
    	    icon = "__RampantArsenal__/graphics/icons/suppressionCannonTurret.png",
    	    enabled = true,
    	    ingredients = {
    		{"steel-plate", 1}
    	    },
    	    result = suppressionCannonTurretItem,
    })

    local shotgunTurretRecipe = makeRecipe({
	    name = "shotgun-turret",	
	    icon = "__RampantArsenal__/graphics/icons/shotgunTurret.png",
	    enabled = true,
	    ingredients = {
		{"steel-plate", 1}
	    },
	    result = shotgunTurretItem,

    })
    
    local cannonTech = makeTechnology({
	    name = "cannon-turret-1",
	    prerequisites = {"turrets","tanks"},
	    effects = {
		{
		    type = "unlock-recipe",
		    recipe = cannonRecipe,
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}		
	    },
	    count = 75,
	    time = 30
    })

    local rapidCannonTech = makeTechnology({
	    name = "cannon-turret-2",
	    prerequisites = {"explosives", "cannon-shell-speed-1", cannonTech},
	    effects = {
		{
		    type = "unlock-recipe",
		    recipe = rapidCannonRecipe,
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}		
	    },
	    count = 120,
	    time = 30
    })

    makeTechnology({
	    name = "shotgun-turret",
	    prerequisites = {"turrets"},
	    effects = {
		{
		    type = "unlock-recipe",
		    recipe = shotgunTurretRecipe,
		}
	    },
	    ingredients = {{"science-pack-1", 1}},
	    count = 20,
	    time = 10
    })

    makeTechnology({
    	    name = "cannon-turret-3",
    	    prerequisites = {"flamethrower-damage-2", "military-4", "advanced-electronics-2"},
    	    effects = {
    		{
    		    type = "unlock-recipe",
    		    recipe = suppresionCannonRecipe,
    		}
    	    },
    	    ingredients = {
    		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1},
    		{"high-tech-science-pack", 1}
    	    },
    	    count = 2000,
    	    time = 30
    })
end






return cannons
