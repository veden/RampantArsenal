local technologies = {}

local technologyUtils = require("utils/TechnologyUtils")

local makeTechnology = technologyUtils.makeTechnology

function technologies.enable()

    local incendiary = makeTechnology({
	    name="incendiary",
	    icon="__RampantArsenal__/graphics/technology/incendiary.png",
	    prerequisites = {"flamethrower"},
	    effects = {},
	    count = 75,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30
    })

    makeTechnology({
	    name="incendiary-napalm",
	    icon="__RampantArsenal__/graphics/technology/incendiary-napalm.png",
	    prerequisites = {incendiary, "sulfur-processing"},
	    effects = {},
	    count = 75,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30
    })


    local he = makeTechnology({
	    name="high-explosives",
	    icon="__RampantArsenal__/graphics/technology/he-ordnance.png",
	    prerequisites = {"explosives"},
	    effects = {},
	    count = 75,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30
    })

    local bioweapons = makeTechnology({
	    name="bio-weapons",
	    icon="__RampantArsenal__/graphics/technology/biowarfare.png",
	    prerequisites = {"military-3"},
	    effects = {},
	    count = 75,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30
    })

    
    makeTechnology({
	    name="incendiary-grenades",
	    icon="__RampantArsenal__/graphics/technology/incendiary-grenades.png",
	    prerequisites = {"explosives", "military-3", incendiary},
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30
    })
    
    makeTechnology({
	    name="incendiary-landmine",
	    icon="__RampantArsenal__/graphics/technology/incendiary-landmines.png",
	    prerequisites = {"land-mine", incendiary},
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30
    })

    makeTechnology({
	    name="bio-landmine",
	    icon="__RampantArsenal__/graphics/technology/bio-landmines.png",
	    prerequisites = {"land-mine", bioweapons},
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30
    })

    makeTechnology({
	    name="he-landmine",
	    icon="__RampantArsenal__/graphics/technology/he-landmines.png",
	    prerequisites = {"land-mine", he},
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30
    })

    
    makeTechnology({
	    name="incendiary-cannon-shells",
	    icon="__RampantArsenal__/graphics/technology/incendiary-cannon-shells.png",
	    prerequisites = {"military-3", "tanks", incendiary},
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30
    })

    makeTechnology({
	    name="bio-cannon-shells",
	    icon="__RampantArsenal__/graphics/technology/bio-cannon-shells.png",
	    prerequisites = {"military-3", "tanks", bioweapons},
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30
    })

    makeTechnology({
	    name="he-cannon-shells",
	    icon="__RampantArsenal__/graphics/technology/he-cannon-shells.png",
	    prerequisites = {"military-3", "tanks", he},
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30
    })

    makeTechnology({
	    name="incendiary-artillery-shells",
	    icon="__RampantArsenal__/graphics/technology/incendiary-artillery-shells.png",
	    prerequisites = {"turrets", "artillery", incendiary},
	    effects = {},
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

    makeTechnology({
	    name="bio-artillery-shells",
	    icon="__RampantArsenal__/graphics/technology/bio-artillery-shells.png",
	    prerequisites = {"turrets", "artillery", bioweapons},
	    effects = {},
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

    makeTechnology({
	    name="he-artillery-shells",
	    icon="__RampantArsenal__/graphics/technology/he-artillery-shells.png",
	    prerequisites = {"artillery", "explosives", he},
	    effects = {},
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
    
    makeTechnology({
	    name="he-grenades",
	    icon="__RampantArsenal__/graphics/technology/he-grenades.png",
	    prerequisites = {he},
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30
    })

    makeTechnology({
	    name="bio-grenades",
	    icon="__RampantArsenal__/graphics/technology/bio-grenades.png",
	    prerequisites = {bioweapons},
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30
    })

    makeTechnology({
	    name="bio-capsules",
	    icon="__RampantArsenal__/graphics/technology/bio-capsules.png",
	    prerequisites = {"military-4", "explosives", bioweapons},
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30
    })
    
    local capsuleTurretTech = makeTechnology({
	    name = "capsule-turret",
	    prerequisites = {"turrets", "military-3", "explosives"},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turrets.png",
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30
    })

    local capsuleTurretSpeed1 = makeTechnology({
	    name = "capsule-turret-speed-1",
	    prerequisites = {capsuleTurretTech},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-speed.png",
	    upgrade = true,
	    effects = {
		{
		    type = "gun-speed",
		    ammo_category = "capsule-launcher",
		    modifier = 0.1
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30
    })

    local capsuleTurretSpeed2 = makeTechnology({
	    name = "capsule-turret-speed-2",	    
	    prerequisites = {capsuleTurretSpeed1},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-speed.png",
	    upgrade = true,
	    effects = {
		{
		    type = "gun-speed",
		    ammo_category = "capsule-launcher",
		    modifier = 0.1
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 150,
	    time = 45
    })

    local capsuleTurretSpeed3 = makeTechnology({
	    name = "capsule-turret-speed-3",
	    prerequisites = {capsuleTurretSpeed2},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-speed.png",
	    upgrade = true,
	    effects = {
		{
		    type = "gun-speed",
		    ammo_category = "capsule-launcher",
		    modifier = 0.2
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 300,
	    time = 50
    })

    local capsuleTurretSpeed4 = makeTechnology({
	    name = "capsule-turret-speed-4",
	    prerequisites = {capsuleTurretSpeed3},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-speed.png",
	    upgrade = true,
	    effects = {
		{
		    type = "gun-speed",
		    ammo_category = "capsule-launcher",
		    modifier = 0.3
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 300,
	    time = 60
    })


    local capsuleTurretSpeed5 = makeTechnology({
	    name = "capsule-turret-speed-5",
	    prerequisites = {capsuleTurretSpeed4},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-speed.png",
	    upgrade = true,
	    effects = {
		{
		    type = "gun-speed",
		    ammo_category = "capsule-launcher",
		    modifier = 0.3
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 1000,
	    time = 60
    })

    makeTechnology({
	    name = "capsule-turret-speed-6",
	    prerequisites = {capsuleTurretSpeed5},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-speed.png",
	    upgrade = true,
	    effects = {
		{
		    type = "gun-speed",
		    ammo_category = "capsule-launcher",
		    modifier = 0.4
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 3000,
	    time = 60
    })

    local capsuleTurretDamage1 = makeTechnology({
	    name = "capsule-turret-damage-1",
	    prerequisites = {capsuleTurretTech},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30
    })

    local capsuleTurretDamage2 = makeTechnology({
	    name = "capsule-turret-damage-2",	    
	    prerequisites = {capsuleTurretDamage1},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 150,
	    time = 45
    })

    local capsuleTurretDamage3 = makeTechnology({
	    name = "capsule-turret-damage-3",
	    prerequisites = {capsuleTurretDamage2},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 300,
	    time = 50
    })

    local capsuleTurretDamage4 = makeTechnology({
	    name = "capsule-turret-damage-4",
	    prerequisites = {capsuleTurretDamage3},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 300,
	    time = 60
    })


    local capsuleTurretDamage5 = makeTechnology({
	    name = "capsule-turret-damage-5",
	    prerequisites = {capsuleTurretDamage4},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 1000,
	    time = 60
    })

    local capsuleTurretDamage6 = makeTechnology({
	    name = "capsule-turret-damage-6",
	    prerequisites = {capsuleTurretDamage5},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 3000,
	    time = 60
    })


    makeTechnology({
	    name = "capsule-turret-damage-7",
	    prerequisites = {capsuleTurretDamage6},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-damage.png",
	    upgrade = true,
	    maxLevel = "infinite",
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"space-science-pack", 1}
	    },
	    countForumla = "2^(L-7)*1000",
	    time = 60,
	    order = "e-z-f"
    })


    local cannonTech = makeTechnology({
	    name = "cannon-turret-1",
	    prerequisites = {"turrets","tanks","concrete","steel-processing"},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turrets.png",
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}		
	    },
	    count = 75,
	    time = 30
    })

    makeTechnology({
	    name = "cannon-turret-2",
	    prerequisites = {"explosives", "cannon-shell-speed-1", cannonTech},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turrets.png",
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}		
	    },
	    count = 120,
	    time = 30
    })

    local shotgunTurretTech = makeTechnology({
	    name = "shotgun",
	    prerequisites = {"turrets","steel-processing","military"},
	    icon = "__RampantArsenal__/graphics/technology/shotgun-turrets.png",
	    effects = {},
	    ingredients = {{"science-pack-1", 1}},
	    count = 20,
	    time = 10
    })

    makeTechnology({
    	    name = "flamethrower-2",
    	    prerequisites = {"flamethrower-damage-2", "military-4", "advanced-electronics-2", "concrete"},
	    icon = "__base__/graphics/technology/flamethrower.png",
    	    effects = {},
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

    local shotgunTurretDamage1 = makeTechnology({
	    name = "shotgun-turret-damage-1",
	    prerequisites = {shotgunTurretTech},
	    icon = "__RampantArsenal__/graphics/technology/shotgun-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1}
	    },
	    count = 50,
	    time = 30,
	    order = "e-z-a"
    })

    local shotgunTurretDamage2 = makeTechnology({
	    name = "shotgun-turret-damage-2",
	    prerequisites = {shotgunTurretDamage1},
	    icon = "__RampantArsenal__/graphics/technology/shotgun-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1}
	    },
	    count = 100,
	    time = 45,
	    order = "e-z-b"
    })

    local shotgunTurretDamage3 = makeTechnology({
	    name = "shotgun-turret-damage-3",
	    prerequisites = {shotgunTurretDamage2},
	    icon = "__RampantArsenal__/graphics/technology/shotgun-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"military-science-pack", 1}
	    },
	    count = 300,
	    time = 50,
	    order = "e-z-c"
    })

    local shotgunTurretDamage4 = makeTechnology({
	    name = "shotgun-turret-damage-4",
	    prerequisites = {shotgunTurretDamage3},
	    icon = "__RampantArsenal__/graphics/technology/shotgun-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"military-science-pack", 1}
	    },
	    count = 300,
	    time = 60,
	    order = "e-z-d"
    })


    local shotgunTurretDamage5 = makeTechnology({
	    name = "shotgun-turret-damage-5",
	    prerequisites = {shotgunTurretDamage4},
	    icon = "__RampantArsenal__/graphics/technology/shotgun-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 1000,
	    time = 60,
	    order = "e-z-e"
    })

    local shotgunTurretDamage6 = makeTechnology({
	    name = "shotgun-turret-damage-6",
	    prerequisites = {shotgunTurretDamage5},
	    icon = "__RampantArsenal__/graphics/technology/shotgun-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 3000,
	    time = 60,
	    order = "e-z-f"
    })

    makeTechnology({
	    name = "shotgun-turret-damage-7",
	    prerequisites = {shotgunTurretDamage6},
	    icon = "__RampantArsenal__/graphics/technology/shotgun-turret-damage.png",
	    upgrade = true,
	    maxLevel = "infinite",
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"space-science-pack", 1}
	    },
	    countForumla = "2^(L-7)*1000",
	    time = 60,
	    order = "e-z-f"
    })

    local cannonTurretDamage1 = makeTechnology({
	    name = "cannon-turret-damage-1",
	    prerequisites = {cannonTech},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30,
	    order = "e-z-a"
    })

    local cannonTurretDamage2 = makeTechnology({
	    name = "cannon-turret-damage-2",
	    prerequisites = {cannonTurretDamage1},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 150,
	    time = 45,
	    order = "e-z-b"
    })

    local cannonTurretDamage3 = makeTechnology({
	    name = "cannon-turret-damage-3",
	    prerequisites = {cannonTurretDamage2},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 300,
	    time = 50,
	    order = "e-z-c"
    })

    local cannonTurretDamage4 = makeTechnology({
	    name = "cannon-turret-damage-4",
	    prerequisites = {cannonTurretDamage3},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 300,
	    time = 60,
	    order = "e-z-d"
    })


    local cannonTurretDamage5 = makeTechnology({
	    name = "cannon-turret-damage-5",
	    prerequisites = {cannonTurretDamage4},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 1000,
	    time = 60,
	    order = "e-z-e"
    })

    local cannonTurretDamage6 = makeTechnology({
	    name = "cannon-turret-damage-6",
	    prerequisites = {cannonTurretDamage5},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 3000,
	    time = 60,
	    order = "e-z-f"
    })

    makeTechnology({
	    name = "advanced-laser-turret-2",
	    icon = "__base__/graphics/technology/laser-turrets.png",
	    prerequisites = {"laser-turret-damage-2", "advanced-electronics-2", "military-4", "electric-engine"},
	    effects = {},
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
    
    makeTechnology({
	    name = "cannon-turret-damage-7",
	    prerequisites = {cannonTurretDamage6},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turret-damage.png",
	    upgrade = true,
	    maxLevel = "infinite",
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"space-science-pack", 1}
	    },
	    countForumla = "2^(L-7)*1000",
	    time = 60,
	    order = "e-z-f"
    })

    
    makeTechnology({
	    name = "artillery-shell-damage-1",
	    prerequisites = {"artillery"},
	    icon = "__RampantArsenal__/graphics/technology/artillery-shell-damage.png",
	    upgrade = true,
	    maxLevel = "infinite",
	    effects = {
		{
		    type = "ammo-damage",
		    ammo_category = "artillery-shell",
		    modifier = 0.4
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"space-science-pack", 1}
	    },
	    countForumla = "2^(L)*1000",
	    time = 60,
	    order = "e-z-f"
    })   

    makeTechnology({
    	    name = "artillery-turret-damage-1",
    	    prerequisites = {"artillery"},
    	    icon = "__RampantArsenal__/graphics/technology/artillery-damage.png",
    	    upgrade = true,
    	    maxLevel = "infinite",
    	    effects = {
    		{
    		    type = "turret-attack",
    		    turret_id = "artillery-wagon",
    		    modifier = 0.4
    		},
    		{
    		    type = "turret-attack",
    		    turret_id = "artillery-turret",
    		    modifier = 0.4
    		}
    	    },
    	    ingredients = {
    		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1},
    		{"high-tech-science-pack", 1},
    		{"space-science-pack", 1}
    	    },
    	    countForumla = "2^(L)*1000",
    	    time = 60,
    	    order = "e-z-f"
    })

    makeTechnology({
	    name = "lightning",
	    prerequisites = {"laser-turrets", "military-3"},
	    icon = "__RampantArsenal__/graphics/technology/lightning-turrets.png",
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 200,
	    time = 30
    })

    makeTechnology({
	    name = "incendiary-bullets",
	    icon="__RampantArsenal__/graphics/technology/incendiary-bullets.png",
	    prerequisites = {incendiary},
	    effects = {},
	    count = 75,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30	    
    })

    makeTechnology({
	    name = "incendiary-shotgun-shells",
	    icon="__RampantArsenal__/graphics/technology/incendiary-shotgun-shells.png",
	    prerequisites = {incendiary},
	    effects = {},
	    count = 75,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30	    
    })


    
    makeTechnology({
	    name = "incendiary-rockets",
	    icon="__RampantArsenal__/graphics/technology/incendiary-rockets.png",
	    prerequisites = {incendiary, "explosive-rocketry"},
	    effects = {},
	    count = 75,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30	    
    })
    
    makeTechnology({
	    name = "he-bullets",
	    icon="__RampantArsenal__/graphics/technology/he-bullets.png",
	    prerequisites = {he},
	    effects = {},
	    count = 75,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30	    
    })

    makeTechnology({
	    name = "he-shotgun-shells",
	    icon="__RampantArsenal__/graphics/technology/he-shotgun-shells.png",
	    prerequisites = {he},
	    effects = {},
	    count = 75,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30	    
    })


    makeTechnology({
	    name = "he-rockets",
	    icon="__RampantArsenal__/graphics/technology/he-rockets.png",
	    prerequisites = {he, "explosive-rocketry"},
	    effects = {},
	    count = 75,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30	    
    })

    makeTechnology({
	    name = "boosters",
	    icon="__RampantArsenal__/graphics/technology/boosters.png",
	    prerequisites = {"military-2"},
	    effects = {},
	    count = 35,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30	    
    })

    makeTechnology({
	    name = "paralysis",
	    icon="__RampantArsenal__/graphics/technology/paralysis.png",
	    prerequisites = {bioweapons, "military-4"},
	    effects = {},
	    count = 75,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30	    
    })

    makeTechnology({
	    name = "regeneration",
	    icon="__RampantArsenal__/graphics/technology/regeneration.png",
	    prerequisites = {"military-3"},
	    effects = {},
	    count = 75,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30	    
    })
    
    makeTechnology({
	    name = "bio-bullets",
	    icon="__RampantArsenal__/graphics/technology/bio-bullets.png",
	    prerequisites = {bioweapons},
	    effects = {},
	    count = 75,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30	    
    })

    makeTechnology({
	    name = "bio-shotgun-shells",
	    icon="__RampantArsenal__/graphics/technology/bio-shotgun-shells.png",
	    prerequisites = {bioweapons},
	    effects = {},
	    count = 75,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30	    
    })

    makeTechnology({
	    name = "bio-rockets",
	    icon="__RampantArsenal__/graphics/technology/bio-rockets.png",
	    prerequisites = {bioweapons, "explosive-rocketry"},
	    effects = {},	    
	    count = 75,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30	    
    })
    
    local rocketTurretTech = makeTechnology({
	    name = "rocket-turret-1",
	    prerequisites = {"turrets", "military-2", "rocketry"},
	    icon = "__RampantArsenal__/graphics/technology/rocket-turrets.png",
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"military-science-pack", 1}
	    },
	    count = 200,
	    time = 30
    })
    
    makeTechnology({
	    name = "rocket-turret-2",
	    prerequisites = {"rocket-speed-1", "explosive-rocketry", "advanced-electronics-2", "military-3", rocketTurretTech, "engine"},
	    icon = "__RampantArsenal__/graphics/technology/rocket-turrets.png",
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}		
	    },
	    count = 300,
	    time = 30
    })

    local rocketTurretDamage1 = makeTechnology({
	    name = "rocket-turret-damage-1",
	    prerequisites = {rocketTurretTech},
	    icon = "__RampantArsenal__/graphics/technology/rocket-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30,
	    order = "e-z-a"
    })

    local rocketTurretDamage2 = makeTechnology({
	    name = "rocket-turret-damage-2",
	    prerequisites = {rocketTurretDamage1},
	    icon = "__RampantArsenal__/graphics/technology/rocket-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 150,
	    time = 45,
	    order = "e-z-b"
    })

    local rocketTurretDamage3 = makeTechnology({
	    name = "rocket-turret-damage-3",
	    prerequisites = {rocketTurretDamage2},
	    icon = "__RampantArsenal__/graphics/technology/rocket-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 300,
	    time = 50,
	    order = "e-z-c"
    })

    local rocketTurretDamage4 = makeTechnology({
	    name = "rocket-turret-damage-4",
	    prerequisites = {rocketTurretDamage3},
	    icon = "__RampantArsenal__/graphics/technology/rocket-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 300,
	    time = 60,
	    order = "e-z-d"
    })


    local rocketTurretDamage5 = makeTechnology({
	    name = "rocket-turret-damage-5",
	    prerequisites = {rocketTurretDamage4},
	    icon = "__RampantArsenal__/graphics/technology/rocket-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 1000,
	    time = 60,
	    order = "e-z-e"
    })

    local rocketTurretDamage6 = makeTechnology({
	    name = "rocket-turret-damage-6",
	    prerequisites = {rocketTurretDamage5},
	    icon = "__RampantArsenal__/graphics/technology/rocket-turret-damage.png",
	    upgrade = true,
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 3000,
	    time = 60,
	    order = "e-z-f"
    })

    makeTechnology({
	    name = "rocket-turret-damage-7",
	    prerequisites = {rocketTurretDamage6},
	    icon = "__RampantArsenal__/graphics/technology/rocket-turret-damage.png",
	    upgrade = true,
	    maxLevel = "infinite",
	    effects = {},
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"space-science-pack", 1}
	    },
	    countForumla = "2^(L-7)*1000",
	    time = 60,
	    order = "e-z-f"
    })


    local landmineDamage1 = makeTechnology({
	    name = "landmine-damage-1",
	    prerequisites = {"land-mine"},
	    icon = "__RampantArsenal__/graphics/technology/landmine-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "ammo-damage",
		    ammo_category = "landmine",
		    modifier = 0.1
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"military-science-pack", 1}
	    },
	    count = 50,
	    time = 30,
	    order = "e-z-a"
    })

    local landmineDamage2 = makeTechnology({
	    name = "landmine-damage-2",
	    prerequisites = {landmineDamage1},
	    icon = "__RampantArsenal__/graphics/technology/landmine-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "ammo-damage",
		    ammo_category = "landmine",
		    modifier = 0.1
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 45,
	    order = "e-z-b"
    })

    local landmineDamage3 = makeTechnology({
	    name = "landmine-damage-3",
	    prerequisites = {landmineDamage2},
	    icon = "__RampantArsenal__/graphics/technology/landmine-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "ammo-damage",
		    ammo_category = "landmine",
		    modifier = 0.2
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"military-science-pack", 1}
	    },
	    count = 300,
	    time = 50,
	    order = "e-z-c"
    })

    local landmineDamage4 = makeTechnology({
	    name = "landmine-damage-4",
	    prerequisites = {landmineDamage3},
	    icon = "__RampantArsenal__/graphics/technology/landmine-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "ammo-damage",
		    ammo_category = "landmine",
		    modifier = 0.2
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"military-science-pack", 1}
	    },
	    count = 300,
	    time = 60,
	    order = "e-z-d"
    })


    local landmineDamage5 = makeTechnology({
	    name = "landmine-damage-5",
	    prerequisites = {landmineDamage4},
	    icon = "__RampantArsenal__/graphics/technology/landmine-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "ammo-damage",
		    ammo_category = "landmine",
		    modifier = 0.2
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 1000,
	    time = 60,
	    order = "e-z-e"
    })

    local landmineDamage6 = makeTechnology({
	    name = "landmine-damage-6",
	    prerequisites = {landmineDamage5},
	    icon = "__RampantArsenal__/graphics/technology/landmine-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "ammo-damage",
		    ammo_category = "landmine",
		    modifier = 0.4
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 3000,
	    time = 60,
	    order = "e-z-f"
    })

    makeTechnology({
	    name = "landmine-damage-7",
	    prerequisites = {landmineDamage6},
	    icon = "__RampantArsenal__/graphics/technology/landmine-damage.png",
	    upgrade = true,
	    maxLevel = "infinite",
	    effects = {
		{
		    type = "ammo-damage",
		    ammo_category = "landmine",
		    modifier = 0.4
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"space-science-pack", 1}
	    },
	    countForumla = "2^(L-7)*1000",
	    time = 60,
	    order = "e-z-f"
    })

    
    makeTechnology({
	    name = "turrets-2",
	    icon="__RampantArsenal__/graphics/technology/turrets-2.png",
	    prerequisites = {"turrets", "military-3", "gun-turret-damage-4", "bullet-speed-4"},
	    effects = {},
	    count = 75,
	    ingredients = {
		{"science-pack-1", 1},
    		{"science-pack-2", 1},
    		{"science-pack-3", 1},
    		{"military-science-pack", 1}
	    },
	    time = 30	    
    })

end

return technologies
