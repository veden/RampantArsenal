local buildings = {}

local recipeUtils = require("utils/RecipeUtils")
local itemUtils = require("utils/ItemUtils")
local powerUtils = require("utils/PowerUtils")
local technologyUtils = require("utils/TechnologyUtils")
local scaleUtils = require("utils/ScaleUtils")
local oilUtils = require("utils/OilUtils")

local addEffectToTech = technologyUtils.addEffectToTech
local makeRecipe = recipeUtils.makeRecipe
local makeOilBurner = powerUtils.makeOilBurner
local addFuelToItem = itemUtils.addFuelToItem
local scalePicture = scaleUtils.scalePicture
local addFluid = oilUtils.addFluid

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

        lab.drawing_box = nil

        lab.max_health = 1000

        lab.energy_usage = "1.75MW"

        lab.researching_speed = 24

        lab.next_upgrade = nil

        lab.module_specification =
            {
                module_slots = 2,
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
        item.icons = {{icon = item.icon, tint={0.8,0.8,1,1}}}
        item.icon = nil
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
        storageTank.minable.mining_time = 3
        storageTank.next_upgrade = nil
        storageTank.name = "large-storage-tank-rampant-arsenal"
        storageTank.minable.result = "large-storage-tank-rampant-arsenal"
        storageTank.collision_box[1][1] = storageTank.collision_box[1][1] * 4
        storageTank.collision_box[1][2] = storageTank.collision_box[1][2] * 4
        storageTank.collision_box[2][1] = storageTank.collision_box[2][1] * 4
        storageTank.collision_box[2][2] = storageTank.collision_box[2][2] * 4

        storageTank.next_upgrade = nil

        storageTank.selection_box[1][1] = storageTank.selection_box[1][1] * 4
        storageTank.selection_box[1][2] = storageTank.selection_box[1][2] * 4
        storageTank.selection_box[2][1] = storageTank.selection_box[2][1] * 4
        storageTank.selection_box[2][2] = storageTank.selection_box[2][2] * 4
        storageTank.drawing_box = nil
        storageTank.corpse = "large-storage-tank-remnants-rampant-arsenal"
        storageTank.window_bounding_box = {{0, 0.5}, {0, 3}}
        storageTank.circuit_connector_sprites = {{connector_main={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04a-base-sequence.png",priority="low",width=52,height=50,scale=0.5,x=156,y=150,shift={1.046875 + 3.2,0.609375 + 3}},
                                                  wire_pins={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04c-wire-sequence.png",priority="low",width=62,height=58,scale=0.5,x=186,y=174,shift={1.046875 + 3.2,0.578125 + 3}},
                                                  wire_pins_shadow={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04d-wire-shadow-sequence.png",priority="low",draw_as_shadow=true,width=70,height=54,scale=0.5,x=210,y=162,shift={1.203125 + 3.2,0.703125 + 3}},
                                                  led_blue={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04e-blue-LED-on-sequence.png",priority="low",width=60,height=60,scale=0.5,x=180,y=180,shift={1.046875 + 3.2,0.578125 + 3}},
                                                  led_blue_off={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04f-blue-LED-off-sequence.png",priority="low",width=46,height=44,scale=0.5,x=138,y=132,shift={1.046875 + 3.2,0.578125 + 3}},
                                                  led_green={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04h-green-LED-sequence.png",priority="low",width=48,height=46,scale=0.5,x=144,y=138,shift={1.046875 + 3.2,0.578125 + 3}},
                                                  led_red={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04i-red-LED-sequence.png",priority="low",width=48,height=46,scale=0.5,x=144,y=138,shift={1.046875 + 3.2,0.578125 + 3}},
                                                  led_light={intensity=0.8,size=0.9},
                                                  blue_led_light_offset={1.203125 + 3.2,0.828125 + 3},
                                                  red_green_led_light_offset={1.203125 + 3.2,0.71875 + 3}},
            {connector_main={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04a-base-sequence.png",priority="low",width=52,height=50,scale=0.5,x=52,y=150,shift={-1.046875 + 3.2,0.640625 + 3}},
             wire_pins={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04c-wire-sequence.png",priority="low",width=62,height=58,scale=0.5,x=62,y=174,shift={-1.046875 + 3.2,0.609375 + 3}},
             wire_pins_shadow={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04d-wire-shadow-sequence.png",priority="low",draw_as_shadow=true,width=70,height=54,scale=0.5,x=70,y=162,shift={-0.890625 + 3,0.734375 + 3}},
             led_blue={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04e-blue-LED-on-sequence.png",priority="low",width=60,height=60,scale=0.5,x=60,y=180,shift={-1.046875 + 3.2,0.609375 + 3}},
             led_blue_off={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04f-blue-LED-off-sequence.png",priority="low",width=46,height=44,scale=0.5,x=46,y=132,shift={-1.046875 + 3.2,0.609375 + 3}},
             led_green={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04h-green-LED-sequence.png",priority="low",width=48,height=46,scale=0.5,x=48,y=138,shift={-1.046875 + 3.2,0.609375 + 3}},
             led_red={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04i-red-LED-sequence.png",priority="low",width=48,height=46,scale=0.5,x=48,y=138,shift={-1.046875 + 3.2,0.609375 + 3}},
             led_light={intensity=0.8,size=0.9},
             blue_led_light_offset={-1.15625 + 3,0.875 + 3},
             red_green_led_light_offset={-1.15625 + 3,0.765625 + 3}},
            {connector_main={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04a-base-sequence.png",priority="low",width=52,height=50,scale=0.5,x=156,y=150,shift={1.046875 + 3.2,0.609375 + 3}},
             wire_pins={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04c-wire-sequence.png",priority="low",width=62,height=58,scale=0.5,x=186,y=174,shift={1.046875 + 3.2,0.578125 + 3}},
             wire_pins_shadow={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04d-wire-shadow-sequence.png",priority="low",draw_as_shadow=true,width=70,height=54,scale=0.5,x=210,y=162,shift={1.203125 + 3.2,0.703125 + 3}},
             led_blue={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04e-blue-LED-on-sequence.png",priority="low",width=60,height=60,scale=0.5,x=180,y=180,shift={1.046875 + 3.2,0.578125 + 3}},
             led_blue_off={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04f-blue-LED-off-sequence.png",priority="low",width=46,height=44,scale=0.5,x=138,y=132,shift={1.046875 + 3.2,0.578125 + 3}},
             led_green={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04h-green-LED-sequence.png",priority="low",width=48,height=46,scale=0.5,x=144,y=138,shift={1.046875 + 3.2,0.578125 + 3}},
             led_red={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04i-red-LED-sequence.png",priority="low",width=48,height=46,scale=0.5,x=144,y=138,shift={1.046875 + 3.2,0.578125 + 3}},
             led_light={intensity=0.8,size=0.9},
             blue_led_light_offset={1.203125 + 3.2,0.828125 + 3},
             red_green_led_light_offset={1.203125 + 3.2,0.71875 + 3}},
            {connector_main={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04a-base-sequence.png",priority="low",width=52,height=50,scale=0.5,x=52,y=150,shift={-1.046875 + 3.2,0.640625 + 3}},
             wire_pins={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04c-wire-sequence.png",priority="low",width=62,height=58,scale=0.5,x=62,y=174,shift={-1.046875 + 3.2,0.609375 + 3}},
             wire_pins_shadow={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04d-wire-shadow-sequence.png",priority="low",draw_as_shadow=true,width=70,height=54,scale=0.5,x=70,y=162,shift={-0.890625 + 3,0.734375 + 3}},
             led_blue={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04e-blue-LED-on-sequence.png",priority="low",width=60,height=60,scale=0.5,x=60,y=180,shift={-1.046875 + 3.2,0.609375 + 3}},
             led_blue_off={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04f-blue-LED-off-sequence.png",priority="low",width=46,height=44,scale=0.5,x=46,y=132,shift={-1.046875 + 3.2,0.609375 + 3}},
             led_green={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04h-green-LED-sequence.png",priority="low",width=48,height=46,scale=0.5,x=48,y=138,shift={-1.046875 + 3.2,0.609375 + 3}},
             led_red={filename="__base__/graphics/entity/circuit-connector/hr-ccm-universal-04i-red-LED-sequence.png",priority="low",width=48,height=46,scale=0.5,x=48,y=138,shift={-1.046875 + 3.2,0.609375 + 3}},
             led_light={intensity=0.8,size=0.9},
             blue_led_light_offset={-1.15625 + 3,0.875 + 3},
             red_green_led_light_offset={-1.15625 + 3,0.765625 + 3}}}
        storageTank.circuit_wire_connection_points = {
            {wire={red={1.34375 + 3.2,0.46875 + 3},green={1.40625 + 3.2,0.6875 + 3}},
             shadow={red={1.65625 + 3.2,0.703125 + 3},green={1.5 + 3.2,0.71875 + 3}}},
            {wire={red={-0.90625 + 3.2,0.8125 + 3},green={-0.984375 + 3.2,1 + 3}},
             shadow={red={-0.59375 + 3.2,1.078125 + 3},green={-0.828125 + 3.2,1.109375 + 3}}},
            {wire={red={1.34375 + 3.2,0.46875 + 3},green={1.40625 + 3.2,0.6875 + 3}},
             shadow={red={1.65625 + 3.2,0.703125 + 3},green={1.5 + 3.2,0.71875 + 3}}},
            {wire={red={-0.90625 + 3.2,0.8125 + 3},green={-0.984375 + 3.2,1 + 3}},
             shadow={red={-0.59375 + 3.2,1.078125 + 3},green={-0.828125 + 3.2,1.109375 + 3}}}}

        storageTank.next_upgrade = ""

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
                    -- filename = "__base__/graphics/entity/storage-tank/fluid-background.png",
                    filename = "__RampantArsenal__/graphics/entities/fluid-background.png",
                    priority = "extra-high",
                    width = 45,
                    height = 35,
                    shift = {0,1.7},
                    scale = 1.2
                },
            window_background =
                {
                    filename = "__base__/graphics/entity/storage-tank/window-background.png",
                    priority = "extra-high",
                    width = 17,
                    height = 24,
                    scale = 2,
                    shift = {0,1.7},
                    hr_version =
                        {
                            filename = "__base__/graphics/entity/storage-tank/hr-window-background.png",
                            priority = "extra-high",
                            width = 34,
                            height = 48,
                            shift = {0,1.7},
                            scale = 1
                        }
                },
            flow_sprite =
                {
                    filename = "__RampantArsenal__/graphics/entities/fluid-flow-low-temperature.png",
                    priority = "extra-high",
                    width = 160,
                    height = 60,
                    shift = {0,1.7},
                    scale = 1
                },
            gas_flow = {
                filename = "__base__/graphics/entity/pipe/steam.png",
                priority = "extra-high",
                line_length = 10,
                width = 24,
                height = 15,
                frame_count = 60,
                axially_symmetrical = false,
                direction_count = 1,
                animation_speed = 0.25,
                shift = {0.2,1.7},
                scale = 2,
                hr_version =
                    {
                        filename = "__RampantArsenal__/graphics/entities/hr-steam.png",
                        priority = "extra-high",
                        line_length = 10,
                        width = 48,
                        height = 120,
                        frame_count = 60,
                        shift = {0.2,1.7},
                        axially_symmetrical = false,
                        animation_speed = 0.25,
                        direction_count = 1
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
        item.icons = {{icon = item.icon, tint={0.7,0.7,1,1}}}
        item.icon = nil
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

    -- if settings.startup["rampant-arsenal-enableAirFiltering"].value then
    --     local airFilter = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"])
    --     airFilter.name = "air-filter-rampant-arsenal"
    --     airFilter.fixed_recipe = "air-filter-pollution-rampant-arsenal"
    --     airFilter.crafting_categories = { "air-filter-rampant-arsenal" }
    --     airFilter.minable = {mining_time=2,result="air-filter-rampant-arsenal"}
    --     airFilter.next_upgrade = nil
    --     airFilter.energy_usage = "750KW"
    --     airFilter.energy_source.drain = "500KW"
    --     airFilter.match_speed_to_activity = true
    --     airFilter.match_volume_to_activity = true
    --     airFilter.crafting_speed = 1
    --     airFilter.fast_replaceable_group = nil
    --     airFilter.default_recipe_tint = {
    --         primary = {r=0,g=1,b=1,a=1},
    --         secondary = {r=1,g=1,b=1,a=1},
    --         tertiary = {r=1,g=1,b=1,a=1},
    --         quaternary = {r=1,g=1,b=1,a=1}
    --     }
    --     airFilter.allowed_effects = { "speed", "productivity", "consumption", "pollution" }
    --     airFilter.animation = {
    --         layers =
    --             {
    --                 {
    --                     filename = "__RampantArsenal__/graphics/entities/hr-air-filter.png",
    --                     priority = "high",
    --                     width = 275,
    --                     height = 210,
    --                     frame_count = 8,
    --                     line_length = 4,
    --                     shift = {-0.45, -0.1},
    --                     scale = 0.6,
    --                     hr_version =
    --                         {
    --                             filename = "__RampantArsenal__/graphics/entities/hr-air-filter.png",
    --                             priority = "high",
    --                             width = 275,
    --                             height = 210,
    --                             frame_count = 8,
    --                             line_length = 4,
    --                             shift = {-0.45, -0.1},
    --                             scale = 0.6
    --                         }
    --                 },
    --                 {
    --                     filename = "__RampantArsenal__/graphics/entities/hr-air-filter-shadow.png",
    --                     priority = "high",
    --                     width = 260,
    --                     height = 162,
    --                     frame_count = 8,
    --                     line_length = 4,
    --                     draw_as_shadow = true,
    --                     shift = util.by_pixel(28, 4),
    --                     hr_version =
    --                         {
    --                             filename = "__RampantArsenal__/graphics/entities/hr-air-filter-shadow.png",
    --                             priority = "high",
    --                             width = 260,
    --                             height = 162,
    --                             frame_count = 8,
    --                             line_length = 4,
    --                             draw_as_shadow = true,
    --                             shift = util.by_pixel(28, 4),
    --                             scale = 0.5
    --                         }
    --                 }
    --             }
    --     }
    --     airFilter.idle_animation =  airFilter.animation
    --     airFilter.always_draw_idle_animation = true
    --     airFilter.fluid_boxes = {
    --         {
    --             production_type = "input",
    --             pipe_picture = assembler3pipepictures(),
    --             pipe_covers = pipecoverspictures(),
    --             base_area = 10,
    --             base_level = -1,
    --             pipe_connections = {
    --                 { type="input", position = {-1, -2} }
    --             },
    --             secondary_draw_orders = { north = -1 }
    --         },
    --         {
    --             production_type = "input",
    --             pipe_picture = assembler3pipepictures(),
    --             pipe_covers = pipecoverspictures(),
    --             base_area = 10,
    --             base_level = -1,
    --             pipe_connections = {
    --                 { type="input", position = {1, -2} }
    --             },
    --             secondary_draw_orders = { north = -1 }
    --         },
    --         {
    --             production_type = "output",
    --             pipe_picture = assembler3pipepictures(),
    --             pipe_covers = pipecoverspictures(),
    --             base_area = 1,
    --             base_level = 1,
    --             pipe_connections = {
    --                 { type="output", position = {-1, 2} }
    --             },
    --             secondary_draw_orders = { north = -1 }
    --         },
    --         {
    --             production_type = "output",
    --             pipe_picture = assembler3pipepictures(),
    --             pipe_covers = pipecoverspictures(),
    --             base_area = 1,
    --             base_level = 1,
    --             pipe_connections = {
    --                 { type="output", position = {1, 2} }
    --             },
    --             secondary_draw_orders = { north = -1 }
    --         },
    --         off_when_no_fluid_recipe = false
    --     }

    --     airFilter.fluid_boxes[2].pipe_picture.east = {
    --         filename = "__RampantArsenal__/graphics/entities/hr-assembling-machine-3-pipe-E.png",
    --         priority = "extra-high",
    --         width = 42,
    --         height = 76,
    --         shift = util.by_pixel(-24.5, 1),
    --         hr_version =
    --             {
    --                 filename = "__RampantArsenal__/graphics/entities/hr-assembling-machine-3-pipe-E.png",
    --                 priority = "extra-high",
    --                 width = 42,
    --                 height = 76,
    --                 shift = util.by_pixel(-24.5, 1),
    --                 scale = 0.5
    --             }
    --     }
    --     airFilter.fluid_boxes[2].pipe_picture.west = {
    --         filename = "__RampantArsenal__/graphics/entities/hr-assembling-machine-3-pipe-W.png",
    --         priority = "extra-high",
    --         width = 39,
    --         height = 73,
    --         shift = util.by_pixel(25.75, 1.25),
    --         hr_version =
    --             {
    --                 filename = "__RampantArsenal__/graphics/entities/hr-assembling-machine-3-pipe-W.png",
    --                 priority = "extra-high",
    --                 width = 39,
    --                 height = 73,
    --                 shift = util.by_pixel(25.75, 1.25),
    --                 scale = 0.5
    --             }
    --     }


    --     local airFilter2 = table.deepcopy(airFilter)
    --     airFilter2.name = "air-filter-2-rampant-arsenal"
    --     airFilter2.fixed_recipe = "air-filter-pollution-rampant-arsenal"
    --     airFilter2.crafting_categories = { "air-filter-rampant-arsenal" }
    --     airFilter2.minable = {mining_time=2,result="air-filter-2-rampant-arsenal"}
    --     airFilter2.next_upgrade = nil
    --     airFilter2.energy_usage = "750KW"
    --     airFilter2.energy_source.drain = "500KW"
    --     airFilter2.match_speed_to_activity = true
    --     airFilter2.match_volume_to_activity = true
    --     airFilter2.crafting_speed = 1
    --     airFilter2.fast_replaceable_group = nil
    --     airFilter2.animation = {
    --         layers =
    --             {
    --                 {
    --                     filename = "__RampantArsenal__/graphics/entities/hr-air-filter.png",
    --                     priority = "high",
    --                     width = 275,
    --                     height = 210,
    --                     frame_count = 8,
    --                     line_length = 4,
    --                     shift = {-0.75, -0.4},
    --                     scale = 1,
    --                     tint = { r=0.8,g=0.8,b=0.9,a=1 },
    --                     hr_version =
    --                         {
    --                             filename = "__RampantArsenal__/graphics/entities/hr-air-filter.png",
    --                             priority = "high",
    --                             width = 275,
    --                             height = 210,
    --                             frame_count = 8,
    --                             line_length = 4,
    --                             tint = { r=0.8,g=0.8,b=0.9,a=1 },
    --                             shift = {-0.75, -0.4},
    --                             scale = 1
    --                         }
    --                 },
    --                 {
    --                     filename = "__RampantArsenal__/graphics/entities/hr-air-filter-shadow.png",
    --                     priority = "high",
    --                     width = 260,
    --                     height = 162,
    --                     frame_count = 8,
    --                     line_length = 4,
    --                     draw_as_shadow = true,
    --                     shift = util.by_pixel(28, 4),
    --                     scale = 1.9,
    --                     hr_version =
    --                         {
    --                             filename = "__RampantArsenal__/graphics/entities/hr-air-filter-shadow.png",
    --                             priority = "high",
    --                             width = 260,
    --                             height = 162,
    --                             frame_count = 8,
    --                             line_length = 4,
    --                             draw_as_shadow = true,
    --                             shift = util.by_pixel(28, 4),
    --                             scale = 0.95
    --                         }
    --                 }
    --             }
    --     }

    --     airFilter2.collision_box[1][1] = airFilter2.collision_box[1][1] * 2.05
    --     airFilter2.collision_box[1][2] = airFilter2.collision_box[1][2] * 2.05
    --     airFilter2.collision_box[2][1] = airFilter2.collision_box[2][1] * 2.05
    --     airFilter2.collision_box[2][2] = airFilter2.collision_box[2][2] * 2.05

    --     airFilter2.drawing_box = nil
    --     airFilter2.selection_box[1][1] = airFilter2.selection_box[1][1] * 1.66
    --     airFilter2.selection_box[1][2] = airFilter2.selection_box[1][2] * 1.66
    --     airFilter2.selection_box[2][1] = airFilter2.selection_box[2][1] * 1.66
    --     airFilter2.selection_box[2][2] = airFilter2.selection_box[2][2] * 1.66
    --     airFilter2.fluid_boxes = {
    --         {
    --             production_type = "input",
    --             pipe_picture = assembler3pipepictures(),
    --             pipe_covers = pipecoverspictures(),
    --             base_area = 10,
    --             base_level = -1,
    --             pipe_connections = {
    --                 { type="input", position = {1, -3} }
    --             },
    --             secondary_draw_orders = { north = -1 }
    --         },
    --         {
    --             production_type = "input",
    --             pipe_picture = assembler3pipepictures(),
    --             pipe_covers = pipecoverspictures(),
    --             base_area = 10,
    --             base_level = -1,
    --             pipe_connections = {
    --                 { type="input", position = {-1, -3} }
    --             },
    --             secondary_draw_orders = { north = -1 }
    --         },
    --         {
    --             production_type = "output",
    --             pipe_picture = assembler3pipepictures(),
    --             pipe_covers = pipecoverspictures(),
    --             base_area = 2,
    --             base_level = 1,
    --             pipe_connections = {
    --                 { type="output", position = {1, 3} }
    --             },
    --             secondary_draw_orders = { north = -1 }
    --         },
    --         {
    --             production_type = "output",
    --             pipe_picture = assembler3pipepictures(),
    --             pipe_covers = pipecoverspictures(),
    --             base_area = 2,
    --             base_level = 1,
    --             pipe_connections = {
    --                 { type="output", position = {-1, 3} }
    --             },
    --             secondary_draw_orders = { north = -1 }
    --         },
    --         off_when_no_fluid_recipe = false
    --     }

    --     airFilter2.fluid_boxes[2].pipe_picture.east = {
    --         filename = "__RampantArsenal__/graphics/entities/hr-assembling-machine-3-pipe-E.png",
    --         priority = "extra-high",
    --         width = 42,
    --         height = 76,
    --         shift = util.by_pixel(-24.5, 1),
    --         hr_version =
    --             {
    --                 filename = "__RampantArsenal__/graphics/entities/hr-assembling-machine-3-pipe-E.png",
    --                 priority = "extra-high",
    --                 width = 42,
    --                 height = 76,
    --                 shift = util.by_pixel(-24.5, 1),
    --                 scale = 0.5
    --             }
    --     }
    --     airFilter2.fluid_boxes[1].pipe_picture.east = airFilter2.fluid_boxes[2].pipe_picture.east
    --     airFilter2.fluid_boxes[3].pipe_picture.east = airFilter2.fluid_boxes[2].pipe_picture.east
    --     airFilter2.fluid_boxes[4].pipe_picture.east = airFilter2.fluid_boxes[2].pipe_picture.east
    --     airFilter2.fluid_boxes[2].pipe_picture.west = {
    --         filename = "__RampantArsenal__/graphics/entities/hr-assembling-machine-3-pipe-W.png",
    --         priority = "extra-high",
    --         width = 39,
    --         height = 73,
    --         shift = util.by_pixel(25.75, 1.25),
    --         hr_version =
    --             {
    --                 filename = "__RampantArsenal__/graphics/entities/hr-assembling-machine-3-pipe-W.png",
    --                 priority = "extra-high",
    --                 width = 39,
    --                 height = 73,
    --                 shift = util.by_pixel(25.75, 1.25),
    --                 scale = 0.5
    --             }
    --     }
    --     airFilter2.fluid_boxes[1].pipe_picture.west = airFilter2.fluid_boxes[2].pipe_picture.west
    --     airFilter2.fluid_boxes[3].pipe_picture.west = airFilter2.fluid_boxes[2].pipe_picture.west
    --     airFilter2.fluid_boxes[4].pipe_picture.west = airFilter2.fluid_boxes[2].pipe_picture.west

    --     airFilter2.idle_animation =  airFilter2.animation


    --     local recipe = table.deepcopy(data.raw["recipe"]["assembling-machine-1"])
    --     recipe.name = "air-filter-rampant-arsenal"
    --     recipe.icon = "__RampantArsenal__/graphics/icons/air-filter.png"
    --     recipe.icon_size = 64
    --     recipe.icon_mipmaps = 1
    --     recipe.ingredients = {
    --         {"steel-plate", 20},
    --         {"electronic-circuit", 30},
    --         {"storage-tank", 16}
    --     }
    --     recipe.energy_required = 30
    --     recipe.hidden = false
    --     recipe.enabled = true
    --     recipe.result = "air-filter-rampant-arsenal"

    --     local recipe2 = table.deepcopy(data.raw["recipe"]["assembling-machine-1"])
    --     recipe2.name = "air-filter-2-rampant-arsenal"
    --     recipe2.icon = nil
    --     recipe2.icons = {
    --         {icon = "__RampantArsenal__/graphics/icons/air-filter.png", tint = { r=0.7,g=0.7,b=0.9,a=1 }}
    --     }
    --     recipe2.icon_size = 64
    --     recipe2.icon_mipmaps = 1
    --     recipe2.ingredients = {
    --         {"steel-plate", 20},
    --         {"electronic-circuit", 30},
    --         {"storage-tank", 16}
    --     }
    --     recipe2.energy_required = 30
    --     recipe2.hidden = false
    --     recipe2.enabled = true
    --     recipe2.result = "air-filter-2-rampant-arsenal"


    --     local item = table.deepcopy(data.raw["item"]["assembling-machine-2"])
    --     item.name = "air-filter-rampant-arsenal"
    --     item.icon = nil
    --     item.icons = {
    --         {icon = "__RampantArsenal__/graphics/icons/air-filter.png"}
    --     }
    --     item.place_result = "air-filter-rampant-arsenal"
    --     item.order = "c[zassembling-machine-3]"

    --     local item2 = table.deepcopy(data.raw["item"]["assembling-machine-2"])
    --     item2.name = "air-filter-2-rampant-arsenal"
    --     item2.icon = nil
    --     item2.icons = {
    --         {icon = "__RampantArsenal__/graphics/icons/air-filter.png", tint = { r=0.7,g=0.7,b=0.9,a=1 }}
    --     }
    --     item2.place_result = "air-filter-2-rampant-arsenal"
    --     item2.order = "c[zzassembling-machine-3]"

    --     local recipePollution = table.deepcopy(data.raw["recipe"]["assembling-machine-2"])
    --     recipePollution.name = "air-filter-pollution-rampant-arsenal"
    --     recipePollution.category = "air-filter-rampant-arsenal"
    --     recipePollution.subgroup = "raw-material"
    --     recipePollution.normal.ingredients = {
    --         {type="fluid",name="pollution-fluid-rampant-arsenal", amount=20},
    --         {type="fluid",name="water", amount=60}
    --     }
    --     recipePollution.normal.energy_required = 1
    --     recipePollution.normal.hide_from_player_crafting = true
    --     recipePollution.normal.hidden = false
    --     recipePollution.normal.enabled = true
    --     recipePollution.normal.emissions_multiplier = -3
    --     recipePollution.normal.allow_as_intermediate = false
    --     recipePollution.normal.always_show_products = true
    --     recipePollution.normal.show_amount_in_title = false
    --     recipePollution.normal.result = nil
    --     recipePollution.normal.main_product = "compressed-pollution-fluid-rampant-arsenal"
    --     recipePollution.normal.results = {
    --         {type="fluid", name="compressed-pollution-fluid-rampant-arsenal", amount=40},
    --         {type="fluid", name="water", amount=20}
    --     }

    --     addFluid({
    --             name="pollution",
    --             icon="__RampantArsenal__/graphics/icons/pollution.png",
    --             iconSize = 64,
    --             iconMipmaps = 4,
    --             disableAutoBarrel = true
    --     })

    --     addFluid({
    --             name="compressed-pollution",
    --             iconSize = 64,
    --             iconMipmaps = 4
    --     })

    --     data:extend({
    --             {
    --                 type="recipe-category",
    --                 name="air-filter-rampant-arsenal"
    --             },
    --             recipePollution,
    --             airFilter,
    --             airFilter2,
    --             recipe,
    --             recipe2,
    --             item,
    --             item2
    --     })
    -- end
end

return buildings
