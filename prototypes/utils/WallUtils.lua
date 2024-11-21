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


local wallUtils = {}

local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

function wallUtils.addResistance(eType, name, resistance)
    if data.raw[eType][name] then
        for i=1,#data.raw[eType][name].resistances do
            if (resistance.type == data.raw[eType][name].resistances[i].type) then
                data.raw[eType][name].resistances[i] = resistance
                return
            end
        end
        data.raw[eType][name].resistances[#data.raw[eType][name].resistances+1] = resistance
    end
end


function wallUtils.makeWall(attributes, attack)
    local name = attributes.name .. "-wall-rampant-arsenal"
    local itemName = attributes.name .. "-wall-rampant-arsenal"

    data:extend({
            {
                type = "item",
                name = itemName,
                icon = attributes.icon or "__base__/graphics/icons/gun-turret.png",
                icon_size = 32,
                flags = attributes.itemFlags or {},
                subgroup = attributes.subgroup or "defensive-structure",
                order = attributes.order or "a[stone-wall]-a[stone-wall]",
                place_result = name,
                stack_size = attributes.stackSize or 200
            },
            {
                type = "wall",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/stone-wall.png",
                icon_size = 32,
                flags = {"placeable-neutral", "player-creation"},
                collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
                selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
                minable = {mining_time = 0.5, result = name},
                fast_replaceable_group = "wall",
                max_health = attributes.health or 350,
                healing_per_tick = attributes.healing,
                damaged_trigger_effect = hit_effects.wall(),                                
                repair_speed_modifier = attributes.repairSpeed or 2,
                hide_resistances = false,
                corpse = "wall-remnants",
                repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" },
                mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
                vehicle_impact_sound = sounds.car_stone_impact,
                -- this kind of code can be used for having walls mirror the effect
                -- there can be multiple reaction items
                attack_reaction = attack
                -- {
                -- 	{
                -- 	    -- how far the mirroring works
                -- 	    range = 2,
                -- 	    -- what kind of damage triggers the mirroring
                -- 	    -- if not present then anything triggers the mirroring
                -- 	    damage_type = "physical",
                -- 	    -- caused damage will be multiplied by this and added to the subsequent damages
                -- 	    reaction_modifier = 0.1,
                -- 	    action =
                -- 		{
                -- 		    type = "direct",
                -- 		    action_delivery =
                -- 			{
                -- 			    type = "instant",
                -- 			    target_effects =
                -- 				{
                -- 				    type = "damage",
                -- 				    -- always use at least 0.1 damage
                -- 				    damage = {amount = 0.1, type = "physical"}
                -- 				}
                -- 			}
                -- 		},
                -- 	}
                -- }
                ,
                connected_gate_visualization =
                    {
                        filename = "__core__/graphics/arrows/underground-lines.png",
                        priority = "high",
                        width = 64,
                        height = 64,
                        scale = 0.5
                    },
                resistances = attributes.resistances or
                    {
                        {
                            type = "physical",
                            decrease = 3,
                            percent = 20
                        },                        
                        {
                            type = "impact",
                            decrease = 45,
                            percent = 60
                        },
                        {
                            type = "explosion",
                            decrease = 10,
                            percent = 30
                        },
                        {
                            type = "fire",
                            percent = 100
                        },
                        {
                            type = "laser",
                            percent = 70
                        }
                    },
                pictures =
                    {
                        single =
                            {
                                layers =
                                    {
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-single.png",
                                            priority = "extra-high",
                                            width = 64,
                                            height = 86,
                                            variation_count = 2,
                                            line_length = 2,
                                            tint = attributes.tint,
                                            shift = util.by_pixel(0, -5),
                                            scale = 0.5
                                        },
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-single-shadow.png",
                                            priority = "extra-high",
                                            width = 98,
                                            height = 60,
                                            tint = attributes.tint,
                                            repeat_count = 2,
                                            shift = util.by_pixel(10, 17),
                                            draw_as_shadow = true,
                                            scale = 0.5
                                        }
                                    }
                            },
                        straight_vertical =
                            {
                                layers =
                                    {
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-vertical.png",
                                            priority = "extra-high",
                                            width = 64,
                                            height = 134,
                                            variation_count = 5,
                                            line_length = 5,
                                            tint = attributes.tint,
                                            shift = util.by_pixel(0, 8),
                                            scale = 0.5
                                        },
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-vertical-shadow.png",
                                            priority = "extra-high",
                                            width = 98,
                                            height = 110,
                                            repeat_count = 5,
                                            tint = attributes.tint,
                                            shift = util.by_pixel(10, 29),
                                            draw_as_shadow = true,
                                            scale = 0.5
                                        }
                                    }
                            },
                        straight_horizontal =
                            {
                                layers =
                                    {
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-horizontal.png",
                                            priority = "extra-high",
                                            width = 64,
                                            height = 92,
                                            variation_count = 6,
                                            tint = attributes.tint,
                                            line_length = 6,
                                            shift = util.by_pixel(0, -2),
                                            scale = 0.5
                                        },
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-horizontal-shadow.png",
                                            priority = "extra-high",
                                            width = 124,
                                            height = 68,
                                            tint = attributes.tint,
                                            repeat_count = 6,
                                            shift = util.by_pixel(14, 15),
                                            draw_as_shadow = true,
                                            scale = 0.5
                                        }
                                    }
                            },
                        corner_right_down =
                            {
                                layers =
                                    {
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-corner-right.png",
                                            priority = "extra-high",
                                            width = 64,
                                            height = 128,
                                            variation_count = 2,
                                            tint = attributes.tint,
                                            line_length = 2,
                                            shift = util.by_pixel(0, 7),
                                            scale = 0.5
                                        },
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-corner-right-shadow.png",
                                            priority = "extra-high",
                                            width = 124,
                                            height = 120,
                                            tint = attributes.tint,
                                            repeat_count = 2,
                                            shift = util.by_pixel(17, 28),
                                            draw_as_shadow = true,
                                            scale = 0.5
                                        }
                                    }
                            },
                        corner_left_down =
                            {
                                layers =
                                    {
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-corner-left.png",
                                            priority = "extra-high",
                                            width = 64,
                                            height = 134,
                                            variation_count = 2,
                                            tint = attributes.tint,
                                            line_length = 2,
                                            shift = util.by_pixel(0, 7),
                                            scale = 0.5
                                        },
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-corner-left-shadow.png",
                                            priority = "extra-high",
                                            width = 102,
                                            height = 120,
                                            repeat_count = 2,
                                            tint = attributes.tint,
                                            shift = util.by_pixel(9, 28),
                                            draw_as_shadow = true,
                                            scale = 0.5
                                        }
                                    }
                            },
                        t_up =
                            {
                                layers =
                                    {
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-t.png",
                                            priority = "extra-high",
                                            width = 64,
                                            height = 134,
                                            variation_count = 4,
                                            tint = attributes.tint,
                                            line_length = 4,
                                            shift = util.by_pixel(0, 7),
                                            scale = 0.5
                                        },
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-t-shadow.png",
                                            priority = "extra-high",
                                            width = 124,
                                            height = 120,
                                            tint = attributes.tint,
                                            repeat_count = 4,
                                            shift = util.by_pixel(14, 28),
                                            draw_as_shadow = true,
                                            scale = 0.5
                                        }
                                    }
                            },
                        ending_right =
                            {
                                layers =
                                    {
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-ending-right.png",
                                            priority = "extra-high",
                                            width = 64,
                                            height = 92,
                                            variation_count = 2,
                                            tint = attributes.tint,
                                            line_length = 2,
                                            shift = util.by_pixel(0, -3),
                                            scale = 0.5
                                        },
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-ending-right-shadow.png",
                                            priority = "extra-high",
                                            width = 124,
                                            height = 68,
                                            tint = attributes.tint,
                                            repeat_count = 2,
                                            shift = util.by_pixel(17, 15),
                                            draw_as_shadow = true,
                                            scale = 0.5
                                        }
                                    }
                            },
                        ending_left =
                            {
                                layers =
                                    {
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-ending-left.png",
                                            priority = "extra-high",
                                            width = 64,
                                            height = 92,
                                            variation_count = 2,
                                            line_length = 2,
                                            tint = attributes.tint,
                                            shift = util.by_pixel(0, -3),
                                            scale = 0.5
                                        },
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-ending-left-shadow.png",
                                            priority = "extra-high",
                                            width = 102,
                                            height = 68,
                                            repeat_count = 2,
                                            tint = attributes.tint,
                                            shift = util.by_pixel(9, 15),
                                            draw_as_shadow = true,
                                            scale = 0.5
                                        }
                                    }
                            },
                        filling =
                            {
                                filename = "__base__/graphics/entity/wall/wall-filling.png",
                                priority = "extra-high",
                                width = 48,
                                height = 56,
                                variation_count = 8,
                                tint = attributes.tint,
                                line_length = 8,
                                shift = util.by_pixel(0, -1),
                                scale = 0.5
                            },
                        water_connection_patch =
                            {
                                sheets =
                                    {
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-patch.png",
                                            priority = "extra-high",
                                            width = 116,
                                            height = 128,
                                            tint = attributes.tint,
                                            shift = util.by_pixel(0, -2),
                                            scale = 0.5
                                        },
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-patch-shadow.png",
                                            priority = "extra-high",
                                            width = 144,
                                            height = 100,
                                            tint = attributes.tint,
                                            shift = util.by_pixel(9, 15),
                                            draw_as_shadow = true,
                                            scale = 0.5
                                        }
                                    }
                            },
                        gate_connection_patch =
                            {
                                sheets =
                                    {
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-gate.png",
                                            priority = "extra-high",
                                            width = 82,
                                            height = 108,
                                            tint = attributes.tint,
                                            shift = util.by_pixel(0, -7),
                                            scale = 0.5
                                        },
                                        {
                                            filename = "__base__/graphics/entity/wall/wall-gate-shadow.png",
                                            priority = "extra-high",
                                            width = 130,
                                            height = 78,
                                            tint = attributes.tint,
                                            shift = util.by_pixel(14, 18),
                                            draw_as_shadow = true,
                                            scale = 0.5
                                        }
                                    }
                            }
                    },

                wall_diode_green = {
                    sheet =
                        {
                            filename = "__base__/graphics/entity/wall/wall-diode-green.png",
                            priority = "extra-high",
                            width = 72,
                            height = 44,
                            --frames = 4,
                            shift = util.by_pixel(-1, -23),
                            scale = 0.5
                        }
                },
                wall_diode_green_light_top = {
                    minimum_darkness = 0.3,
                    color = {g=1},
                    shift = util.by_pixel(0, -30),
                    size = 1,
                    intensity = 0.3
                },
                wall_diode_green_light_right = {
                    minimum_darkness = 0.3,
                    color = {g=1},
                    shift = util.by_pixel(12, -23),
                    size = 1,
                    intensity = 0.3
                },
                wall_diode_green_light_bottom = {
                    minimum_darkness = 0.3,
                    color = {g=1},
                    shift = util.by_pixel(0, -17),
                    size = 1,
                    intensity = 0.3
                },
                wall_diode_green_light_left = {
                    minimum_darkness = 0.3,
                    color = {g=1},
                    shift = util.by_pixel(-12, -23),
                    size = 1,
                    intensity = 0.3
                },

                wall_diode_red = {
                    sheet =
                        {
                            filename = "__base__/graphics/entity/wall/wall-diode-red.png",
                            priority = "extra-high",
                            width = 72,
                            height = 44,
                            --frames = 4,
                            shift = util.by_pixel(-1, -23),
                            scale = 0.5
                        }
                },
                wall_diode_red_light_top = {
                    minimum_darkness = 0.3,
                    color = {r=1},
                    shift = util.by_pixel(0, -30),
                    size = 1,
                    intensity = 0.3
                },
                wall_diode_red_light_right = {
                    minimum_darkness = 0.3,
                    color = {r=1},
                    shift = util.by_pixel(12, -23),
                    size = 1,
                    intensity = 0.3
                },
                wall_diode_red_light_bottom = {
                    minimum_darkness = 0.3,
                    color = {r=1},
                    shift = util.by_pixel(0, -17),
                    size = 1,
                    intensity = 0.3
                },
                wall_diode_red_light_left = {
                    minimum_darkness = 0.3,
                    color = {r=1},
                    shift = util.by_pixel(-12, -23),
                    size = 1,
                    intensity = 0.3
                },

                damaged_trigger_effect = hit_effects.wall(),
                
                circuit_wire_connection_point = circuit_connector_definitions["wall"].points,
                circuit_connector_sprites = circuit_connector_definitions["wall"].sprites,
                circuit_wire_max_distance = default_circuit_wire_max_distance,
                default_output_signal = data.is_demo and {type = "virtual", name = "signal-green"} or {type = "virtual", name = "signal-G"}
            }
    })

    return name, itemName
end

function wallUtils.makeGate(attributes, attack)
    local name = attributes.name .. "-gate-rampant-arsenal"
    local itemName = attributes.name .. "-gate-rampant-arsenal"

    data:extend({
            {
                type = "item",
                name = itemName,
                icon = attributes.icon or "__base__/graphics/icons/gun-turret.png",
                icon_size = 32,
                flags = attributes.itemFlags or {},
                subgroup = attributes.subgroup or "defensive-structure",
                order = attributes.order or "b[turret]-a[gun-turret]",
                place_result = name,
                stack_size = attributes.stackSize or 200
            },
            {
                type = "gate",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/gate.png",
                icon_size = 32,
                flags = {"placeable-neutral","placeable-player", "player-creation"},
                fast_replaceable_group = "wall",
                minable = {hardness = 0.2, mining_time = 0.5, result = name},
                max_health = attributes.health or 350,
                healing_per_tick = attributes.healing or 0.04,
                damaged_trigger_effect = hit_effects.wall(),                
                attack_reaction = attack,
                hide_resistances = false,
                corpse = "small-remnants",
                collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
                selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
                opening_speed = 0.0666666,
                activation_distance = 3,
                timeout_to_close = 5,
                fadeout_interval = 15,
                resistances = attributes.resistances or
                    {
                        {
                            type = "physical",
                            decrease = 3,
                            percent = 20
                        },
                        {
                            type = "impact",
                            decrease = 45,
                            percent = 60
                        },
                        {
                            type = "explosion",
                            decrease = 10,
                            percent = 30
                        },
                        {
                            type = "fire",
                            percent = 100
                        },
                        {
                            type = "laser",
                            percent = 70
                        }
                    },
                vertical_animation =
                    {
                        layers =
                            {
                                {
                                    filename = "__base__/graphics/entity/gate/gate-vertical.png",
                                    line_length = 8,
                                    width = 78,
                                    height = 120,
                                    frame_count = 16,
                                    tint = attributes.tint,
                                    shift = util.by_pixel(-1, -13),
                                    scale = 0.5
                                },
                                {
                                    filename = "__base__/graphics/entity/gate/gate-vertical-shadow.png",
                                    line_length = 8,
                                    width = 82,
                                    height = 104,
                                    frame_count = 16,
                                    tint = attributes.tint,
                                    shift = util.by_pixel(9, 9),
                                    draw_as_shadow = true,
                                    scale = 0.5
                                }
                            }
                    },
                horizontal_animation =
                    {
                        layers =
                            {
                                {
                                    filename = "__base__/graphics/entity/gate/gate-horizontal.png",
                                    line_length = 8,
                                    width = 66,
                                    height = 90,
                                    frame_count = 16,
                                    tint = attributes.tint,
                                    shift = util.by_pixel(0, -3),
                                    scale = 0.5
                                },
                                {
                                    filename = "__base__/graphics/entity/gate/gate-horizontal-shadow.png",
                                    line_length = 8,
                                    width = 122,
                                    height = 60,
                                    frame_count = 16,
                                    tint = attributes.tint,
                                    shift = util.by_pixel(12, 10),
                                    draw_as_shadow = true,
                                    scale = 0.5
                                }
                            }
                    },
                horizontal_rail_animation_left =
                    {
                        layers =
                            {
                                {
                                    filename = "__base__/graphics/entity/gate/gate-rail-horizontal-left.png",
                                    line_length = 8,
                                    width = 66,
                                    height = 74,
                                    frame_count = 16,
                                    tint = attributes.tint,
                                    shift = util.by_pixel(0, -7),
                                    scale = 0.5
                                },
                                {
                                    filename = "__base__/graphics/entity/gate/gate-rail-horizontal-shadow-left.png",
                                    line_length = 8,
                                    width = 122,
                                    height = 60,
                                    tint = attributes.tint,
                                    frame_count = 16,
                                    shift = util.by_pixel(12, 10),
                                    draw_as_shadow = true,
                                    scale = 0.5
                                }
                            }
                    },
                horizontal_rail_animation_right =
                    {
                        layers =
                            {
                                {
                                    filename = "__base__/graphics/entity/gate/gate-rail-horizontal-right.png",
                                    line_length = 8,
                                    width = 66,
                                    height = 74,
                                    tint = attributes.tint,
                                    frame_count = 16,
                                    shift = util.by_pixel(0, -7),
                                    scale = 0.5
                                },
                                {
                                    filename = "__base__/graphics/entity/gate/gate-rail-horizontal-shadow-right.png",
                                    line_length = 8,
                                    width = 122,
                                    height = 58,
                                    tint = attributes.tint,
                                    frame_count = 16,
                                    shift = util.by_pixel(12, 11),
                                    draw_as_shadow = true,
                                    scale = 0.5
                                }
                            }
                    },
                vertical_rail_animation_left =
                    {
                        layers =
                            {
                                {
                                    filename = "__base__/graphics/entity/gate/gate-rail-vertical-left.png",
                                    line_length = 8,
                                    width = 42,
                                    height = 118,
                                    tint = attributes.tint,
                                    frame_count = 16,
                                    shift = util.by_pixel(0, -13),
                                    scale = 0.5
                                },
                                {
                                    filename = "__base__/graphics/entity/gate/gate-rail-vertical-shadow-left.png",
                                    line_length = 8,
                                    width = 82,
                                    height = 104,
                                    tint = attributes.tint,
                                    frame_count = 16,
                                    shift = util.by_pixel(9, 9),
                                    draw_as_shadow = true,
                                    scale = 0.5
                                }
                            }
                    },
                vertical_rail_animation_right =
                    {
                        layers =
                            {
                                {
                                    filename = "__base__/graphics/entity/gate/gate-rail-vertical-right.png",
                                    line_length = 8,
                                    width = 42,
                                    height = 118,
                                    frame_count = 16,
                                    tint = attributes.tint,
                                    shift = util.by_pixel(0, -13),
                                    scale = 0.5
                                },
                                {
                                    filename = "__base__/graphics/entity/gate/gate-rail-vertical-shadow-right.png",
                                    line_length = 8,
                                    width = 82,
                                    height = 104,
                                    frame_count = 16,
                                    tint = attributes.tint,
                                    shift = util.by_pixel(9, 9),
                                    draw_as_shadow = true,
                                    scale = 0.5
                                }
                            }
                    },
                vertical_rail_base =
                    {
                        filename = "__base__/graphics/entity/gate/gate-rail-base-vertical.png",
                        line_length = 8,
                        width = 138,
                        height = 130,
                        tint = attributes.tint,
                        frame_count = 16,
                        shift = util.by_pixel(-1, 0),
                        scale = 0.5
                    },
                horizontal_rail_base =
                    {
                        filename = "__base__/graphics/entity/gate/gate-rail-base-horizontal.png",
                        line_length = 8,
                        width = 130,
                        height = 104,
                        tint = attributes.tint,
                        frame_count = 16,
                        shift = util.by_pixel(0, 3),
                        scale = 0.5
                    },
                wall_patch =
                    {
                        layers =
                            {
                                {
                                    filename = "__base__/graphics/entity/gate/gate-wall-patch.png",
                                    line_length = 8,
                                    width = 70,
                                    height = 94,
                                    tint = attributes.tint,
                                    frame_count = 16,
                                    shift = util.by_pixel(-1, 13),
                                    scale = 0.5
                                },
                                {
                                    filename = "__base__/graphics/entity/gate/gate-wall-patch-shadow.png",
                                    line_length = 8,
                                    width = 82,
                                    tint = attributes.tint,
                                    height = 72,
                                    frame_count = 16,
                                    shift = util.by_pixel(9, 33),
                                    draw_as_shadow = true,
                                    scale = 0.5
                                }
                            }
                    },
                vehicle_impact_sound = sounds.generic_impact,
                open_sound = sounds.gate_open,
                close_sound = sounds.gate_close
            }
    })

    return name, itemName
end

return wallUtils
