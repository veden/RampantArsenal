local power = {}

local recipeUtils = require("utils/RecipeUtils")
local itemUtils = require("utils/ItemUtils")
local powerUtils = require("utils/PowerUtils")
local technologyUtils = require("utils/TechnologyUtils")
local scaleUtils = require("utils/ScaleUtils")

local addEffectToTech = technologyUtils.addEffectToTech
local makeRecipe = recipeUtils.makeRecipe
local makeOilBurner = powerUtils.makeOilBurner
local addFuelToItem = itemUtils.addFuelToItem
local scalePicture = scaleUtils.scalePicture

function power.enable()

    if settings.startup["rampant-arsenal-enableOilBurner"].value then        
        local oilBurner = makeOilBurner({
                name = "basic",
                icon = "__RampantArsenal__/graphics/icons/oil-burner.png",
                burnFluid = true,
                scaleFluidUsage = true,
                fluidPerTick = 1,
                effectivity = 1,
                maxTemp = 25,
                emissions = 0.00004,
                scale = 0.5,
                tint = { r = 0.7, g = 0.4, b = 0, a = 1 }
        })

        makeRecipe({
                name = oilBurner,
                icon = "__RampantArsenal__/graphics/icons/oil-burner.png",
                enabled = false,
                category = "crafting",
                ingredients = {
                    {"chemical-plant", 1},
                    {"steel-furnace", 1},
                    {"electronic-circuit", 30},
                    {"copper-plate", 20}
                },
                result = oilBurner
        })
        
        addEffectToTech("rampant-arsenal-technology-oil-burner",
                        {
                            type = "unlock-recipe",
                            recipe = oilBurner
        })
        
        addFuelToItem({
                eType = "fluid",
                eName = "light-oil",
                fuelValue = "0.95MJ",
                fuelEmissionsMultipler = 1.5
        })
        
        addFuelToItem({
                eType = "fluid",
                eName = "crude-oil",
                
                fuelValue = "0.45MJ",
                fuelEmissionsMultipler = 4
        })
        
        addFuelToItem({
                eType = "fluid",
                eName = "heavy-oil",
                fuelValue = "0.57MJ",
                fuelEmissionsMultipler = 3
        })

        addFuelToItem({
                eType = "fluid",
                eName = "petroleum-gas",
                fuelValue = "1.1MJ",
                fuelEmissionsMultipler = 2
        })

    end

    if settings.startup["rampant-arsenal-enableAdvancedSolarPanel"].value then
        local solarPanel = table.deepcopy(data.raw["solar-panel"]["solar-panel"])
        solarPanel.name = "advanced-solar-panel-rampant-arsenal"
        solarPanel.minable.result = "advanced-solar-panel-rampant-arsenal"
        solarPanel.collision_box[1][1] = solarPanel.collision_box[1][1] * 4
        solarPanel.collision_box[1][2] = solarPanel.collision_box[1][2] * 4
        solarPanel.collision_box[2][1] = solarPanel.collision_box[2][1] * 4
        solarPanel.collision_box[2][2] = solarPanel.collision_box[2][2] * 4

        solarPanel.selection_box[1][1] = solarPanel.selection_box[1][1] * 4
        solarPanel.selection_box[1][2] = solarPanel.selection_box[1][2] * 4
        solarPanel.selection_box[2][1] = solarPanel.selection_box[2][1] * 4
        solarPanel.selection_box[2][2] = solarPanel.selection_box[2][2] * 4

        solarPanel.max_health = 1000
        
        solarPanel.production = "1.44MW"

        solarPanel.next_upgrade = ""

        scalePicture(2, solarPanel.picture)
        -- scalePicture(2, solarPanel.overlay, true)

        solarPanel.overlay = {
            layers =
                {
                    {
                        filename = "__base__/graphics/entity/solar-panel/solar-panel-shadow-overlay.png",
                        priority = "high",
                        width = 108,
                        height = 90,
                        shift = util.by_pixel(50, 6),
                        scale = 4,
                        hr_version =
                            {
                                filename = "__base__/graphics/entity/solar-panel/hr-solar-panel-shadow-overlay.png",
                                priority = "high",
                                width = 214,
                                height = 180,
                                shift = util.by_pixel(50, 6),
                                scale = 2
                            }
                    }
                }
        }

        local recipe = table.deepcopy(data.raw["recipe"]["solar-panel"])
        recipe.name = "advanced-solar-panel-rampant-arsenal"
        recipe.ingredients = {
            {"steel-plate", 20},
            {"electronic-circuit", 30},
            {"solar-panel", 16}
        }
        recipe.result = "advanced-solar-panel-rampant-arsenal"

        local item = table.deepcopy(data.raw["item"]["solar-panel"])
        item.name = "advanced-solar-panel-rampant-arsenal"
        item.place_result = "advanced-solar-panel-rampant-arsenal"
        item.order = "d[solar-panel]-a[zsolar-panel]"

        local solarTech = table.deepcopy(data.raw["technology"]["solar-energy"])

        solarTech.name = "rampant-arsenal-technology-solar-energy-2"
        solarTech.effects = {
            {
                type = "unlock-recipe",
                recipe = "advanced-solar-panel-rampant-arsenal"
            }
        }
        solarTech.prerequisites = { "solar-energy", "electric-energy-distribution-2" }
        solarTech.unit =
            {
                count = 400,
                ingredients =
                    {
                        {"automation-science-pack", 1},
                        {"logistic-science-pack", 1},
                        {"chemical-science-pack", 1},
                        {"utility-science-pack", 1}
                    },
                time = 60
            }

        data:extend({
                solarPanel,
                recipe,
                item,
                solarTech
        })
    end

    if settings.startup["rampant-arsenal-enableAdvancedAccumulator"].value then
        local accumulator = table.deepcopy(data.raw["accumulator"]["accumulator"])
        accumulator.name = "advanced-accumulator-rampant-arsenal"
        accumulator.collision_box[1][1] = accumulator.collision_box[1][1] * 3.4 
        accumulator.collision_box[1][2] = accumulator.collision_box[1][2] * 3 + 1.8
        accumulator.collision_box[2][1] = accumulator.collision_box[2][1] * 3.4 
        accumulator.collision_box[2][2] = accumulator.collision_box[2][2] * 3 + 1.8

        accumulator.minable.result = "advanced-accumulator-rampant-arsenal"
        
        accumulator.selection_box[1][1] = accumulator.selection_box[1][1] * 3.4
        accumulator.selection_box[1][2] = accumulator.selection_box[1][2] * 3 + 1.8
        accumulator.selection_box[2][1] = accumulator.selection_box[2][1] * 3.4
        accumulator.selection_box[2][2] = accumulator.selection_box[2][2] * 3 + 1.8

        accumulator.max_health = 2000
        
        accumulator.energy_source.buffer_capacity = "67.5MJ"
        accumulator.energy_source.input_flow_limit = "4MW"
        accumulator.energy_source.output_flow_limit = "4MW"
        
        scalePicture(1.8, accumulator.picture)
        scalePicture(1.8, accumulator.charge_animation)

        accumulator.next_upgrade = ""
        
        local picture = function (tint, repeat_count)
            return {
                layers =
                    {
                        {
                            filename = "__base__/graphics/entity/accumulator/accumulator.png",
                            priority = "high",
                            width = 66,
                            height = 94,
                            repeat_count = repeat_count,
                            shift = util.by_pixel(0, -10),
                            tint = tint,
                            animation_speed = 0.5,
                            scale = 3.6,
                            hr_version =
                                {
                                    filename = "__base__/graphics/entity/accumulator/hr-accumulator.png",
                                    priority = "high",
                                    width = 130,
                                    height = 189,
                                    repeat_count = repeat_count,
                                    shift = util.by_pixel(0, -11),
                                    tint = tint,
                                    animation_speed = 0.5,
                                    scale = 1.8
                                }
                        },
                        {
                            filename = "__base__/graphics/entity/accumulator/accumulator-shadow.png",
                            priority = "high",
                            width = 120,
                            height = 54,
                            repeat_count = repeat_count,
                            shift = util.by_pixel(28, 6),
                            draw_as_shadow = true,
                            scale = 3.6,
                            hr_version =
                                {
                                    filename = "__base__/graphics/entity/accumulator/hr-accumulator-shadow.png",
                                    priority = "high",
                                    width = 234,
                                    height = 106,
                                    repeat_count = repeat_count,
                                    shift = util.by_pixel(29, 6),
                                    draw_as_shadow = true,
                                    scale = 1.8
                                }
                        }
                    }
            }
        end

        local charging = {
            layers =
                {
                    picture({ r=1, g=1, b=1, a=1 } , 24),
                    {
                        filename = "__base__/graphics/entity/accumulator/accumulator-charge.png",
                        priority = "high",
                        width = 90,
                        height = 100,
                        line_length = 6,
                        frame_count = 24,
                        blend_mode = "additive",
                        shift = util.by_pixel(0, -50),
                        scale = 3.6,
                        hr_version =
                            {
                                filename = "__base__/graphics/entity/accumulator/hr-accumulator-charge.png",
                                priority = "high",
                                width = 178,
                                height = 206,
                                line_length = 6,
                                frame_count = 24,
                                blend_mode = "additive",
                                shift = util.by_pixel(0, -50),
                                scale = 1.8
                            }
                    }
                }
        }

        local discharging = {
            layers =
                {
                    picture({ r=1, g=1, b=1, a=1 } , 24),
                    {
                        filename = "__base__/graphics/entity/accumulator/accumulator-discharge.png",
                        priority = "high",
                        width = 88,
                        height = 104,
                        line_length = 6,
                        frame_count = 24,
                        blend_mode = "additive",
                        scale = 3.6,
                        shift = util.by_pixel(-2, -50),
                        hr_version =
                            {
                                filename = "__base__/graphics/entity/accumulator/hr-accumulator-discharge.png",
                                priority = "high",
                                width = 170,
                                height = 210,
                                line_length = 6,
                                frame_count = 24,
                                blend_mode = "additive",
                                shift = util.by_pixel(-1, -50),
                                scale = 1.8
                            }
                    }
                }
        }
        
        accumulator.charge_animation = charging
        accumulator.discharge_animation = discharging
            
        local recipe = table.deepcopy(data.raw["recipe"]["accumulator"])
        recipe.name = "advanced-accumulator-rampant-arsenal"
        recipe.ingredients = {
            {"steel-plate", 20},
            {"electronic-circuit", 30},
            {"accumulator", 9}
        }
        recipe.result = "advanced-accumulator-rampant-arsenal"

        local item = table.deepcopy(data.raw["item"]["accumulator"])
        item.name = "advanced-accumulator-rampant-arsenal"
        item.place_result = "advanced-accumulator-rampant-arsenal"
        item.order = "e[accumulator]-a[zaccumulator]"

        local solarTech = table.deepcopy(data.raw["technology"]["electric-energy-accumulators"])

        solarTech.localised_name = nil
        
        solarTech.name = "rampant-arsenal-technology-electric-energy-accumulators-2"
        solarTech.effects = {
            {
                type = "unlock-recipe",
                recipe = "advanced-accumulator-rampant-arsenal"
            }
        }
        solarTech.prerequisites = { "electric-energy-accumulators", "electric-energy-distribution-2" }
        solarTech.unit =
            {
                count = 400,
                ingredients =
                    {
                        {"automation-science-pack", 1},
                        {"logistic-science-pack", 1},
                        {"chemical-science-pack", 1},
                        {"utility-science-pack", 1}
                    },
                time = 60
            }

        data:extend({
                accumulator,
                recipe,
                item,
                solarTech
        })
    end
end

return power
