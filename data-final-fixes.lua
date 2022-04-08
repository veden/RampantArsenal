if mods["Krastorio2"] then
    data.raw["car"]["nuclear-tank-vehicle-rampant-arsenal"].burner = {
        fuel_category = "nuclear",
        effectivity = 0.9,
        emissions_per_minute = 30,
        fuel_inventory_size = 2,
        burnt_inventory_size = 2,
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
    }

    data.raw["car"]["nuclear-car-vehicle-rampant-arsenal"].burner = {
        fuel_category = "nuclear",
        effectivity = 1,
        emissions_per_minute = 20,
        fuel_inventory_size = 1,
        burnt_inventory_size = 1,
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
    }
end
