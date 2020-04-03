local buildings = {}

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

function buildings.enable()

    if settings.startup["rampant-arsenal-enableAdvancedLab"].value then
        data:extend({
                {
                    type = "corpse",
                    name = "advanced-lab-remnants-rampant-arsenal",
                    icon = "__base__/graphics/icons/lab.png",
                    icon_size = 64, icon_mipmaps = 4,
                    flags = {"placeable-neutral", "not-on-map"},
                    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
                    tile_width = 3,
                    tile_height = 3,
                    selectable_in_game = false,
                    subgroup = "remnants",
                    order="d[remnants]-a[generic]-a[small]",
                    time_before_removed = 60 * 60 * 15, -- 15 minutes
                    final_render_layer = "remnants",
                    remove_on_tile_placement = false,
                    animation = make_rotated_animation_variations_from_sheet (2,
                                                                              {
                                                                                  filename = "__base__/graphics/entity/lab/remnants/lab-remnants.png",
                                                                                  line_length = 1,
                                                                                  width = 134,
                                                                                  height = 100,
                                                                                  frame_count = 1,
                                                                                  variation_count = 1,
                                                                                  axially_symmetrical = false,
                                                                                  direction_count = 1,
                                                                                  shift = util.by_pixel(7, 6),
                                                                                  scale = 4,
                                                                                  hr_version =
                                                                                      {
                                                                                          filename = "__base__/graphics/entity/lab/remnants/hr-lab-remnants.png",
                                                                                          line_length = 1,
                                                                                          width = 266,
                                                                                          height = 196,
                                                                                          frame_count = 1,
                                                                                          variation_count = 1,
                                                                                          axially_symmetrical = false,
                                                                                          direction_count = 1,
                                                                                          shift = util.by_pixel(7, 5.5),
                                                                                          scale = 2
                                                                                      },
                    })
                }
        })

        local lab = table.deepcopy(data.raw["lab"]["lab"])
        lab.name = "advanced-lab-rampant-arsenal"
        lab.minable.result = "advanced-lab-rampant-arsenal"
        lab.collision_box[1][1] = lab.collision_box[1][1] * 4
        lab.collision_box[1][2] = lab.collision_box[1][2] * 4
        lab.collision_box[2][1] = lab.collision_box[2][1] * 4
        lab.collision_box[2][2] = lab.collision_box[2][2] * 4

        lab.selection_box[1][1] = lab.selection_box[1][1] * 4
        lab.selection_box[1][2] = lab.selection_box[1][2] * 4
        lab.selection_box[2][1] = lab.selection_box[2][1] * 4
        lab.selection_box[2][2] = lab.selection_box[2][2] * 4
        lab.corpse = "advanced-lab-remnants-rampant-arsenal"

        lab.max_health = 1000

        lab.energy_usage = "1.5MW"

        lab.researching_speed = 24

        lab.next_upgrade = ""

        lab.module_specification =
            {
                module_slots = 4,
                module_info_icon_shift = {0, 0.9}
            }

        scalePicture(2, lab.on_animation)
        scalePicture(2, lab.off_animation)

        local recipe = table.deepcopy(data.raw["recipe"]["lab"])
        recipe.name = "advanced-lab-rampant-arsenal"
        recipe.enabled = false
        recipe.ingredients = {
            {"steel-plate", 20},
            {"electronic-circuit", 30},
            {"lab", 16}
        }
        recipe.energy_required = 30
        recipe.result = "advanced-lab-rampant-arsenal"

        local item = table.deepcopy(data.raw["item"]["lab"])
        item.name = "advanced-lab-rampant-arsenal"
        item.place_result = "advanced-lab-rampant-arsenal"
        item.order = "g[zlab]"

        addEffectToTech("advanced-lab",
                        {
                            type = "unlock-recipe",
                            recipe = recipe.name,
        })

        data:extend({
                lab,
                recipe,
                item
        })
    end

    if settings.startup["rampant-arsenal-enableLargeStorageTank"].value then
        data:extend({
                {
                    type = "corpse",
                    name = "large-storage-tank-remnants-rampant-arsenal",
                    icon = "__base__/graphics/icons/storage-tank.png",
                    icon_size = 64, icon_mipmaps = 4,
                    flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
                    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
                    tile_width = 3,
                    tile_height = 3,
                    selectable_in_game = false,
                    subgroup = "remnants",
                    order="d[remnants]-a[generic]-b[medium]",
                    time_before_removed = 60 * 60 * 15, -- 15 minutes
                    final_render_layer = "remnants",
                    remove_on_tile_placement = false,
                    animation = make_rotated_animation_variations_from_sheet(1,
                                                                             {
                                                                                 filename = "__base__/graphics/entity/storage-tank/remnants/storage-tank-remnants.png",
                                                                                 line_length = 1,
                                                                                 width = 214,
                                                                                 height = 142,
                                                                                 frame_count = 1,
                                                                                 direction_count = 1,
                                                                                 shift = util.by_pixel(27, 21), --shift = util.by_pixel(-3, 10.5),
                                                                                 scale = 4,
                                                                                 hr_version =
                                                                                     {
                                                                                         filename = "__base__/graphics/entity/storage-tank/remnants/hr-storage-tank-remnants.png",
                                                                                         line_length = 1,
                                                                                         width = 426,
                                                                                         height = 282,
                                                                                         frame_count = 1,
                                                                                         direction_count = 1,
                                                                                         shift = util.by_pixel(27, 21), --shift = util.by_pixel(-2.5, 10.5),
                                                                                         scale = 2
                                                                                     }
                    })
                }
        })

        local storageTank = table.deepcopy(data.raw["storage-tank"]["storage-tank"])
        storageTank.minable.mining_time = 4
        storageTank.name = "large-storage-tank-rampant-arsenal"
        storageTank.minable.result = "large-storage-tank-rampant-arsenal"
        storageTank.collision_box[1][1] = storageTank.collision_box[1][1] * 4
        storageTank.collision_box[1][2] = storageTank.collision_box[1][2] * 4
        storageTank.collision_box[2][1] = storageTank.collision_box[2][1] * 4
        storageTank.collision_box[2][2] = storageTank.collision_box[2][2] * 4

        storageTank.selection_box[1][1] = storageTank.selection_box[1][1] * 4
        storageTank.selection_box[1][2] = storageTank.selection_box[1][2] * 4
        storageTank.selection_box[2][1] = storageTank.selection_box[2][1] * 4
        storageTank.selection_box[2][2] = storageTank.selection_box[2][2] * 4
        storageTank.corpse = "large-storage-tank-remnants-rampant-arsenal"

        storageTank.pictures = {
            picture =
                {
                    sheets =
                        {
                            {
                                filename = "__RampantArsenal__/graphics/entities/lr-large-storage-tank.png",
                                priority = "extra-high",
                                frames = 2,
                                width = 109.5,
                                height = 108,
                                shift = util.by_pixel(-0.25, 3.75),
                                scale = 1,
                                hr_version =
                                    {
                                        filename = "__RampantArsenal__/graphics/entities/large-storage-tank.png",
                                        priority = "extra-high",
                                        frames = 2,
                                        width = 219,
                                        height = 215,
                                        shift = util.by_pixel(-0.25, 3.75),
                                        scale = 1
                                    }
                            },
                            {
                                filename = "__base__/graphics/entity/storage-tank/storage-tank-shadow.png",
                                priority = "extra-high",
                                frames = 2,
                                width = 146,
                                height = 77,                                
                                shift = util.by_pixel(30, 22.5),
                                scale = 1,
                                draw_as_shadow = true,
                                hr_version =
                                    {
                                        filename = "__base__/graphics/entity/storage-tank/hr-storage-tank-shadow.png",
                                        priority = "extra-high",
                                        frames = 2,
                                        width = 291,
                                        height = 153,
                                        shift = util.by_pixel(29.75, 22.25),
                                        scale = 1,
                                        draw_as_shadow = true
                                    }
                            }
                        }
                },
            fluid_background =
                {
                    filename = "__base__/graphics/entity/storage-tank/fluid-background.png",
                    priority = "extra-high",
                    width = 32,
                    height = 15
                },
            window_background =
                {
                    filename = "__base__/graphics/entity/storage-tank/window-background.png",
                    priority = "extra-high",
                    width = 17,
                    height = 24,
                    hr_version =
                        {
                            filename = "__base__/graphics/entity/storage-tank/hr-window-background.png",
                            priority = "extra-high",
                            width = 34,
                            height = 48,
                            scale = 0.5
                        }
                },
            flow_sprite =
                {
                    filename = "__base__/graphics/entity/pipe/fluid-flow-low-temperature.png",
                    priority = "extra-high",
                    width = 160,
                    height = 20
                },
            gas_flow =
                {
                    filename = "__base__/graphics/entity/pipe/steam.png",
                    priority = "extra-high",
                    line_length = 10,
                    width = 24,
                    height = 15,
                    frame_count = 60,
                    axially_symmetrical = false,
                    direction_count = 1,
                    animation_speed = 0.25,
                    hr_version =
                        {
                            filename = "__base__/graphics/entity/pipe/hr-steam.png",
                            priority = "extra-high",
                            line_length = 10,
                            width = 48,
                            height = 30,
                            frame_count = 60,
                            axially_symmetrical = false,
                            animation_speed = 0.25,
                            direction_count = 1,
                            scale = 0.5
                        }
                }
        }

        storageTank.max_health = 2000

        storageTank.fluid_box.base_area = 6000
        storageTank.fluid_box.pipe_connections =
            {
                { position = {-4, 6} },
                { position = {-3, 6} },
                { position = {-6, 3} },
                { position = {-6, 4} },

                { position = {4, -6} },
                { position = {3, -6} },
                { position = {6, -3} },
                { position = {6, -4} }
            }

        scalePicture(2, storageTank.pictures)

        local recipe = table.deepcopy(data.raw["recipe"]["storage-tank"])
        recipe.name = "large-storage-tank-rampant-arsenal"
        recipe.ingredients = {
            {"steel-plate", 20},
            {"electronic-circuit", 30},
            {"storage-tank", 16}
        }
        recipe.energy_required = 30
        recipe.result = "large-storage-tank-rampant-arsenal"

        local item = table.deepcopy(data.raw["item"]["storage-tank"])
        item.name = "large-storage-tank-rampant-arsenal"
        item.place_result = "large-storage-tank-rampant-arsenal"
        item.order = "b[fluid]-a[zstorage-tank]"

        addEffectToTech("large-storage-tank-2",
                        {
                            type = "unlock-recipe",
                            recipe = recipe.name,
        })

        data:extend({
                storageTank,
                recipe,
                item
        })
    end
end

return buildings
