local Equipment = {}

local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local armorUtils = require("utils/ArmorUtils")
local gridUtils = require("utils/GridUtils")
local equipmentUtils = require("utils/EquipmentUtils")
local projectileUtils = require("utils/ProjectileUtils")

local makeCannonProjectile = projectileUtils.makeCannonProjectile
local makeShotgunProjectile = projectileUtils.makeShotgunProjectile
local makeBombWave = projectileUtils.makeBombWave
local makeGrid = gridUtils.makeGrid
local changeAmmoCategory = equipmentUtils.changeAmmoCategory
local makeShield = equipmentUtils.makeShield
local makeBattery = equipmentUtils.makeBattery
local makePassiveDefense = equipmentUtils.makePassiveDefense
local makeActiveDefense = equipmentUtils.makeActiveDefense
local makeGenerator = equipmentUtils.makeGenerator
local addEffectToTech = technologyUtils.addEffectToTech
local makeRecipe = recipeUtils.makeRecipe
local addResistance = armorUtils.addResistance
local makeArmor = armorUtils.makeArmor

function Equipment.enable()

    local powerArmor = makeArmor({
            name = "power-armor-mk3",
            inventoryBonus = 60,
            icon = "__RampantArsenal__/graphics/icons/power-armor-mk3.png",
            order = "e[power-armor-mk3]",
            equipmentGrid = makeGrid({
                    name = "power-armor-mk3",
                    width = 12,
                    height = 12,
                    categories = {"armor", "adv-generator"}
            }),
            resistances = {
                {
                    type = "physical",
                    decrease = 20,
                    percent = 70
                },
                {
                    type = "acid",
                    decrease = 24,
                    percent = 70
                },
                {
                    type = "impact",
                    percent = 60
                },
                {
                    type = "explosion",
                    decrease = 60,
                    percent = 70
                },
                {
                    type = "fire",
                    decrease = 0,
                    percent = 80
                },
                {
                    type = "electric",
                    decrease = 15,
                    percent = 70
                },
                {
                    type = "poison",
                    decrease = 10,
                    percent = 70
                },
                {
                    type = "laser",
                    decrease = 15,
                    percent = 50
                }
            }
    })

    addResistance("power-armor-mk2", {
                      type = "poison",
                      decrease = 5,
                      percent = 30
    })

    addResistance("power-armor-mk2", {
                      type = "laser",
                      decrease = 10,
                      percent = 30
    })

    addResistance("power-armor-mk2", {
                      type = "electric",
                      decrease = 10,
                      percent = 50
    })

    addResistance("power-armor-mk2", {
                      type = "impact",
                      percent = 30
    })

    addResistance("power-armor-mk2", {
                      type = "acid",
                      decrease = 15,
                      percent = 50
    })

    addResistance("power-armor", {
                      type = "laser",
                      decrease = 5,
                      percent = 20
    })

    addResistance("power-armor", {
                      type = "electric",
                      decrease = 5,
                      percent = 40
    })

    addResistance("power-armor", {
                      type = "poison",
                      decrease = 0,
                      percent = 30
    })

    addResistance("modular-armor", {
                      type = "poison",
                      decrease = 0,
                      percent = 20
    })

    addResistance("modular-armor", {
                      type = "impact",
                      decrease = 0,
                      percent = 20
    })

    addResistance("modular-armor", {
                      type = "electric",
                      decrease = 0,
                      percent = 30
    })

    addResistance("module-armor", {
                      type = "laser",
                      decrease = 5,
                      percent = 10
    })


    -- local beltImmunityRecipe = makeRecipe({
    -- 	    name = "belt-immunity",
    -- 	    icon = "__base__/graphics/equipment/belt-immunity-equipment.png",
    -- 	    enabled = false,
    -- 	    ingredients = {
    -- 		{"steel-plate", 5},
    -- 		{"electric-engine-unit", 5},
    -- 		{"advanced-circuit", 15},
    -- 		{"battery", 5}
    -- 	    },
    -- 	    result = "belt-immunity-equipment"
    -- })

    makeRecipe({
            name = powerArmor,
            icon = "__RampantArsenal__/graphics/icons/power-armor-mk3.png",
            enabled = false,
            ingredients = {
                {"steel-plate", 30},
                {"power-armor-mk2", 1},
                {"processing-unit", 30},
                {"nuclear-reactor", 1}
            },
            result = powerArmor
    })


    addEffectToTech("rampant-arsenal-technology-power-armor-mk3",
                    {
                        type = "unlock-recipe",
                        recipe = powerArmor
    })

    local shieldMk3 = makeShield({
            name = "mk3",
            icon = "__RampantArsenal__/graphics/icons/energy-shield-mk3-equipment.png",
            picture = "__RampantArsenal__/graphics/equipment/energy-shield-mk3-equipment.png",
            order = "b[shield]-b[energy-shield-equipment-mk3]",
            energyPerShield = "50kJ",
            energySource = {
                type = "electric",
                buffer_capacity = "700kJ",
                input_flow_limit = "1020kW",
                usage_priority = "primary-input"
            },
            shape = {
                width = 3,
                height = 3,
                type = "full"
            }
    })

    makeRecipe({
            name = shieldMk3,
            icon = "__RampantArsenal__/graphics/icons/energy-shield-mk3-equipment.png",
            enabled = false,
            ingredients = {
                {"energy-shield-mk2-equipment", 10},
                {"speed-module-3", 20}
            },
            result = shieldMk3
    })

    addEffectToTech("rampant-arsenal-technology-shield-equipment-2",
                    {
                        type = "unlock-recipe",
                        recipe = shieldMk3
    })

    local batteryMk3 = makeBattery({
            name = "mk3",
            icon = "__RampantArsenal__/graphics/icons/battery-mk3-equipment.png",
            picture = "__RampantArsenal__/graphics/equipment/battery-mk3-equipment.png",
            order = "c[battery]-b[battery-equipment-mk3]",
            energySource = {
                type = "electric",
                buffer_capacity = "750MJ",
                input_flow_limit = "1.25GW",
                output_flow_limit = "1.25GW",
                usage_priority = "tertiary"
            },
            shape = {
                width = 3,
                height = 2,
                type = "full"
            }
    })

    makeRecipe({
            name = batteryMk3,
            icon = "__RampantArsenal__/graphics/icons/battery-mk3-equipment.png",
            enabled = false,
            ingredients = {
                {"battery-mk2-equipment", 10},
                {"effectivity-module-3", 20}
            },
            result = batteryMk3
    })

    addEffectToTech("rampant-arsenal-technology-battery-equipment-3",
                    {
                        type = "unlock-recipe",
                        recipe = batteryMk3
    })


    local generatorMk3 = makeGenerator({
            name = "mk3",
            icon = "__RampantArsenal__/graphics/icons/generator-mk3-equipment.png",
            picture = "__RampantArsenal__/graphics/equipment/generator-mk3-equipment.png",
            order = "a[energy-source]-b[zfusion-reactor]",
            power = "1300kW",
            shape = {
                width = 5,
                height = 5,
                type = "full"
            }
    })

    local generatorNuclear = makeGenerator({
            name = "nuclear",
            icon = "__RampantArsenal__/graphics/icons/generator-nuclear-equipment.png",
            picture = "__RampantArsenal__/graphics/equipment/generator-nuclear-equipment.png",
            order = "a[energy-source]-b[zzfusion-reactor]",
            power = "13000kW",
            burner = (settings.startup["rampant-arsenal-enableNuclearGeneratorEquipmentConsuming"].value and {
                          type = "burner",
                          fuel_category = "nuclear",
                          effectivity = 1,
                          fuel_inventory_size = 2,
                          burnt_inventory_size = 2,
                          emissions_per_minute = 2,
                          smoke =
                              {
                                  {
                                      name = "smoke",
                                      north_position = util.by_pixel(-38, -47.5),
                                      south_position = util.by_pixel(38.5, -32),
                                      east_position = util.by_pixel(20, -70),
                                      west_position = util.by_pixel(-19, -8.5),
                                      frequency = 15,
                                      starting_vertical_speed = 0.0,
                                      starting_frame_deviation = 60
                                  }
                              }
                     }) or nil,
            shape = {
                width = 6,
                height = 6,
                type = "full"
            },
            categories = {"adv-generator"}
    })

    makeRecipe({
            name = generatorMk3,
            icon = "__RampantArsenal__/graphics/icons/generator-mk3-equipment.png",
            enabled = false,
            ingredients = {
                {"fusion-reactor-equipment", 5},
                {"productivity-module-3", 20}
            },
            result = generatorMk3
    })

    makeRecipe({
            name = generatorNuclear,
            icon = "__RampantArsenal__/graphics/icons/generator-nuclear-equipment.png",
            enabled = false,
            ingredients = {
                {"heat-exchanger", 5},
                {generatorMk3, 1},
                {"accumulator", 10}
            },
            result = generatorNuclear
    })

    addEffectToTech("rampant-arsenal-technology-generator-equipment-2",
                    {
                        type = "unlock-recipe",
                        recipe = generatorMk3
    })

    addEffectToTech("rampant-arsenal-technology-generator-equipment-3",
                    {
                        type = "unlock-recipe",
                        recipe = generatorNuclear
    })

    changeAmmoCategory("active-defense-equipment",
                       "personal-laser-defense-equipment",
                       "laser-turret")

    changeAmmoCategory("active-defense-equipment",
                       "discharge-defense-equipment",
                       "laser-turret")

    local passiveShotgun = makePassiveDefense(
        {
            name = "shotgun",
            icon = "__RampantArsenal__/graphics/icons/personal-shotgun-defense-equipment.png",
            picture = "__RampantArsenal__/graphics/equipment/personal-shotgun-defense-equipment.png",
            order = "d[active-defense]-a[personal-laser-defense-equipmentz]",
            shape = {
                width = 3,
                height = 3,
                type = "full"
            },
            energySource = {
                type = "electric",
                usage_priority = "secondary-input",
                buffer_capacity = "2MJ"
            }
        },
        {
            type = "projectile",
            ammo_category = "shotgun-shell",
            cooldown = 45,
            damage_modifier = 1,
            turn_range = 0.4,
            ammo_type = {
                category = "shotgun-shell",
                target_type = "direction",
                clamp_position = true,
                energy_consumption = "1MJ",
                action =
                    {
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "instant",
                                    source_effects =
                                        {
                                            {
                                                type = "create-explosion",
                                                entity_name = "explosion-gunshot"
                                            }
                                        }
                                }
                        },
                        {
                            type = "direct",
                            repeat_count = 16,
                            action_delivery =
                                {
                                    type = "projectile",
                                    projectile = makeShotgunProjectile({
                                            name = "electric-shotgun",
                                            tint = {r=0,g=0,b=0.4,a=0.7},
                                            directionOnly = true,
                                            action = {
                                                type = "direct",
                                                action_delivery =
                                                    {
                                                        type = "instant",
                                                        target_effects ={
                                                            {
                                                                type = "damage",
                                                                damage = {amount = 2, type = "physical"}
                                                            },
                                                            {
                                                                type = "damage",
                                                                damage = {amount = 14, type = "electric"}
                                                            }
                                                        }
                                                    }
                                            }
                                    }),
                                    starting_speed = 1,
                                    direction_deviation = 0.3,
                                    range_deviation = 0.3,
                                    max_range = 18
                                }
                        }
                    }
            },
            projectile_creation_distance = 1.39375,
            projectile_center = {0, -0.0875},
            range = 18,
            sound = make_heavy_gunshot_sounds(),
    })

    local passiveCannon = makePassiveDefense(
        {
            name = "cannon",
            icon = "__RampantArsenal__/graphics/icons/personal-cannon-defense-equipment.png",
            picture = "__RampantArsenal__/graphics/equipment/personal-cannon-defense-equipment.png",
            order = "d[active-defense]-a[personal-laser-defense-equipmentzz]",
            shape = {
                width = 4,
                height = 4,
                type = "full"
            },
            energySource = {
                type = "electric",
                usage_priority = "secondary-input",
                buffer_capacity = "3MJ"
            }
        },
        {
            type = "projectile",
            ammo_category = "cannon-shell",
            cooldown = 150,
            projectile_creation_distance = 1,
            damage_modifier = 1,
            min_range = 7,
            ammo_type = {
                category = "cannon-shell",
                target_type = "direction",
                energy_consumption = "3MJ",
                clamp_position = true,
                action =
                    {
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "instant",
                                    source_effects =
                                        {
                                            {
                                                type = "create-explosion",
                                                entity_name = "explosion-gunshot"
                                            }
                                        }
                                }
                        },
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "projectile",
                                    max_range = 30,
                                    direction_deviation = 0.1,
                                    range_deviation = 1,

                                    starting_speed = 1,
                                    projectile = makeCannonProjectile({
                                            name = "personal-cannon",
                                            piercingDamage = 100,
                                            animation = {
                                                filename = "__base__/graphics/entity/bullet/bullet.png",
                                                frame_count = 1,
                                                width = 3,
                                                height = 50,
                                                priority = "high"
                                            },
                                            action =
                                                {
                                                    type = "direct",
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects =
                                                                {
                                                                    {
                                                                        type = "damage",
                                                                        damage = {amount = 50 , type = "electric"}
                                                                    },
                                                                    {
                                                                        type = "damage",
                                                                        damage = {amount = 50 , type = "physical"}
                                                                    },
                                                                    {
                                                                        type = "create-entity",
                                                                        entity_name = "big-explosion"
                                                                    }
                                                                }
                                                        }
                                                },
                                            finalAction =
                                                {
                                                    type = "direct",
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects =
                                                                {
                                                                    {
                                                                        type = "create-entity",
                                                                        entity_name = "big-explosion"
                                                                    },
                                                                    {
                                                                        type = "nested-result",
                                                                        action =
                                                                            {
                                                                                type = "area",
                                                                                radius = 2,
                                                                                force = "not-same",
                                                                                action_delivery =
                                                                                    {
                                                                                        type = "instant",
                                                                                        target_effects =
                                                                                            {
                                                                                                {
                                                                                                    type = "damage",
                                                                                                    damage = {amount = 300, type = "explosion"}
                                                                                                }
                                                                                            }
                                                                                    }
                                                                            }
                                                                    },
                                                                    {
                                                                        type = "create-entity",
                                                                        entity_name = "small-scorchmark",
                                                                        check_buildability = true
                                                                    }
                                                                }
                                                        }
                                                }
                                    })
                                }
                        }
                    }
            },
            projectile_center = {0, -0.0875},
            range = 30,
            sound = make_heavy_gunshot_sounds(),
    })

    local passiveLightning = makePassiveDefense(
        {
            name = "lightning",
            icon = "__RampantArsenal__/graphics/icons/personal-lightning-defense-equipment.png",
            picture = "__RampantArsenal__/graphics/equipment/personal-lightning-defense-equipment.png",
            order = "d[active-defense]-a[personal-laser-defense-equipmentzzz]",
            shape = {
                width = 3,
                height = 4,
                type = "full"
            },
            energySource = {
                type = "electric",
                usage_priority = "secondary-input",
                buffer_capacity = "3MJ"
            }
        },
        {
            type = "beam",
            ammo_category = "electric",
            cooldown = 20,
            range = 20,
            damage_modifier = 6,
            projectile_creation_distance = 1,
            ammo_type =
                {
                    category = "laser-turret",
                    energy_consumption = "1MJ",
                    action =
                        {
                            type = "line",
                            range = 20,
                            width =  5,
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

    local passiveBullets = makePassiveDefense(
        {
            name = "bullets",
            icon = "__RampantArsenal__/graphics/icons/personal-bullet-defense-equipment.png",
            picture = "__RampantArsenal__/graphics/equipment/personal-bullet-defense-equipment.png",
            order = "d[active-defense]-a[personal-laser-defense-equipmentzzzz]",
            shape = {
                width = 3,
                height = 3,
                type = "full"
            },
            energySource = {
                type = "electric",
                usage_priority = "secondary-input",
                buffer_capacity = "2.2MJ"
            }
        },
        {
            type = "projectile",
            ammo_category = "bullet",
            cooldown = 5,
            projectile_creation_distance = 2,
            damage_modifier = 1,
            projectile_center = {0, 0},
            range = 20,
            ammo_type = {
                category = "bullet",
                energy_consumption = "200kJ",
                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                source_effects =
                                    {
                                        type = "create-explosion",
                                        entity_name = "explosion-gunshot"
                                    },
                                target_effects =
                                    {
                                        {
                                            type = "damage",
                                            damage = { amount = 4, type = "physical"}
                                        },
                                        {
                                            type = "damage",
                                            damage = { amount = 12, type = "electric"}
                                        }
                                    }
                            }
                    }
            },
            sound = make_heavy_gunshot_sounds(),
    })

    local passiveSlow = makePassiveDefense(
        {
            name = "slow",
            icon = "__RampantArsenal__/graphics/icons/personal-slow-defense-equipment.png",
            picture = "__RampantArsenal__/graphics/equipment/personal-slow-defense-equipment.png",
            order = "d[active-defense]-a[personal-laser-defense-equipmentzzzzz]",
            shape = {
                width = 3,
                height = 3,
                type = "full"
            },
            energySource = {
                type = "electric",
                usage_priority = "secondary-input",
                buffer_capacity = "1.1MJ"
            }
        },
        {
            type = "projectile",
            ammo_category = "bullet",
            cooldown = 10,
            projectile_creation_distance = 2,
            damage_modifier = 1,
            projectile_center = {0, 0},
            range = 20,
            ammo_type = {
                category = "bullet",
                energy_consumption = "400kJ",
                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                source_effects =
                                    {
                                        type = "create-explosion",
                                        entity_name = "explosion-gunshot"
                                    },
                                target_effects =
                                    {
                                        {
                                            type = "damage",
                                            damage = { amount = 4, type = "physical"}
                                        },
                                        {
                                            type = "create-sticker",
                                            sticker = "bullet-slow-sticker-rampant-arsenal"
                                        }
                                    }
                            }
                    }
            },
            sound = make_heavy_gunshot_sounds(),
    })

    makeRecipe(
        {
            name = passiveShotgun,
            icon = "__RampantArsenal__/graphics/icons/personal-shotgun-defense-equipment.png",
            enabled = false,
            ingredients = {
                {"shotgun-item-rampant-arsenal", 5},
                {"steel-plate", 5},
                {"effectivity-module-2", 10}
            },
            result = passiveShotgun
    })

    makeRecipe({
            name = passiveCannon,
            icon = "__RampantArsenal__/graphics/icons/personal-cannon-defense-equipment.png",
            enabled = false,
            ingredients = {
                {"cannon-item-rampant-arsenal", 5},
                {"steel-plate", 5},
                {"productivity-module-2", 10}
            },
            result = passiveCannon
    })

    makeRecipe({
            name = passiveLightning,
            icon = "__RampantArsenal__/graphics/icons/personal-lightning-defense-equipment.png",
            enabled = false,
            ingredients = {
                {"lightning-item-rampant-arsenal", 5},
                {"steel-plate", 5},
                {"speed-module-2", 10}
            },
            result = passiveLightning
    })

    makeRecipe({
            name = passiveBullets,
            icon = "__RampantArsenal__/graphics/icons/personal-bullet-defense-equipment.png",
            enabled = false,
            ingredients = {
                {"gun-item-rampant-arsenal", 5},
                {"steel-plate", 5},
                {"processing-unit", 40}
            },
            result = passiveBullets
    })

    makeRecipe({
            name = passiveSlow,
            icon = "__RampantArsenal__/graphics/icons/personal-slow-defense-equipment.png",
            enabled = false,
            ingredients = {
                {"capsule-item-rampant-arsenal", 5},
                {"steel-plate", 5},
                {"processing-unit", 40}
            },
            result = passiveSlow
    })


    addEffectToTech("rampant-arsenal-technology-personal-shotgun-defense",
                    {
                        type = "unlock-recipe",
                        recipe = passiveShotgun
    })

    addEffectToTech("rampant-arsenal-technology-personal-cannon-defense",
                    {
                        type = "unlock-recipe",
                        recipe = passiveCannon
    })

    addEffectToTech("rampant-arsenal-technology-personal-lightning-defense",
                    {
                        type = "unlock-recipe",
                        recipe = passiveLightning
    })

    addEffectToTech("rampant-arsenal-technology-personal-slow-defense",
                    {
                        type = "unlock-recipe",
                        recipe = passiveSlow
    })

    addEffectToTech("rampant-arsenal-technology-personal-bullets-defense",
                    {
                        type = "unlock-recipe",
                        recipe = passiveBullets
    })

    data.raw["solar-panel-equipment"]["solar-panel-equipment"].power = "30kW"
end

return Equipment
