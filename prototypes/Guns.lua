local guns = {}

local gunUtils = require("utils/GunUtils")
local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local streamUtils = require("utils/StreamUtils")

local makeStream = streamUtils.makeStream
local makeFluidTurret = turretUtils.makeFluidTurret
local makeAmmoTurret = turretUtils.makeAmmoTurret
local makeRecipe = recipeUtils.makeRecipe
local makeTechnology = technologyUtils.makeTechnology
local addEffectToTech = technologyUtils.addEffectToTech

local makeGun = gunUtils.makeGun

function guns.enable()
    
    local mortar = makeGun(
	{
	    name = "mortar",
	    icon = "__RampantArsenal__/graphics/icons/mortar.png"
	},
	{
	    type = "stream",
	    ammo_category = "capsule-launcher",
	    cooldown = 150,
	    movement_slow_down_factor = 0.1,
	    damage_modifier = 2,
	    gun_center_shift = {
		north = {0, 0},
		east = {0, 0},
		south = {0, 0},
		west = {0, 0}
	    },
	    gun_barrel_length = 1,
	    range = 30,
	    sound = make_heavy_gunshot_sounds()
    })

    local mortarRecipe = makeRecipe({
	    name = "mortar",
	    icon = "__RampantArsenal__/graphics/icons/capsuleTurret.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 15},
		{"iron-gear-wheel", 5},
		{"copper-plate", 10},
		{"explosives", 5}
	    },
	    result = mortar,
    })


    addEffectToTech("explosives",
		    {
			type = "unlock-recipe",
			recipe = mortarRecipe,
    })
    
    -- makeTechnology({
    -- 	    name = "mortar",
    -- 	    prerequisites = {"turrets", "military-3", "explosives"},
    -- 	    icon = "__RampantArsenal__/graphics/technology/capsule-turrets.png",
    -- 	    effects = {
    -- 		{
    -- 		    type = "unlock-recipe",
    -- 		    recipe = mortarRecipe,
    -- 		}
    -- 	    },
    -- 	    ingredients = {
    -- 		{"science-pack-1", 1},
    -- 		{"science-pack-2", 1},
    -- 		{"science-pack-3", 1},
    -- 		{"military-science-pack", 1}
    -- 	    },
    -- 	    count = 100,
    -- 	    time = 30
    -- })

end

return guns
