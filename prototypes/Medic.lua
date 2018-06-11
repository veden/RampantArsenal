local medic = {}

local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local projectileUtils = require("utils/ProjectileUtils")
local ammoUtils = require("utils/AmmoUtils")
local turretUtils = require("utils/TurretUtils")

local makeAmmoTurret = turretUtils.makeAmmoTurret
local makeBombWave = projectileUtils.makeBombWave
local makeAmmo = ammoUtils.makeAmmo
local addEffectToTech = technologyUtils.addEffectToTech
local makeRecipe = recipeUtils.makeRecipe

local function medicSheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/zone-expander.png",
			priority = "high",
			width = 96,
			height = 128,
			line_length = 4,
			scale = 1,
			run_mode = "forward",
			direction_count = 1,
			frame_count = 16,
			shift = {-0.2, -1},
		    }
		}
	}    
end


function medic.enable()

    data:extend(
	{	    
	    {
		type = "ammo-category",
		name = "turret-capsule",
	    }	    
    })
    
    local medicTurretAttributes = {
	name = "medic",
	icon = "__RampantArsenal__/graphics/icons/zone-expander.png",
	miningTime = 1,
	health = 1000,
	order = "b[turret]-a[zzzzmedic-turret]",
	collisionBox = {{-1, -1 }, {1, 1}},
	selectionBox = {{-1.2, -1.2 }, {1, 1}},
	hasBaseDirection = true,
	foldedAnimation = medicSheet(),
	foldingAnimation = medicSheet(),
	preparedAnimation = medicSheet(),
	preparingAnimation = medicSheet()
    }
    local medicTurret,medicTurretItem = makeAmmoTurret(medicTurretAttributes,
						       {
							   type = "projectile",
							   ammo_category = "turret-capsule",
							   cooldown = 300,
							   warmup = 240,
							   projectile_creation_distance = 1,
							   damage_modifier = 1,
							   projectile_center = {0, 0},
							   range = 28,
							   sound = make_heavy_gunshot_sounds(),
    })

    local medicTurretRecipe = makeRecipe({
	    name = "medic-turret",
	    icon = "__RampantArsenal__/graphics/icons/zone-expander.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"engine-unit", 5},
		{"advanced-circuit", 5},
		{"steel-plate", 15}		
	    },
	    result = medicTurretItem
    })


    local repairCapsules = makeAmmo({		    
	    name = "self-repair-capsule",
	    icon = "__RampantArsenal__/graphics/icons/medic-repair-pack.png",
	    subgroup = "launcher-capsule",
	    order = "y[turret-capsule]",
	    magSize = 15,
	    stackSize = 200,
	    ammoType = {		
		category = "turret-capsule",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "projectile",
				max_range = 0,
				starting_speed = 1,
				projectile = makeBombWave(
				    {
					name = "repair"
				    },
				    {
					type = "direct",
					action_delivery =
					    {
						type = "instant",
						target_effects =
						    {
							{
							    type = "create-entity",
							    entity_name = "massive-repair-cloud-rampant-arsenal",
							    show_in_tooltip = true
							}
						    }
					    }
				})
			    }
		    }
    }})

    local repairSelfAmmoRecipe = makeRecipe({
	    name = "repair-self-ammo",
	    icon = "__RampantArsenal__/graphics/icons/medic-repair-pack.png",
	    enabled = false,
	    ingredients = {
		{"copper-plate", 2},
		{"repair-capsule-rampant-arsenal", 5},
		{"advanced-circuit", 2}
	    },
	    result = repairCapsules
    })

    addEffectToTech("regeneration-turrets",
		    {
			type = "unlock-recipe",
			recipe = medicTurretRecipe
    })

    addEffectToTech("regeneration-turrets",
		    {
			type = "unlock-recipe",
			recipe = repairSelfAmmoRecipe
    })


    addEffectToTech("capsule-turret-damage-1",
		    {
			type = "turret-attack",
			turret_id = medicTurret,
			modifier = 0.1
    })

    addEffectToTech("capsule-turret-damage-2",
		    {
			type = "turret-attack",
			turret_id = medicTurret,
			modifier = 0.1
    })

    addEffectToTech("capsule-turret-damage-3",
		    {
			type = "turret-attack",
			turret_id = medicTurret,
			modifier = 0.2
    })

    addEffectToTech("capsule-turret-damage-4",
		    {
			type = "turret-attack",
			turret_id = medicTurret,
			modifier = 0.3
    })

    addEffectToTech("capsule-turret-damage-5",
		    {
			type = "turret-attack",
			turret_id = medicTurret,
			modifier = 0.3
    })

    addEffectToTech("capsule-turret-damage-6",
		    {
			type = "turret-attack",
			turret_id = medicTurret,
			modifier = 0.4
    })

    addEffectToTech("capsule-turret-damage-7",
		    {
			type = "turret-attack",
			turret_id = medicTurret,
			modifier = 0.2
    })

    addEffectToTech("grenade-damage-1",
		    {
			type = "ammo-damage",
			ammo_category = "turret-capsule",
			modifier = 0.2
    })

    addEffectToTech("grenade-damage-2",
		    {
			type = "ammo-damage",
			ammo_category = "turret-capsule",
			modifier = 0.2
    })

    addEffectToTech("grenade-damage-3",
		    {
			type = "ammo-damage",
			ammo_category = "turret-capsule",
			modifier = 0.3
    })

    addEffectToTech("grenade-damage-4",
		    {
			type = "ammo-damage",
			ammo_category = "turret-capsule",
			modifier = 0.3
    })

    addEffectToTech("grenade-damage-5",
		    {
			type = "ammo-damage",
			ammo_category = "turret-capsule",
			modifier = 0.4
    })

    addEffectToTech("grenade-damage-6",
		    {
			type = "ammo-damage",
			ammo_category = "turret-capsule",
			modifier = 0.2
    })

    addEffectToTech("grenade-damage-7",
		    {
			type = "ammo-damage",
			ammo_category = "turret-capsule",
			modifier = 0.2
    })

    
end

return medic
