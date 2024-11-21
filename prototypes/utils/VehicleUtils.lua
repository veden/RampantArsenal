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


local vehicleUtils = {}

local hit_effects = require ("__base__.prototypes.entity.hit-effects")

local tank_shift_y = 6

function vehicleUtils.addEquipmentGrid(eType, eName, equipmentGrid)
    if data.raw[eType] and data.raw[eType][eName] then
        data.raw[eType][eName].equipment_grid = equipmentGrid
    end
end

function vehicleUtils.addAutomaticRobotDeploy(eType, eName)
    if data.raw[eType] and data.raw[eType][eName] then
        data.raw[eType][eName].allow_robot_dispatch_in_automatic_mode = true
    end
end

function vehicleUtils.makeTank(attributes)
    local name = attributes.name .. "-tank-vehicle-rampant-arsenal"

    data:extend({
            {
                type = "item-with-entity-data",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/tank.png",
                icon_size = 32,-- icon_mipmaps = 4,
                flags = {},
                subgroup = "transport",
                order = attributes.order or "b[personal-transport]-b[tank]",
                place_result = name,
                stack_size = 1
            },
            {
                type = "car",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/tank.png",
                icon_size = 32,-- icon_mipmaps = 4,
                flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
                minable = {mining_time = 1, result = name},
                mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg"},
                max_health = attributes.health or 2000,
                equipment_grid = attributes.equipmentGrid,
                healing_per_tick = attributes.healing,
                corpse = attributes.corpse or "medium-remnants",
                dying_explosion = attributes.dyingExplosion or "medium-explosion",
                alert_icon_shift = util.by_pixel(-4, -13),
                immune_to_tree_impacts = attributes.immuneToTrees,
                immune_to_rock_impacts = attributes.immuneToTrees,
                energy_per_hit_point = attributes.energyPerHit or 0.5,
                resistances = attributes.resistances or
                    {
                        {
                            type = "fire",
                            decrease = 15,
                            percent = 60
                        },
                        {
                            type = "physical",
                            decrease = 15,
                            percent = 60
                        },
                        {
                            type = "impact",
                            decrease = 50,
                            percent = 80
                        },
                        {
                            type = "explosion",
                            decrease = 15,
                            percent = 70
                        },
                        {
                            type = "acid",
                            decrease = 15,
                            percent = 50
                        }
                    },
                collision_box = attributes.collisionBox or {{-1.8, -2.6}, {1.8, 2.6}},
                selection_box = attributes.selectionBox or {{-1.8, -1.3}, {1.8, 2.6}},
                damaged_trigger_effect = hit_effects.entity(),
                drawing_box_vertical_extension = attributes.drawingBoxVerticalExtension or 0.5,
                effectivity = attributes.effectivity or 0.5,
                braking_power = attributes.brakingPower or "600kW",
                energy_source = attributes.energySource or
                    {
                        type = "burner",
                        fuel_category = "chemical",
                        effectivity = 0.55,
                        fuel_inventory_size = attributes.fuelInventorySize or 3,
                        burnt_inventory_size = attributes.burntInventorySize,
                        smoke =
                            {
                                {
                                    name = "tank-smoke",
                                    deviation = {0.25, 0.25},
                                    frequency = 50,
                                    position = {0, 1.5},
                                    starting_frame = 0,
                                    starting_frame_deviation = 60
                                }
                            }
                    },
                consumption = attributes.consumption or "600kW",
                terrain_friction_modifier = attributes.frictionModifier or 0.2,
                friction = attributes.friction or 0.002,
                light =
                    {
                        {
                            type = "oriented",
                            minimum_darkness = 0.3,
                            picture =
                                {
                                    filename = "__core__/graphics/light-cone.png",
                                    priority = "extra-high",
                                    flags = { "light" },
                                    scale = 2,
                                    width = 200,
                                    height = 200
                                },
                            shift = {-0.6, -14 + tank_shift_y / 32},
                            size = 2,
                            intensity = 0.6,
                            color = {r = 0.9, g = 1.0, b = 1.0}
                        },
                        {
                            type = "oriented",
                            minimum_darkness = 0.3,
                            picture =
                                {
                                    filename = "__core__/graphics/light-cone.png",
                                    priority = "extra-high",
                                    flags = { "light" },
                                    scale = 2,
                                    width = 200,
                                    height = 200
                                },
                            shift = {0.6, -14 + tank_shift_y / 32},
                            size = 2,
                            intensity = 0.6,
                            color = {r = 0.9, g = 1.0, b = 1.0}
                        }
                    },
                animation =
                    {
                        layers =
                            {
                                {
                                    priority = "low",
                                    width = 270,
                                    height = 212,
                                    frame_count = 2,
                                    direction_count = 64,
                                    shift = util.by_pixel(0, -16 + tank_shift_y),
                                    animation_speed = 8,
                                    max_advance = 1,
                                    tint = attributes.tint,
                                    scale = attributes.scale,
                                    stripes =
                                        {
                                            {
                                                filename = "__base__/graphics/entity/tank/tank-base-1.png",
                                                width_in_frames = 2,
                                                height_in_frames = 16
                                            },
                                            {
                                                filename = "__base__/graphics/entity/tank/tank-base-2.png",
                                                width_in_frames = 2,
                                                height_in_frames = 16
                                            },
                                            {
                                                filename = "__base__/graphics/entity/tank/tank-base-3.png",
                                                width_in_frames = 2,
                                                height_in_frames = 16
                                            },
                                            {
                                                filename = "__base__/graphics/entity/tank/tank-base-4.png",
                                                width_in_frames = 2,
                                                height_in_frames = 16
                                            }
                                        }
                                },
                                {
                                    priority = "low",
                                    width = 208,
                                    height = 166,
                                    frame_count = 2,
                                    apply_runtime_tint = true,
                                    direction_count = 64,
                                    shift = util.by_pixel(0, -27.5 + tank_shift_y),
                                    max_advance = 1,
                                    line_length = 2,
                                    scale = attributes.scale,
                                    stripes = util.multiplystripes(2,
                                                                    {
                                                                        {
                                                                            filename = "__base__/graphics/entity/tank/tank-base-mask-1.png",
                                                                            width_in_frames = 1,
                                                                            height_in_frames = 22
                                                                        },
                                                                        {
                                                                            filename = "__base__/graphics/entity/tank/tank-base-mask-2.png",
                                                                            width_in_frames = 1,
                                                                            height_in_frames = 22
                                                                        },
                                                                        {
                                                                            filename = "__base__/graphics/entity/tank/tank-base-mask-3.png",
                                                                            width_in_frames = 1,
                                                                            height_in_frames = 20
                                                                        }
                                    })
                                },
                                {
                                    priority = "low",
                                    width = 302,
                                    height = 194,
                                    frame_count = 2,
                                    draw_as_shadow = true,
                                    direction_count = 64,
                                    shift = util.by_pixel(22.5, 1 + tank_shift_y),
                                    max_advance = 1,
                                    scale = attributes.scale,
                                    stripes = util.multiplystripes(2,
                                                                    {
                                                                        {
                                                                            filename = "__base__/graphics/entity/tank/tank-base-shadow-1.png",
                                                                            width_in_frames = 1,
                                                                            height_in_frames = 16
                                                                        },
                                                                        {
                                                                            filename = "__base__/graphics/entity/tank/tank-base-shadow-2.png",
                                                                            width_in_frames = 1,
                                                                            height_in_frames = 16
                                                                        },
                                                                        {
                                                                            filename = "__base__/graphics/entity/tank/tank-base-shadow-3.png",
                                                                            width_in_frames = 1,
                                                                            height_in_frames = 16
                                                                        },
                                                                        {
                                                                            filename = "__base__/graphics/entity/tank/tank-base-shadow-4.png",
                                                                            width_in_frames = 1,
                                                                            height_in_frames = 16
                                                                        }
                                    })
                                }
                            }
                    },
                turret_animation =
                    {
                        layers =
                            {
                                {
                                    filename = "__base__/graphics/entity/tank/tank-turret.png",
                                    priority = "low",
                                    line_length = 8,
                                    width = 179,
                                    height = 132,
                                    tint = attributes.tint,
                                    frame_count = 1,
                                    scale = attributes.scale * 1.2,
                                    direction_count = 64,
                                    shift = util.by_pixel(2.25-2, -40.5 + tank_shift_y + (-15 * attributes.scale)),
                                    animation_speed = 8
                                },
                                {
                                    filename = "__base__/graphics/entity/tank/tank-turret-mask.png",
                                    priority = "low",
                                    line_length = 8,
                                    width = 72,
                                    height = 66,
                                    frame_count = 1,
                                    scale = attributes.scale * 1.2,
                                    apply_runtime_tint = true,
                                    direction_count = 64,
                                    tint = attributes.tint,
                                    shift = util.by_pixel(2-2, -41.5 + tank_shift_y + (-15 * attributes.scale))
                                },
                                {
                                    filename = "__base__/graphics/entity/tank/tank-turret-shadow.png",
                                    priority = "low",
                                    line_length = 8,
                                    width = 193,
                                    height = 134,
                                    frame_count = 1,
                                    scale = attributes.scale * 1.2,
                                    draw_as_shadow = true,
                                    direction_count = 64,
                                    shift = util.by_pixel(58.25-2, 0.5 + tank_shift_y)
                                }
                            }
                    },
                turret_rotation_speed = 0.35 / 60,
                turret_return_timeout = 300,
                stop_trigger_speed = 0.1,
                sound_no_fuel =
                    {
                        {
                            filename = "__base__/sound/fight/tank-no-fuel-1.ogg",
                            volume = 0.6
                        }
                    },
                stop_trigger =
                    {
                        {
                            type = "play-sound",
                            sound =
                                {
                                    {
                                        filename = "__base__/sound/car-breaks.ogg",
                                        volume = 0.6
                                    }
                                }
                        }
                    },
                sound_minimum_speed = 0.2,
                sound_scaling_ratio = 0.8,
                vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
                working_sound =
                    {
                        sound =
                            {
                                filename = "__base__/sound/fight/tank-engine.ogg",
                                volume = 0.4
                            },
                        activate_sound =
                            {
                                filename = "__base__/sound/fight/tank-engine-start.ogg",
                                volume = 0.4
                            },
                        deactivate_sound =
                            {
                                filename = "__base__/sound/fight/tank-engine-stop.ogg",
                                volume = 0.4
                            },
                        match_speed_to_activity = true
                    },
                open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.5 },
                close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.3 },
                rotation_speed = attributes.rotationSpeed or 0.0035,
                tank_driving = true,
                weight = 60000,
                inventory_size = 120,
                guns = attributes.weapons or { "tank-cannon", "tank-machine-gun", "tank-flamethrower" },
                water_reflection = car_reflection(1.2)
            }
    })

    return name
end

function vehicleUtils.makeCar(attributes)
    local name = attributes.name .. "-car-vehicle-rampant-arsenal"

    data:extend({
            {
                type = "item-with-entity-data",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/car.png",
                icon_size = 32,-- icon_mipmaps = 4,
                flags = {},
                subgroup = "transport",
                order = attributes.order or "b[personal-transport]-a[car]",
                place_result = name,
                stack_size = 1
            },
            {
                type = "car",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/car.png",
                icon_size = 32,-- icon_mipmaps = 4,
                flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
                minable = {mining_time = 1, result = name },
                mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg"},
                max_health = attributes.health or 450,
                corpse = attributes.corpse or "medium-remnants",
                dying_explosion = attributes.dyingExplosion or "medium-explosion",
                equipment_grid = attributes.equipmentGrid,
                alert_icon_shift = util.by_pixel(0, -13),
                immune_to_tree_impacts = attributes.immuneToTrees,
                immune_to_rock_impacts = attributes.immuneToTrees,
                energy_per_hit_point = attributes.energyPerHit or 1,
                damaged_trigger_effect = hit_effects.entity(),
                crash_trigger = crash_trigger(),
                resistances = attributes.resistances or
                    {
                        {
                            type = "fire",
                            percent = 50
                        },
                        {
                            type = "impact",
                            percent = 30,
                            decrease = 50
                        },
                        {
                            type = "acid",
                            percent = 20
                        }
                    },
                collision_box = attributes.collisionBox or {{-0.7, -1}, {0.7, 1}},
                selection_box = attributes.selectionBox or {{-0.7, -1}, {0.7, 1}},
                effectivity = attributes.effectivity or 0.5,
                braking_power = attributes.brakingPower or "200kW",

                energy_source = attributes.energySource or
                    {
                        type = "burner",
                        fuel_category = "chemical",
                        effectivity = 1,
                        fuel_inventory_size = 1,
                        smoke =
                            {
                                {
                                    name = "car-smoke",
                                    deviation = {0.25, 0.25},
                                    frequency = 200,
                                    position = {0, 1.5},
                                    starting_frame = 0,
                                    starting_frame_deviation = 60
                                }
                            }
                    },
                consumption = attributes.consumption or "150kW",
                friction = attributes.friction or 2e-3,
                light =
                    {
                        {
                            type = "oriented",
                            minimum_darkness = 0.3,
                            picture =
                                {
                                    filename = "__core__/graphics/light-cone.png",
                                    priority = "extra-high",
                                    flags = { "light" },
                                    scale = 2,
                                    width = 200,
                                    height = 200
                                },
                            shift = {-0.6, -14},
                            size = 2,
                            intensity = 0.6,
                            color = {r = 0.92, g = 0.77, b = 0.3}
                        },
                        {
                            type = "oriented",
                            minimum_darkness = 0.3,
                            picture =
                                {
                                    filename = "__core__/graphics/light-cone.png",
                                    priority = "extra-high",
                                    flags = { "light" },
                                    scale = 2,
                                    width = 200,
                                    height = 200
                                },
                            shift = {0.6, -14},
                            size = 2,
                            intensity = 0.6,
                            color = {r = 0.92, g = 0.77, b = 0.3}
                        }
                    },
                render_layer = "object",
                animation =
                    {
                        layers =
                            {
                                {
                                    priority = "low",
                                    width = 201,
                                    height = 172,
                                    frame_count = 2,
                                    scale = attributes.scale * 1,
                                    direction_count = 64,
                                    tint = attributes.tint,
                                    shift = util.by_pixel(0+2, -11.5+8.5),
                                    animation_speed = 8,
                                    max_advance = 0.2,
                                    stripes =
                                        {
                                            {
                                                filename = "__base__/graphics/entity/car/car-1.png",
                                                width_in_frames = 2,
                                                height_in_frames = 11
                                            },
                                            {
                                                filename = "__base__/graphics/entity/car/car-2.png",
                                                width_in_frames = 2,
                                                height_in_frames = 11
                                            },
                                            {
                                                filename = "__base__/graphics/entity/car/car-3.png",
                                                width_in_frames = 2,
                                                height_in_frames = 11
                                            },
                                            {
                                                filename = "__base__/graphics/entity/car/car-4.png",
                                                width_in_frames = 2,
                                                height_in_frames = 11
                                            },
                                            {
                                                filename = "__base__/graphics/entity/car/car-5.png",
                                                width_in_frames = 2,
                                                height_in_frames = 11
                                            },
                                            {
                                                filename = "__base__/graphics/entity/car/car-6.png",
                                                width_in_frames = 2,
                                                height_in_frames = 9
                                            }
                                        }
                                },
                                {
                                    priority = "low",
                                    width = 199,
                                    height = 147,
                                    frame_count = 2,
                                    apply_runtime_tint = true,
                                    scale = attributes.scale * 1,
                                    axially_symmetrical = false,
                                    direction_count = 64,
                                    max_advance = 0.2,
                                    shift = util.by_pixel(0+2, -11+8.5),
                                    line_length = 1,
                                    stripes = util.multiplystripes(2,
                                                                    {
                                                                        {
                                                                            filename = "__base__/graphics/entity/car/car-mask-1.png",
                                                                            width_in_frames = 1,
                                                                            height_in_frames = 13
                                                                        },
                                                                        {
                                                                            filename = "__base__/graphics/entity/car/car-mask-2.png",
                                                                            width_in_frames = 1,
                                                                            height_in_frames = 13
                                                                        },
                                                                        {
                                                                            filename = "__base__/graphics/entity/car/car-mask-3.png",
                                                                            width_in_frames = 1,
                                                                            height_in_frames = 13
                                                                        },
                                                                        {
                                                                            filename = "__base__/graphics/entity/car/car-mask-4.png",
                                                                            width_in_frames = 1,
                                                                            height_in_frames = 13
                                                                        },
                                                                        {
                                                                            filename = "__base__/graphics/entity/car/car-mask-5.png",
                                                                            width_in_frames = 1,
                                                                            height_in_frames = 12
                                                                        }
                                    })
                                },
                                {
                                    priority = "low",
                                    width = 114,
                                    height = 76,
                                    frame_count = 2,
                                    draw_as_shadow = true,
                                    direction_count = 64,
                                    shift = {0.28125, 0.25},
                                    max_advance = 0.2,
                                    scale = attributes.scale * 2,
                                    stripes = util.multiplystripes(2,
                                                                   {
                                                                       {
                                                                           filename = "__base__/graphics/entity/car/car-shadow-1.png",
                                                                           width_in_frames = 1,
                                                                           height_in_frames = 22
                                                                       },
                                                                       {
                                                                           filename = "__base__/graphics/entity/car/car-shadow-2.png",
                                                                           width_in_frames = 1,
                                                                           height_in_frames = 22
                                                                       },
                                                                       {
                                                                           filename = "__base__/graphics/entity/car/car-shadow-3.png",
                                                                           width_in_frames = 1,
                                                                           height_in_frames = 20
                                                                       }
                                    })
                                }
                            }
                    },
                turret_animation =
                    {
                        layers =
                            {
                                {
                                    priority = "low",
                                    width = 71,
                                    height = 57,
                                    frame_count = 1,
                                    axially_symmetrical = false,
                                    direction_count = 64,
                                    tint = attributes.tint,
                                    shift = util.by_pixel(0+2, -33.5+8.5),
                                    animation_speed = 8,
                                    scale = attributes.scale * 1,
                                    stripes =
                                        {
                                            {
                                                filename = "__base__/graphics/entity/car/car-turret-1.png",
                                                width_in_frames = 1,
                                                height_in_frames = 32
                                            },
                                            {
                                                filename = "__base__/graphics/entity/car/car-turret-2.png",
                                                width_in_frames = 1,
                                                height_in_frames = 32
                                            }
                                        }
                                },
                                {
                                    filename = "__base__/graphics/entity/car/car-turret-shadow.png",
                                    priority = "low",
                                    line_length = 8,
                                    width = 46,
                                    height = 31,
                                    frame_count = 1,
                                    scale = attributes.scale * 2,
                                    draw_as_shadow = true,
                                    direction_count = 64,
                                    shift = {0.875, 0.359375}
                                }
                            }
                    },
                turret_rotation_speed = 0.35 / 60,
                sound_no_fuel =
                    {
                        {
                            filename = "__base__/sound/fight/car-no-fuel-1.ogg",
                            volume = 0.6
                        }
                    },
                stop_trigger_speed = 0.2,
                stop_trigger =
                    {
                        {
                            type = "play-sound",
                            sound =
                                {
                                    {
                                        filename = "__base__/sound/car-breaks.ogg",
                                        volume = 0.2
                                    }
                                }
                        }
                    },
                sound_minimum_speed = 0.2;
                sound_scaling_ratio = 0.8,
                vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
                working_sound =
                    {
                        sound =
                            {
                                filename = "__base__/sound/car-engine.ogg",
                                volume = 0.7
                            },
                        activate_sound =
                            {
                                filename = "__base__/sound/car-engine-start.ogg",
                                volume = 0.7
                            },
                        deactivate_sound =
                            {
                                filename = "__base__/sound/car-engine-stop.ogg",
                                volume = 0.7
                            },
                        match_speed_to_activity = true
                    },
                open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.5 },
                close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.4 },
                rotation_speed = 0.015,
                weight = attributes.weight or 700,
                guns = attributes.weapons or { "vehicle-machine-gun" },
                inventory_size = attributes.inventorySize or 80,
                water_reflection = car_reflection(1)
            }
    })

    return name
end

function vehicleUtils.makeTrain(attributes)
    local name = attributes.name .. "-train-vehicle-rampant-arsenal"

    data:extend(
        {
            {
                type = "item-with-entity-data",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/diesel-locomotive.png",
                icon_size = 32,-- icon_mipmaps = 4,
                flags = {},
                subgroup = "transport",
                order = attributes.order or "a[train-system]-f[diesel-locomotive]",
                place_result = name,
                stack_size = 5
            },
            {
                type = "locomotive",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/diesel-locomotive.png",
                icon_size = 32,-- icon_mipmaps = 4,
                flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
                minable = {mining_time = 1, result = name},
                mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg"},
                max_health = attributes.health or 1000,
                equipment_grid = attributes.equipmentGrid,
                corpse = "medium-remnants",
                damaged_trigger_effect = hit_effects.entity(),
                dying_explosion = "medium-explosion",
                collision_box = attributes.collisionBox or {{-0.6, -2.6}, {0.6, 2.6}},
                selection_box = attributes.selectionBox or {{-1, -3}, {1, 3}},
                drawing_box = attributes.drawingBox or {{-1, -4}, {1, 3}},
                alert_icon_shift = util.by_pixel(0, -24),
                weight = attributes.weight or 2000,
                max_speed = attributes.maxSpeed or 1.2,
                max_power = attributes.maxPower or "600kW",
                reversing_power_modifier = attributes.maxReverse or 0.6,
                braking_force = attributes.brakingForce or 10,
                friction_force = attributes.frictionForce or 0.50,
                vertical_selection_shift = -0.5,
                air_resistance = 0.0075, -- this is a percentage of current speed that will be subtracted
                connection_distance = 3,
                joint_distance = 4,
                energy_per_hit_point = 5,
                resistances = attributes.resistances or
                    {
                        {
                            type = "fire",
                            decrease = 15,
                            percent = 50
                        },
                        {
                            type = "physical",
                            decrease = 15,
                            percent = 30
                        },
                        {
                            type = "impact",
                            decrease = 50,
                            percent = 60
                        },
                        {
                            type = "explosion",
                            decrease = 15,
                            percent = 30
                        },
                        {
                            type = "acid",
                            decrease = 10,
                            percent = 20
                        }
                    },
                energy_source = attributes.energySource or
                    {
                        type = "burner",
                        fuel_category = "chemical",
                        effectivity = 1,
                        fuel_inventory_size = 3,
                        smoke =
                            {
                                {
                                    name = "train-smoke",
                                    deviation = {0.3, 0.3},
                                    frequency = 100,
                                    position = {0, 0},
                                    starting_frame = 0,
                                    starting_frame_deviation = 60,
                                    height = 2,
                                    height_deviation = 0.5,
                                    starting_vertical_speed = 0.2,
                                    starting_vertical_speed_deviation = 0.1
                                }
                            }
                    },
                minimap_representation =
                    {
                        filename = "__base__/graphics/entity/locomotive/minimap-representation/locomotive-minimap-representation.png",
                        flags = {"icon"},
                        size = {20, 40},
                        scale = 0.5
                    },
                selected_minimap_representation =
                    {
                        filename = "__base__/graphics/entity/locomotive/minimap-representation/locomotive-selected-minimap-representation.png",
                        flags = {"icon"},
                        size = {20, 40},
                        scale = 0.5
                    },
                front_light =
                    {
                        {
                            type = "oriented",
                            minimum_darkness = 0.3,
                            picture =
                                {
                                    filename = "__core__/graphics/light-cone.png",
                                    priority = "extra-high",
                                    flags = { "light" },
                                    scale = 2,
                                    width = 200,
                                    height = 200
                                },
                            shift = {-0.6, -16},
                            size = 2,
                            intensity = 0.6,
                            color = {r = 1.0, g = 0.9, b = 0.9}
                        },
                        {
                            type = "oriented",
                            minimum_darkness = 0.3,
                            picture =
                                {
                                    filename = "__core__/graphics/light-cone.png",
                                    priority = "extra-high",
                                    flags = { "light" },
                                    scale = 2,
                                    width = 200,
                                    height = 200
                                },
                            shift = {0.6, -16},
                            size = 2,
                            intensity = 0.6,
                            color = {r = 1.0, g = 0.9, b = 0.9}
                        }
                    },
                back_light = {
                    {
                        minimum_darkness = 0.3,
                        color = {1, 0.1, 0.05, 0},
                        shift = {-0.6, 3.5},
                        size = 2,
                        intensity = 0.6,
                        add_perspective = true
                    },
                    {
                        minimum_darkness = 0.3,
                        color = {1, 0.1, 0.05, 0},
                        shift = {0.6, 3.5},
                        size = 2,
                        intensity = 0.6,
                        add_perspective = true
                    }
                },
                stand_by_light = {
                    {
                        minimum_darkness = 0.3,
                        color = {0.05, 0.2, 1, 0},
                        shift = {-0.6, -3.5},
                        size = 2,
                        intensity = 0.5,
                        add_perspective = true
                    },
                    {
                        minimum_darkness = 0.3,
                        color = {0.05, 0.2, 1, 0},
                        shift = {0.6, -3.5},
                        size = 2,
                        intensity = 0.5,
                        add_perspective = true
                    }
                },
                color = {r = 0.92, g = 0.07, b = 0, a = 0.5},
                pictures =
                {
                    rotated =
                    {
                      layers =
                      {
                        util.sprite_load("__base__/graphics/entity/locomotive/locomotive",
                          {
                            dice = 4,
                            priority = "very-low",
                            allow_low_quality_rotation = true,
                            direction_count = 256,
                            scale = 0.5,
                            usage = "train"
                          }
                        ),
                        util.sprite_load("__base__/graphics/entity/locomotive/locomotive-mask",
                          {
                            dice = 4,
                            priority = "very-low",
                            flags = { "mask" },
                            apply_runtime_tint = true,
                            tint_as_overlay = true,
                            allow_low_quality_rotation = true,
                            direction_count = 256,
                            scale = 0.5,
                            usage = "train"
                          }
                        ),
                        util.sprite_load("__base__/graphics/entity/locomotive/locomotive-shadow",
                          {
                            dice = 4,
                            priority = "very-low",
                            flags = { "shadow" },
                            draw_as_shadow = true,
                            allow_low_quality_rotation = true,
                            direction_count = 256,
                            scale = 0.5,
                            usage = "train"
                          }
                        )
                      }
                    },
                  },
                wheels = {
                    rotated = util.sprite_load("__base__/graphics/entity/train-wheel/train-wheel",
                      {
                        priority = "very-low",
                        direction_count = 256,
                        scale = 0.5,
                        shift = util.by_pixel(0, 8),
                        usage = "train"
                      }
                    )
                  },
                rail_category = "regular",
                stop_trigger =
                    {
                        -- left side
                        {
                            type = "create-trivial-smoke",
                            repeat_count = 125,
                            smoke_name = "smoke-train-stop",
                            initial_height = 0,
                            -- smoke goes to the left
                            speed = {-0.03, 0},
                            speed_multiplier = 0.75,
                            speed_multiplier_deviation = 1.1,
                            offset_deviation = {{-0.75, -2.7}, {-0.3, 2.7}}
                        },
                        -- right side
                        {
                            type = "create-trivial-smoke",
                            repeat_count = 125,
                            smoke_name = "smoke-train-stop",
                            initial_height = 0,
                            -- smoke goes to the right
                            speed = {0.03, 0},
                            speed_multiplier = 0.75,
                            speed_multiplier_deviation = 1.1,
                            offset_deviation = {{0.3, -2.7}, {0.75, 2.7}}
                        },
                        {
                            type = "play-sound",
                            sound =
                                {
                                    {
                                        filename = "__base__/sound/train-breaks.ogg",
                                        volume = 0.6
                                    }
                                }
                        }
                    },
                drive_over_tie_trigger =  
                    {
                        type = "play-sound",
                        sound = sound_variations("__base__/sound/train-tie", 6, 0.4, { volume_multiplier("main-menu", 2.4), volume_multiplier("driving", 1.3) } )
                    },
                tie_distance = 50,
                vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
                working_sound =
                    {
                        sound =
                            {
                                filename = "__base__/sound/train-engine.ogg",
                                volume = 0.4
                            },
                        match_speed_to_activity = true
                    },
                open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.7 },
                close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.7 },
                sound_minimum_speed = 0.7,
                water_reflection = 
                    {
                        pictures =
                        {
                        filename = "__base__/graphics/entity/locomotive/reflection/locomotive-reflection.png",
                        priority = "extra-high",
                        width = 20,
                        height = 52,
                        shift = util.by_pixel(0, 40),
                        variation_count = 1,
                        scale = 5
                        },
                        rotate = true,
                        orientation_to_variation = false
                    },
            }
    })

    return name
end


return vehicleUtils
