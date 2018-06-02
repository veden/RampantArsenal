local lasers = {}

local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local projectileUtils = require("utils/ProjectileUtils")

local makeLaserProjectile = projectileUtils.makeLaserProjectile
local addEffectToTech = technologyUtils.addEffectToTech
local makeRecipe = recipeUtils.makeRecipe
local makeElectricTurret = turretUtils.makeElectricTurret

local function advancedLaserSheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/advanced-laser-sheet.png",
			priority = "high",
			width = 256,
			height = 256,
			line_length = 8,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0.5, -1.6},
		    },
		    {
			filename = "__RampantArsenal__/graphics/entities/advanced-laser-sheet-mask.png",
			flags = { "mask" },
			width = 256,
			height = 256,
			line_length = 8,
			axially_symmetrical = false,
			direction_count = 64,
			apply_runtime_tint = true,
			frame_count = 1,
			shift = {0.5, -1.6},
		    }
		}
	}    
end


local function lightningTowerSheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/r1_sheet.png",
			priority = "high",
			width = 96,
			height = 80,
			line_length = 16,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0.45, -0.25},
		    }
		}
	}
    
end


function lasers.enable()
    local entity = {
	name = "advanced-laser",
	icon = "__RampantArsenal__/graphics/icons/advancedLaserTurret.png",
	miningTime = 1,
	health = 3000,
	collisionBox = {{-1.75, -1.75 }, {1.75, 1.75}},
	selectionBox = {{-2, -2 }, {2, 2}},
	hasBaseDirection = true,
	order = "b[turret]-b[zzlaser-turret]",
	energySource = {
	    type = "electric",
	    buffer_capacity = "439MJ",
	    input_flow_limit = "1000MW",
	    drain = "150kW",
	    usage_priority = "primary-input"
	},
	foldedAnimation = advancedLaserSheet(),
	foldingAnimation = advancedLaserSheet(),
	preparedAnimation = advancedLaserSheet(),
	preparingAnimation = advancedLaserSheet()
    }
    local _, advancedElectricTurretItem = makeElectricTurret(entity, {
								 type = "projectile",
								 ammo_category = "electric",
								 cooldown = 120,
								 projectile_center = {-0.09375, -0.2},
								 turn_range = 0.35,
								 projectile_creation_distance = 10,
								 range = 40,
								 min_range = 7,
								 damage_modifier = 4,								 
								 ammo_type =
								     {
									 type = "projectile",
									 category = "laser-turret",
									 direction_deviation = 0.1,
									 range_deviation = 0.1,
									 clamp_position = true,
									 target_type = "position",
									 energy_consumption = "438MJ",
									 action =
									     {
										 {
										     type = "direct",
										     action_delivery =
											 {
											     {
												 type = "projectile",
												 projectile = makeLaserProjectile({
													 name = entity.name,
													 acceleration = 1,
													 piercingDamage = 1200,
													 tint = {r=0.8, g=0.0, b=0.0,a=0.9},
													 action = {
													     type = "area",
													     radius = 5,
													     action_delivery =
														 {
														     type = "instant",
														     target_effects =
															 {
															     {
																 type = "damage",
																 damage = {amount = 200 , type = "laser"}
															     },
															     {
																 type = "damage",
																 damage = {amount = 100 , type = "explosion"}
															     },
															     {
																 type = "create-entity",
																 entity_name = "big-explosion"
															     }
															 }
														 }
													 },
													 finalAction = {
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
															     },
															     {
																 type = "create-entity",
																 entity_name = "big-artillery-explosion",
																 check_buildability = true
															     }
															 }
														 }
													 }
												 }),
												 starting_speed = 0.5
											     }
											 }
										 }
									     }
								     },
								 sound = make_laser_sounds()
    })

    local entity1 = {
	name = "lightning",
	icon = "__RampantArsenal__/graphics/icons/lightningTurret.png",
	miningTime = 1,
	health = 1200,
	energySource = {
	    type = "electric",
	    buffer_capacity = "25MJ",
	    input_flow_limit = "150MW",
	    drain = "50kW",
	    usage_priority = "primary-input"
	},
	order = "b[turret]-b[zlaser-turret]",
	collisionBox = {{-0.35, -0.85}, {0.35, 0.85}},
	selectionBox = {{-0.5, -1}, {0.5, 1}},
	foldedAnimation = lightningTowerSheet(),
	foldingAnimation = lightningTowerSheet(),
	preparedAnimation = lightningTowerSheet(),
	preparingAnimation = lightningTowerSheet()
    }
    local _, lightningTowerTurretItem = makeElectricTurret(entity1, {
							       type = "beam",
							       ammo_category = "electric",
							       cooldown = 20,
							       range = 22,
							       damage_modifier = 18,
							       projectile_creation_distance = 1,
							       ammo_type =
								   {
								       category = "laser-turret",
								       energy_consumption = "5MJ",
								       action =
									   {
									       type = "line",
									       range = 22,
									       width =  10,
									       force = "enemy",
									       action_delivery =
										   {
										       type = "beam",
										       beam =  "electric-beam",
										       duration = 20
										   }
									   }
								   }
    })

    local advanceLaserRecipe = makeRecipe({
	    name = "advanced-laser",
	    icon = "__RampantArsenal__/graphics/icons/advancedLaserTurret.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 30},
		{"electric-engine-unit", 20},
		{"advanced-circuit", 30},
		{"battery", 20}
	    },
	    result = advancedElectricTurretItem,
    })

    local lightningTurretRecipe = makeRecipe({
	    name = "lightning",
	    icon = "__RampantArsenal__/graphics/icons/lightningTurret.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 15},
		{"iron-gear-wheel", 10},
		{"advanced-circuit", 10},
		{"battery", 15}
	    },
	    result = lightningTowerTurretItem,
    })

    
    addEffectToTech("lightning",
		    {
			type = "unlock-recipe",
			recipe = lightningTurretRecipe
    })

    addEffectToTech("advanced-laser-turret-2",
		    {
			type = "unlock-recipe",
			recipe = advanceLaserRecipe
    })  	
end

return lasers
