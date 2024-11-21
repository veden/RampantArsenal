-- Copyright (C) 2022  veden

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.


local lasers = {}

local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local projectileUtils = require("utils/ProjectileUtils")

local makeLaserProjectile = projectileUtils.makeLaserProjectile
local addEffectToTech = technologyUtils.addEffectToTech
local makeRecipe = recipeUtils.makeRecipe
local makeElectricTurret = turretUtils.makeElectricTurret

local function make_laser_beam()
    local result =
        {
            type = "beam",
            flags = {"not-on-map"},
            width = 0.5,
            damage_interval = 20,
            random_target_offset = true,
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
                                        damage = { amount = 10, type = "laser"}
                                    }
                                }
                        }
                },
            graphics_set = 
                {
                    beam = 
                        {
                        head =
                            {
                                filename = "__base__/graphics/entity/laser-turret/laser-body.png",
                                flags = {"mipmap"},
                                line_length = 8,
                                width = 64,
                                height = 12,
                                frame_count = 8,
                                scale = 1,
                                animation_speed = 0.5,
                                tint = {r=0.75,g=0.2,b=0.75,a=0.55},
                                blend_mode = laser_beam_blend_mode
                            },
                        tail =
                            {
                                filename = "__base__/graphics/entity/laser-turret/laser-end.png",
                                flags = { "no-crop", "mipmap" },
                                width = 110,
                                height = 62,
                                frame_count = 8,
                                shift = util.by_pixel(11.5, 1),
                                scale = 1,
                                animation_speed = 0.5,
                                tint = {r=0.75,g=0.2,b=0.75,a=0.55},
                                blend_mode = laser_beam_blend_mode
                            },
                        body =
                            {
                                {
                                    filename = "__base__/graphics/entity/laser-turret/laser-body.png",
                                    flags = {"mipmap"},
                                    line_length = 8,
                                    width = 64,
                                    height = 12,
                                    frame_count = 8,
                                    scale = 1,
                                    animation_speed = 0.5,
                                    tint = {r=0.75,g=0.2,b=0.75,a=0.55},
                                    blend_mode = laser_beam_blend_mode
                                }
                            },
                    },
            },

            light_animations =
                {
                    head =
                        {
                            filename = "__base__/graphics/entity/laser-turret/laser-body-light.png",
                            line_length = 8,
                            width = 64,
                            height = 12,
                            frame_count = 8,
                            scale = 0.5,
                            tint = {r=0.75,g=0.2,b=0.75,a=0.55},
                            animation_speed = 0.5,
                        },
                    tail =
                        {
                            filename = "__base__/graphics/entity/laser-turret/laser-end-light.png",
                            width = 110,
                            height = 62,
                            frame_count = 8,
                            shift = util.by_pixel(11.5, 1),
                            scale = 0.5,
                            tint = {r=0.75,g=0.2,b=0.75,a=0.55},
                            animation_speed = 0.5,
                        },
                    body =
                        {
                            {
                                filename = "__base__/graphics/entity/laser-turret/laser-body-light.png",
                                line_length = 8,
                                width = 64,
                                height = 12,
                                frame_count = 8,
                                scale = 0.5,
                                tint = {r=0.75,g=0.2,b=0.75,a=0.55},
                                animation_speed = 0.5,
                            }
                        }
                },

            ground_light_animations =
                {
                    head =
                        {
                            filename = "__base__/graphics/entity/laser-turret/laser-ground-light-head.png",
                            line_length = 1,
                            width = 256,
                            height = 256,
                            repeat_count = 8,
                            scale = 0.5,
                            shift = util.by_pixel(-32, 0),
                            animation_speed = 0.5,
                            tint = {r=0.75,g=0.2,b=0.75,a=0.55}
                        },
                    tail =
                        {
                            filename = "__base__/graphics/entity/laser-turret/laser-ground-light-tail.png",
                            line_length = 1,
                            width = 256,
                            height = 256,
                            repeat_count = 8,
                            scale = 0.5,
                            shift = util.by_pixel(32, 0),
                            animation_speed = 0.5,
                            tint = {r=0.75,g=0.2,b=0.75,a=0.55}
                        },
                    body =
                        {
                            filename = "__base__/graphics/entity/laser-turret/laser-ground-light-body.png",
                            line_length = 1,
                            width = 64,
                            height = 256,
                            repeat_count = 8,
                            scale = 0.5,
                            animation_speed = 0.5,
                            tint = {r=0.75,g=0.2,b=0.75,a=0.55}
                        }
                }
        }

    result.working_sound =
        {
            {
                filename = "__base__/sound/fight/electric-beam.ogg",
                volume = 0.7
            }
        }
    result.name = "laser-beam-rampant-arsenal"
    data:extend({
            result
    })

    return result.name
end

local function laser_turret_extension(inputs)
    return
        {
            filename = "__base__/graphics/entity/laser-turret/laser-turret-raising.png",
            priority = "medium",
            width = 130,
            height = 126,
            tint = {r=0.5,g=0.7,b=0.7,a=1},
            frame_count = inputs.frame_count and inputs.frame_count or 15,
            line_length = inputs.line_length and inputs.line_length or 0,
            run_mode = inputs.run_mode and inputs.run_mode or "forward",
            axially_symmetrical = false,
            direction_count = 4,
            shift = util.by_pixel(0, -37.5),
            scale = 1        
         }
end

local function laser_turret_extension_shadow(inputs)
    return
        {
            filename = "__base__/graphics/entity/laser-turret/laser-turret-raising-shadow.png",
            width = 182,
            height = 96,
            frame_count = inputs.frame_count and inputs.frame_count or 15,
            line_length = inputs.line_length and inputs.line_length or 0,
            run_mode = inputs.run_mode and inputs.run_mode or "forward",
            axially_symmetrical = false,
            direction_count = 4,
            draw_as_shadow = true,
            shift = util.by_pixel(47, 2.5),
            scale = 1
        }
end

local function laser_turret_extension_mask(inputs)
    return
        {
            filename = "__base__/graphics/entity/laser-turret/laser-turret-raising-mask.png",
            flags = { "mask" },
            width = 86,
            height = 80,
            frame_count = inputs.frame_count and inputs.frame_count or 15,
            line_length = inputs.line_length and inputs.line_length or 0,
            run_mode = inputs.run_mode and inputs.run_mode or "forward",
            axially_symmetrical = false,
            apply_runtime_tint = true,
            direction_count = 4,
            shift = util.by_pixel(0, -59),
            scale = 1
        }
end

local function laser_turret_shooting()
    return
        {
            filename = "__base__/graphics/entity/laser-turret/laser-turret-shooting.png",
            line_length = 8,
            width = 126,
            height = 120,
            tint = {r=0.5,g=0.7,b=0.7,a=1},
            frame_count = 1,
            direction_count = 64,
            shift = util.by_pixel(0, -35),
            scale = 1
        }
end

local function laser_turret_shooting_glow()
    return
        {
            filename = "__base__/graphics/entity/laser-turret/laser-turret-shooting-light.png",
            line_length = 8,
            width = 122,
            height = 116,
            frame_count = 1,
            direction_count = 64,
            shift = util.by_pixel(-0.5, -35),
            blend_mode = "additive",
            scale = 1
        }
end

local function laser_turret_shooting_mask()
    return
        {
            filename = "__base__/graphics/entity/laser-turret/laser-turret-shooting-mask.png",
            flags = { "mask" },
            line_length = 8,
            width = 92,
            height = 80,
            frame_count = 1,
            apply_runtime_tint = true,
            direction_count = 64,
            shift = util.by_pixel(0, -53.5),
            scale = 1
        }
end

local function laser_turret_shooting_shadow()
    return
        {
            filename = "__base__/graphics/entity/laser-turret/laser-turret-shooting-shadow.png",
            line_length = 8,
            width = 170,
            height = 92,
            frame_count = 1,
            direction_count = 64,
            draw_as_shadow = true,
            shift = util.by_pixel(50.5, 2.5),
            scale = 1
        }
end


local function advancedLaserSheet()
    return
        {
            layers =
                {
                    {
                        filename = "__RampantArsenal__/graphics/yuokiTani/entities/advanced-laser-sheet.png",
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
                        filename = "__RampantArsenal__/graphics/yuokiTani/entities/advanced-laser-sheet-mask.png",
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
                        filename = "__RampantArsenal__/graphics/yuokiTani/entities/r1_sheet.png",
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
    make_laser_beam()

    local entity = {
        name = "advanced-laser",
        icon = "__RampantArsenal__/graphics/icons/advancedLaserTurret.png",
        miningTime = 1,
        health = 2000,
        collisionBox = {{-1.75, -1.75 }, {1.75, 1.75}},
        selectionBox = {{-2, -2 }, {2, 2}},
        hasBaseDirection = true,
        order = "b[turret]-b[zzlaser-turret]",
        energySource = {
            type = "electric",
            buffer_capacity = "600MJ",
            input_flow_limit = "1000MW",
            drain = "150kW",
            usage_priority = "primary-input"
        },
        foldedAnimation = advancedLaserSheet(),
        foldingAnimation = advancedLaserSheet(),
        preparedAnimation = advancedLaserSheet(),
        preparingAnimation = advancedLaserSheet(),
        rotationSpeed = 0.002,
        resistances = {
            {
                type = "fire",
                percent = 60
            },
            {
                type = "impact",
                percent = 30
            },
            {
                type = "explosion",
                percent = 10
            },
            {
                type = "physical",
                percent = 10
            },
            {
                type = "acid",
                percent = 30
            },
            {
                type = "electric",
                percent = 30
            },
            {
                type = "laser",
                percent = 30
            },
            {
                type = "poison",
                percent = 30
            }
        }
    }
    local _, advancedElectricTurretItem = makeElectricTurret(entity, {
                                                                 type = "projectile",
                                                                 ammo_category = "electric",
                                                                 cooldown = 300,
                                                                 projectile_center = {-0.09375, -0.2},
                                                                 turn_range = 0.35,
                                                                 projectile_creation_distance = 13,
                                                                 range = 42,
                                                                 min_range = 13,
                                                                 damage_modifier = 7,
                                                                 ammo_type =
                                                                     {
                                                                         type = "projectile",
                                                                         category = "laser",
                                                                         direction_deviation = 0.1,
                                                                         range_deviation = 0.1,
                                                                         clamp_position = true,
                                                                         target_type = "position",
                                                                         energy_consumption = "200MJ",
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
                                                                                                         piercingDamage = 2000,
                                                                                                         tint = {r=0.8, g=0.0, b=0.0,a=0.9},
                                                                                                         action = {
                                                                                                             {
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
                                                                                                             {
                                                                                                                 type = "direct",
                                                                                                                 action_delivery = {
                                                                                                                     type = "instant",
                                                                                                                     target_effects = {
                                                                                                                         {
                                                                                                                             type = "invoke-tile-trigger",
                                                                                                                             repeat_count = 1,
                                                                                                                         },
                                                                                                                         {
                                                                                                                             type = "destroy-decoratives",
                                                                                                                             from_render_layer = "decorative",
                                                                                                                             to_render_layer = "object",
                                                                                                                             include_soft_decoratives = true,
                                                                                                                             include_decals = false,
                                                                                                                             invoke_decorative_trigger = true,
                                                                                                                             decoratives_with_trigger_only = false,
                                                                                                                             radius = 3
                                                                                                                         }
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
                                                                                                                                 type = "invoke-tile-trigger",
                                                                                                                                 repeat_count = 1,
                                                                                                                             },
                                                                                                                             {
                                                                                                                                 type = "destroy-decoratives",
                                                                                                                                 from_render_layer = "decorative",
                                                                                                                                 to_render_layer = "object",
                                                                                                                                 include_soft_decoratives = true,
                                                                                                                                 include_decals = false,
                                                                                                                                 invoke_decorative_trigger = true,
                                                                                                                                 decoratives_with_trigger_only = false,
                                                                                                                                 radius = 3
                                                                                                                             },
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
        hasBaseDirection = true,
        energySource = {
            type = "electric",
            buffer_capacity = "45MJ",
            input_flow_limit = "150MW",
            drain = "125kW",
            usage_priority = "primary-input"
        },
        order = "b[turret]-b[zlaser-turret]",
        collisionBox = {{-0.75, -0.75}, {0.75, 0.75}},
        selectionBox = {{-0.5, -1}, {0.5, 1}},
        foldedAnimation = lightningTowerSheet(),
        foldingAnimation = lightningTowerSheet(),
        preparedAnimation = lightningTowerSheet(),
        preparingAnimation = lightningTowerSheet(),
        rotationSpeed = 0.010,
        resistances = {
            {
                type = "fire",
                percent = 60
            },
            {
                type = "impact",
                percent = 30
            },
            {
                type = "explosion",
                percent = 10
            },
            {
                type = "physical",
                percent = 10
            },
            {
                type = "acid",
                percent = 30
            },
            {
                type = "electric",
                percent = 30
            },
            {
                type = "laser",
                percent = 30
            },
            {
                type = "poison",
                percent = 30
            }
        }
    }

    local _, lightningTowerTurretItem = makeElectricTurret(entity1, {
                                                               type = "beam",
                                                               ammo_category = "electric",
                                                               cooldown = 20,
                                                               range = 21,
                                                               damage_modifier = 18,
                                                               turn_range = 0.45,
                                                               projectile_creation_distance = 2,
                                                               source_offset = {0, -3.423489 / 2},
                                                               ammo_type =
                                                                   {
                                                                       category = "laser",
                                                                       energy_consumption = "20MJ",
                                                                       action =
                                                                           {
                                                                               type = "line",
                                                                               range = 21,
                                                                               width =  5,
                                                                               force = "not-same",
                                                                               action_delivery =
                                                                                   {
                                                                                       type = "beam",
                                                                                       beam =  "electric-beam",
                                                                                       duration = 20
                                                                                   }
                                                                           }
                                                                   }
    })


    local entity2 = {
        name = "advanced-beam",
        icon = "__RampantArsenal__/graphics/icons/advanced-beam-turret.png",
        miningTime = 1,
        health = 1400,
        energySource = {
            type = "electric",
            buffer_capacity = "30MJ",
            input_flow_limit = "100MW",
            drain = "240kW",
            usage_priority = "primary-input"
        },
        order = "b[turret]-b[zzlaser-turret]",
        collisionBox = {{-1.4, -1.4}, {1.4, 1.4}},
        selectionBox = {{-2, -2}, {2, 2}},
        rotationSpeed = 0.01,
        preparingSpeed = 0.05,
        basePicture = {
            layers =
                {

                    filename = "__base__/graphics/entity/laser-turret/laser-turret-base.png",
                    priority = "high",
                    width = 138,
                    height = 104,
                    direction_count = 1,
                    tint = {r=0.5,g=0.7,b=0.7,a=1},
                    frame_count = 1,
                    shift = util.by_pixel(-0.5, 2),
                    scale = 1,
                    tint = {r=0.5,g=0.7,b=0.7,a=1},
                },
                {
                    filename = "__base__/graphics/entity/laser-turret/laser-turret-base-shadow.png",
                    flags = { "mask" },
                    line_length = 1,
                    width = 132,
                    height = 82,
                    draw_as_shadow = true,
                    direction_count = 1,
                    frame_count = 1,
                    shift = util.by_pixel(6, 3),
                    scale = 1
                }
        },
        foldedAnimation = {
            layers =
                {
                    laser_turret_extension{frame_count=1, line_length = 1},
                    laser_turret_extension_shadow{frame_count=1, line_length=1},
                    laser_turret_extension_mask{frame_count=1, line_length=1}
                }
        },
        foldingAnimation = {
            layers =
                {
                    laser_turret_extension{run_mode = "backward"},
                    laser_turret_extension_shadow{run_mode = "backward"},
                    laser_turret_extension_mask{run_mode = "backward"}
                }
        },
        preparedAnimation = {
            layers =
                {
                    laser_turret_shooting(),
                    laser_turret_shooting_shadow(),
                    laser_turret_shooting_mask()
                }
        },
        preparingAnimation = {
            layers =
                {
                    laser_turret_extension{},
                    laser_turret_extension_shadow{},
                    laser_turret_extension_mask{}
                }
        },
        rotationSpeed = 0.010,
        resistances = {
            {
                type = "fire",
                percent = 60
            },
            {
                type = "impact",
                percent = 30
            },
            {
                type = "explosion",
                percent = 10
            },
            {
                type = "physical",
                percent = 10
            },
            {
                type = "acid",
                percent = 30
            },
            {
                type = "electric",
                percent = 30
            },
            {
                type = "laser",
                percent = 30
            },
            {
                type = "poison",
                percent = 30
            }
        }
    }
    local _, advancedBeamTurret = makeElectricTurret(entity2, {
                                                         type = "beam",
                                                         ammo_category = "electric",
                                                         cooldown = 13,
                                                         range = 28,
                                                         damage_modifier = 14,
                                                         source_direction_count = 64,
                                                         source_offset = {0, -3.423489 / 1.8},
                                                         projectile_creation_distance = 2,
                                                         ammo_type =
                                                             {
                                                                 category = "laser",
                                                                 energy_consumption = "5MJ",
                                                                 action =
                                                                     {
                                                                         type = "direct",
                                                                         action_delivery =
                                                                             {
                                                                                 type = "beam",
                                                                                 beam = "laser-beam-rampant-arsenal",
                                                                                 max_length = 28,
                                                                                 duration = 20,
                                                                                 source_offset = {0, -1.3}
                                                                             }
                                                                     }
                                                             }
    })

    makeRecipe({
            name = advancedElectricTurretItem,
            icon = "__RampantArsenal__/graphics/icons/advancedLaserTurret.png",
            enabled = false,
            ingredients = {
                {type="item", name="steel-plate", amount=30},
                {type="item", name="electric-engine-unit", amount=20},
                {type="item", name="processing-unit", amount=30},
                {type="item", name="accumulator", amount=15}
            },
            results = {{type="item", name=advancedElectricTurretItem, amount=1}}
    })

    makeRecipe({
            name = advancedBeamTurret,
            icon = "__RampantArsenal__/graphics/icons/advanced-beam-turret.png",
            enabled = false,
            ingredients = {
                {type="item", name="steel-plate", amount=15},
                {type="item", name="engine-unit", amount=10},
                {type="item", name="advanced-circuit", amount=15},
                {type="item", name="laser-turret", amount=4}
            },
            results = {{type="item", name=advancedBeamTurret, amount=1}}
    })

    makeRecipe({
            name = lightningTowerTurretItem,
            icon = "__RampantArsenal__/graphics/icons/lightningTurret.png",
            enabled = false,
            ingredients = {
                {type="item", name="steel-plate", amount=15},
                {type="item", name="iron-gear-wheel", amount=10},
                {type="item", name="advanced-circuit", amount=10},
                {type="item", name="battery", amount=15}
            },
            results = {{type="item", name=lightningTowerTurretItem, amount=1}}
    })


    addEffectToTech("lightning",
                    {
                        type = "unlock-recipe",
                        recipe = lightningTowerTurretItem
    })

    addEffectToTech("advanced-laser-turret-3",
                    {
                        type = "unlock-recipe",
                        recipe = advancedElectricTurretItem
    })

    addEffectToTech("advanced-laser-turret-2",
                    {
                        type = "unlock-recipe",
                        recipe = advancedBeamTurret
    })

end

return lasers
