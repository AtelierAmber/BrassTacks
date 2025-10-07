local rm = require("__pf-functions__/recipe-manipulation")
local misc = require("__pf-functions__/misc")

local gearbox_ingredients = {
    {type="item", name="iron-gear-wheel", amount=10},
    {type="item", name="galvanized-steel-plate", amount=1},
    {type="item", name="iron-stick", amount=8}
}
if misc.difficulty == 3 then
    gearbox_ingredients = {
        {type="item", name="iron-gear-wheel", amount=5},
        {type="item", name="malleable-logarithmic-casing", amount=1},
        {type="item", name="iron-stick", amount=4}
    }
end

data:extend({
    {
        type = "recipe",
        name = "zinc-plate",
        category = "smelting",
        ingredients = {
            {type="item", name="zinc-ore", amount=1}
        },
        results = {
            {type="item", name="zinc-plate", amount=1}
        },
        energy_required = 3.2,
        allow_productivity = true,
        enabled = true
    },
    {
        type = "recipe",
        name = "brass-precursor",
        category = "crafting",
        ingredients = {
            {type="item", name="zinc-plate", amount=1},
            {type="item", name="copper-plate", amount=1}
        },
        results = {
            {type="item", name="brass-precursor", amount=2}
        },
        energy_required = 0.5,
        enabled = true
    },
    {
        type = "recipe",
        name = "brass-plate",
        category = "smelting",
        ingredients = {
            {type="item", name="brass-precursor", amount=1}
        },
        results = {
            {type="item", name="brass-plate", amount=1}
        },
        energy_required = 1.6,
        allow_productivity = true,
        auto_recycle = false,
        enabled = true
    },
    {
        type = "recipe",
        name = "galvanized-steel-plate",
        category = misc.difficulty == 3 and "electroplating" or "advanced-crafting",
        ingredients = misc.difficulty == 3 and {
            {type="item", name="steel-plate", amount=1},
            {type="item", name="zinc-plate", amount=1},
            {type="fluid", name="water", amount=50}
        } or {
            {type="item", name="steel-plate", amount=1},
            {type="item", name="zinc-plate", amount=1}
        },
        results = misc.difficulty == 3 and {
            {type="fluid", name="depleted-zinc-salts", amount=10},
            {type="item", name="galvanized-steel-plate", amount=1, ignored_by_productivity=mods["quality"] and 1 or 0}
        } or {
            {type="item", name="galvanized-steel-plate", amount=1, ignored_by_productivity=mods["quality"] and 1 or 0}
        },
        main_product = "galvanized-steel-plate",
        energy_required = misc.difficulty == 3 and 2 or 3,
        allow_productivity = true,
        auto_recycle = false,
        enabled = false
    },
    {
        type = "recipe",
        name = "brass-balls",
        category = "advanced-crafting",
        ingredients = {
            {type="item", name="brass-plate", amount=1}
        },
        results = {
            {type="item", name="brass-balls", amount=2}
        },
        energy_required = 0.5,
        lasermill_vanilla = {helium = -1},
        lasermill_dlc = {helium = -1},
        allow_productivity = true,
        enabled = false
    },
    {
        type = "recipe",
        name = "bearing",
        category = "crafting-with-fluid",
        ingredients = {
            {type="item", name="brass-plate", amount=2},
            {type="item", name="brass-balls", amount=4},
            {type="fluid", name="lubricant", amount=5}
        },
        results = {
            {type="item", name="bearing", amount=1}
        },
        energy_required = 4,
        lasermill_dlc = {helium = -1},
        allow_productivity = true,
        enabled = false
    },
})

if tune_up_data then
  if not mods["space-age"] then
    tune_up_data.recipes["zinc-ore"] = {
        category = "purification",
        count = 5,
        energy_required = 1,
        ingredients = {{{"zinc-ore", 5}, {"stone", 1}, {"sulfuric-acid", 25}}}
    }
  end

  tune_up_data.recipes["zinc-bacteria"] = {
    category = "purification",
    count = 4,
    energy_required = 2,
    result_is_always_fresh = true,
    ingredients = {{{"zinc-bacteria", 1}, {"philosophers-hormone", 1}, {"growth-serum", 5}}, {{"zinc-bacteria", 1}, {"nutrients", 8}}}
  }

  tune_up_data.recipes["sphalerite"] = {
      category = "purification",
      count = 5,
      energy_required = 1,
      ingredients = {{{"sphalerite", 5}, {"sulfur", 1}, {"sulfuric-acid", 25}}}
  }

  tune_up_data.recipes["zinc-plate"] = {
    category = "purification",
    count = 10,
    energy_required = 10,
    ingredients = {{{"zinc-plate", 5}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"zinc-ore", 5}}}
  }

  tune_up_data.recipes["brass-plate"] = {
    category = "purification",
    count = 10,
    energy_required = 10,
    ingredients = {{{"brass-plate", 5}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"zinc-ore", 2}, {"copper-ore", 2}}}
  }

  tune_up_data.recipes["galvanized-steel-plate"] = {
    category = "purification",
    count = 1,
    energy_required = 4,
    ingredients = {{{"zinc-plate", 2}}}
  }

  tune_up_data.recipes["galvanized-rod"] = {
    category = "purification",
    count = 10,
    energy_required = 4,
    ingredients = {{{"zinc-plate", 2}}}
  }

  tune_up_data.recipes["galvanized-panel"] = {
    category = "purification",
    count = 5,
    energy_required = 4,
    ingredients = {{{"zinc-plate", 2}}}
  }

  tune_up_data.recipes["galvanized-tubing"] = {
    category = "purification",
    count = 5,
    energy_required = 4,
    ingredients = {{{"zinc-plate", 2}}}
  }

  tune_up_data.recipes["bearing"] = {
    category = "tuning-up",
    count = 3,
    energy_required = 10,
    ingredients = {{{"steel-plate", 1}, {"brass-balls", 10}}}
  }

  tune_up_data.recipes["brass-balls"] = {
    category = "tuning-up",
    count = 6,
    energy_required = 3,
    ingredients = {{{"brass-balls", 3}, {"lubricant", 10}}}
  }

  tune_up_data.recipes["pipe-flange"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 2,
    ingredients = {{{"galvanized-panel", 1}, {"water", 10}}}
  }

  tune_up_data.recipes["linkages"] = {
    category = "tuning-up",
    count = 3,
    energy_required = 2,
    ingredients = {{{"spring", 2}}, {{"brass-plate", 2}}}
  }

  tune_up_data.recipes["flywheel"] = {
    category = "tuning-up",
    count = 50,
    energy_required = 100,
    ingredients = {{{"zinc-plate", 75}}, {{"uranium-238", 1}}}
  }

  tune_up_data.recipes["hardened-hull"] = {
    category = "tuning-up",
    count = mods["space-age"] and 5 or 1,
    energy_required = mods["space-age"] and 10 or 2,
    ingredients = {{{"invar-plate", 5}, {"tungsten-plate", 1}}, {{"galvanized-panel", 15}, {"tungsten-plate", 1}}, {{"galvanized-panel", 5}}}
  }

  tune_up_data.recipes["fast-gearbox"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 5,
    ingredients = {{{"bearing", 2}, {"lubricant", 10}}}
  }

  tune_up_data.recipes["express-gearbox"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 5,
    ingredients = {{{"fast-gearbox", 1}, {"electric-motor", 2}, {"lubricant", 10}}, {{"fast-gearbox", 1}, {"electronic-circuit", 2}, {"lubricant", 10}}}
  }

  tune_up_data.recipes["gyro"] = {
    category = "tuning-up",
    count = 2,
    energy_required = 10,
    ingredients = {{{"laser", 1}}, {{"advanced-circuit", 3}}}
  }

  tune_up_data.recipes["complex-joint"] = {
    category = "tuning-up",
    count = 3,
    energy_required = 10,
    ingredients = {{{"differential-girdlespring", 1}}, {{"motorized-arm", 1}, {"linkages", 2}}}
  }

  tune_up_data.recipes["electroplating-machine"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 3,
    ingredients = {{{"advanced-circuit", 2}, {"tinned-cable", 30}}, {{"advanced-circuit", 5}}}
  }

  tune_up_data.recipes["advanced-electroplating-machine"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 3,
    ingredients = {{{"electroplating-machine", 1}, {"holmium-plate", 15}}, {{"electroplating-machine", 1}, {"processing-unit", 1}}}
  }

  tune_up_data.recipes["loadbearing-lattice"] = {
    category = "tuning-up",
    count = 10,
    energy_required = 30,
    ingredients = {{{"low-density-structure", 1}}}
  }

  tune_up_data.recipes["malleable-logarithmic-casing"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 1,
    ingredients = {{{"plastic-bar", 1}}}
  }

  tune_up_data.recipes["spurving-bearing"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 5,
    ingredients = {{{"tungsten-plate", 2}, {"brass-plate", 3}}}
  }
end

--assemblers are abstract, but you can't electroplate with a laser.
if misc.difficulty ~= 3 then
    misc.AddLaserMillData("galvanized-steel-plate", {helium=-1}, {helium=-1})
end

if mods["quality"] then
    if misc.difficulty == 3 then
        data.raw.recipe["galvanized-steel-plate"].localised_description = {"recipe-description.hint-prodmod-only-salt"}

        --rm.AddProduct("galvanized-steel-plate", {type="item", name="galvanized-steel-plate", amount=0, ignored_by_productivity=1})
    else
        data.raw.recipe["galvanized-steel-plate"].allow_productivity = false
    end
    
    data.raw.item["galvanized-steel-plate"].localised_description = {"recipe-description.hint-nonstandard-recycling"}


    data:extend({
        {
            type = "recipe",
            name = "custom-galvanized-steel-plate-recycling",
            localised_name = {"recipe-name.recycling", {"item-name.galvanized-steel-plate"}},
            icons = {
                      {
                        icon = "__quality__/graphics/icons/recycling.png",
                        icon_size = 64
                      },
                      {
                        icon = "__BrassTacks__/graphics/classic/icons/galvanized-steel-plate.png",
                        icon_size = 64
                      },
                      {
                        icon = "__quality__/graphics/icons/recycling-top.png",
                        icon_size = 64
                      }
            },
            category = "recycling",
            ingredients = {
                {type="item", name="galvanized-steel-plate", amount=1}
            },
            results = {
                {type="item", name="steel-plate", amount=1, probability = 0.75},
                {type="item", name="zinc-ore", amount=1, probability = 0.1}
            },
            bespoke = "galvanized-steel-plate",
            energy_required = 1/16,
            allow_productivity = false,
            allow_quality = false, -- not lossy enough to be balanced against other recycling recipes
            enabled = true,
            hidden = true,
            allow_decomposition = false,
            unlock_results = false
        }
    })
else
end

if mods["space-age"] then
    data.raw.item["brass-plate"].localised_description = {"recipe-description.hint-nonstandard-recycling"}
    data.raw.item["zinc-plate"].localised_description = {"recipe-description.hint-nonstandard-recycling"}

    data:extend({
        {
            type = "recipe",
            name = "custom-brass-plate-recycling",
            localised_name = {"recipe-name.recycling", {"item-name.brass-plate"}},
            icons = {
                      {
                        icon = "__quality__/graphics/icons/recycling.png",
                        icon_size = 64
                      },
                      {
                        icon = "__BrassTacks__/graphics/classic/icons/brass-plate.png",
                        icon_size = 64
                      },
                      {
                        icon = "__quality__/graphics/icons/recycling-top.png",
                        icon_size = 64
                      }
            },
            category = "recycling",
            ingredients = {
                {type="item", name="brass-plate", amount=1}
            },
            results = {
                {type="item", name="copper-ore", amount=1, probability = 0.03},
                {type="item", name="zinc-ore", amount=1, probability = 0.03}
            },
            bespoke = "brass-plate",
            energy_required = 3.2/16,
            allow_productivity = false,
            enabled = true,
            hidden = true,
            allow_decomposition = false,
            unlock_results = false
        },
        {
            type = "recipe",
            name = "custom-zinc-plate-recycling",
            localised_name = {"recipe-name.recycling", {"item-name.zinc-plate"}},
            icons = {
                      {
                        icon = "__quality__/graphics/icons/recycling.png",
                        icon_size = 64
                      },
                      {
                        icon = "__BrassTacks__/graphics/classic/icons/zinc-plate.png",
                        icon_size = 64
                      },
                      {
                        icon = "__quality__/graphics/icons/recycling-top.png",
                        icon_size = 64
                      }
            },
            category = "recycling",
            ingredients = {
                {type="item", name="zinc-plate", amount=1}
            },
            results = {
                {type="item", name="zinc-ore", amount=1, probability = 0.06}
            },
            bespoke = "zinc-plate",
            energy_required = 3.2/16,
            allow_productivity = false,
            enabled = true,
            hidden = true,
            allow_decomposition = false,
            unlock_results = false
        },
        {
            type = "recipe",
            name = "brassteroid-crushing",
            icon = "__pf-sa-compat__/graphics/icons/brassteroid-crushing.png",
            icon_size = 64,
            subgroup = "space-crushing",
            order = "b-a-d",
            category = "crushing",
            ingredients = {
                {type="item", name="brass-asteroid-chunk", amount=1},
            },
            results = {
                {type="item", name="brass-precursor", amount=10},
                {type="item", name="brass-asteroid-chunk", amount=1, probability=0.2}
            },
            energy_required = 2,
            allow_productivity = true,
            allow_decomposition = false,
            enabled = false
        },
        {
            type = "recipe",
            name = "advanced-brassteroid-crushing",
            icon = "__pf-sa-compat__/graphics/icons/advanced-brassteroid-crushing.png",
            icon_size = 64,
            subgroup = "space-crushing",
            order = "fa",
            category = "crushing",
            ingredients = {
                {type="item", name="brass-asteroid-chunk", amount=1},
            },
            results = (mods["IfNickel"] and misc.difficulty == 3) and {
                {type="item", name="malachite", amount=5},
                {type="item", name="sphalerite", amount=2},
                {type="item", name="brass-asteroid-chunk", amount=1, probability=0.05}
            } or {
                {type="item", name="copper-ore", amount=3},
                {type="item", name="zinc-ore", amount=2},
                {type="item", name="brass-asteroid-chunk", amount=1, probability=0.05}
            },
            energy_required = 5,
            allow_productivity = true,
            allow_decomposition = false,
            enabled = false
        },
        {
            type = "recipe",
            name = "brassteroid-reprocessing",
            icon = "__pf-sa-compat__/graphics/icons/brassteroid-reprocessing.png",
            icon_size = 64,
            subgroup = "space-crushing",
            order = "b-b-d",
            category = "crushing",
            ingredients = {
                {type="item", name="brass-asteroid-chunk", amount=1},
            },
            results = {
                --to be computed in pf-sa-compat
            },
            energy_required = 2,
            allow_productivity = true,
            allow_decomposition = false,
            enabled = false
        },
        {
            type = "recipe",
            name = "molten-zinc-from-sphalerite",
            icon = "__pf-sa-compat__/graphics/icons/molten-zinc-from-sphalerite.png",
            icon_size = 64,
            subgroup = "vulcanus-processes",
            order = "a[melting]-aa",
            category = "metallurgy",
            ingredients = {
                {type="item", name="sphalerite", amount=50},
                {type="item", name="calcite", amount=1}
            },
            results = {
                {type="fluid", name="molten-zinc", amount=450, fluidbox_multiplier=10},
                {type="fluid", name="molten-iron", amount=50, fluidbox_multiplier=10},
                {type="item", name="sulfur", amount=10}
            },
            energy_required = 32,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "molten-zinc",
            icon = "__pf-sa-compat__/graphics/icons/zinc-ore-melting.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "vulcanus-processes",
            order = "a[melting]-d",
            category = "metallurgy",
            ingredients = {
                {type="item", name="zinc-ore", amount=50},
                {type="item", name="calcite", amount=1}
            },
            results = {
                {type="fluid", name="molten-zinc", amount=500, fluidbox_multiplier=10}
            },
            energy_required = 16,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "molten-zinc-from-lava",
            icon = "__pf-sa-compat__/graphics/icons/molten-zinc-from-lava.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "vulcanus-processes",
            order = "a[melting]-a[lava-c]",
            category = "metallurgy",
            ingredients = {
                {type="fluid", name="lava", amount=500, fluidbox_multiplier=10},
                {type="item", name="calcite", amount=1}
            },
            results = {
                {type="fluid", name="molten-zinc", amount=250, fluidbox_multiplier=10},
                {type="item", name="stone", amount=15},
            },
            energy_required = 16,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "casting-zinc",
            icon = "__pf-sa-compat__/graphics/icons/casting-zinc.png",
            icon_size = 64,
            subgroup = "vulcanus-processes",
            order = "b[casting]-ba",
            category = "metallurgy",
            ingredients = {
                {type="fluid", name="molten-zinc", amount=20, fluidbox_multiplier=10},
            },
            results = {
                {type="item", name="zinc-plate", amount=2}
            },
            energy_required = 3.2,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "casting-brass",
            icon = "__pf-sa-compat__/graphics/icons/casting-brass.png",
            icon_size = 64,
            subgroup = "vulcanus-processes",
            order = "b[casting]-bb",
            category = "metallurgy",
            ingredients = {
                {type="fluid", name="molten-zinc", amount=6, fluidbox_multiplier=10},
                {type="fluid", name="molten-copper", amount=6, fluidbox_multiplier=10},
            },
            results = {
                {type="item", name="brass-plate", amount=2}
            },
            energy_required = 3.2,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "hot-dip-galvanized-steel",
            icon = "__pf-sa-compat__/graphics/icons/hot-dip-galvanized-steel.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "vulcanus-processes",
            order = "b[casting]-ca",
            category = "metallurgy",
            ingredients = {
                {type="fluid", name="molten-zinc", amount=10, fluidbox_multiplier=10},
                {type="item", name="steel-plate", amount=1},
            },
            results = {
                {type="item", name="galvanized-steel-plate", amount=1}
            },
            localised_description = {"recipe-description.hint-no-foundry-productivity"},
            maximum_productivity = 0,
            energy_required = 2,
            enabled = false
        },
        {
            type = "recipe",
            name = "zinc-bacteria",
            icon = "__pf-sa-compat__/graphics/icons/zinc-bacteria.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "agriculture-processes",
            order = "e[bacteria]-a[bacteria]-c",
            category = "organic",
            ingredients = {
                {type="item", name="copper-bacteria", amount=3},
                {type="item", name="philosophers-hormone", amount=1},
            },
            results = {
                {type="item", name="zinc-bacteria", amount=3}
            },
            energy_required = 2,
            allow_productivity = true,
            result_is_always_fresh = true,
            enabled = false,
            crafting_machine_tint =
            {
              primary = {1, 1, 1, 1},
              secondary = {0.8, 0.8, 0.8, 1},
            }

        }
    })

    if mods["Age-of-Production"] then
        data:extend({
            {
                type = "recipe",
                name = "ammoniacal-zinc-synthesis",
                icons = {
                    {
                        icon = "__space-age__/graphics/icons/fluid/ammoniacal-solution.png",
                        icon_size = 64
                    },
                    {
                        icon = "__BrassTacks__/graphics/icons/zinc-ore.png",
                        icon_size = 64,
                        scale = 0.25,
                        shift = {0, 8}
                    }
                },
                subgroup = "raw-material",
                order = "n",
                category = "synthesis",
                ingredients = {
                    {type="item", name="carbon", amount=5},
                    {type="fluid", name="ammoniacal-solution", amount=100},
                    {type="fluid", name="petroleum-gas", amount=25},
                },
                results = {
                    {type="item", name="zinc-ore", amount=5}
                },
                energy_required = 15,
                enabled = false
            }
        })
    end
end

if misc.difficulty == 1 then
    return
end

data:extend({
    {
        type = "recipe",
        name = "pipe-flange",
        category = mods["maraxsis"] and "maraxsis-hydro-plant-or-assembling" or "crafting",
        ingredients = {
            {type="item", name="brass-plate", amount=2}
        },
        results = {
            {type="item", name="pipe-flange", amount=1}
        },
        energy_required = 2,
        lasermill_vanilla = {helium = -1},
        lasermill_dlc = {helium = -1},
        allow_productivity = true,
        enabled = false
    },
    {
        type = "recipe",
        name = "flywheel",
        category = "crafting",
        ingredients = {
            {type="item", name="iron-gear-wheel", amount=1},
            {type="item", name="zinc-plate", amount=3}
        },
        results = {
            {type="item", name="flywheel", amount=1}
        },
        energy_required = 1,
        lasermill_vanilla = {helium = -1},
        lasermill_dlc = {helium = -1},
        allow_productivity = true,
        enabled = false
    },
    {
        type = "recipe",
        name = "hardened-hull",
        category = mods["space-age"] and "pressing" or "crafting",
        ingredients = {
            {type="item", name="galvanized-steel-plate", amount=1},
            {type="item", name="brass-plate", amount=3},
            {type="item", name="iron-plate", amount=1},
        },
        results = {
            {type="item", name="hardened-hull", amount=1}
        },
        lasermill_vanilla = {helium = -1},
        lasermill_dlc = {helium = -1},
        energy_required = 2,
        allow_productivity = true,
        enabled = false
    },
    {
        type = "recipe",
        name = "linkages",
        category = "crafting",
        ingredients = {
            {type="item", name="brass-plate", amount=2},
            {type="item", name="iron-stick", amount=3},
        },
        results = {
            {type="item", name="linkages", amount=2}
        },
        energy_required = 1,
        lasermill_dlc = {helium = -1},
        allow_productivity = true,
        enabled = true
    },
    {
        type = "recipe",
        name = "fast-gearbox",
        category = "crafting",
        ingredients = gearbox_ingredients,
        results = {
            {type="item", name="fast-gearbox", amount=misc.difficulty==2 and 2 or 1}
        },
        energy_required = misc.difficulty==2 and 3 or 1.5,
        lasermill_dlc = {helium = -1},
        allow_productivity = false,
        enabled = false
    },
    {
        type = "recipe",
        name = "express-gearbox",
        category = "crafting-with-fluid",
        ingredients = {
            {type="fluid", name="lubricant", amount=15},
            {type="item", name="fast-gearbox", amount=1},
            {type="item", name="iron-gear-wheel", amount=5},
            {type="item", name="bearing", amount=2},
            {type="item", name="flywheel", amount=1}
        },
        results = {
            {type="item", name="express-gearbox", amount=1}
        },
        energy_required = 3,
        lasermill_dlc = {helium = -1},
        allow_productivity = false,
        enabled = false
    },
    {
        type = "recipe",
        name = "complex-joint",
        category = "crafting-with-fluid",
        ingredients = {
            {type="fluid", name="lubricant", amount=5},
            {type="item", name="linkages", amount=8},
            {type="item", name="bearing", amount=1},
            {type="item", name="plastic-bar", amount=4}
        },
        results = {
            {type="item", name="complex-joint", amount=1}
        },
        energy_required = 4,
        lasermill_dlc = {helium = -1},
        allow_productivity = true,
        enabled = false
    },
    {
        type = "recipe",
        name = "gyro",
        category = "crafting",
        ingredients = {
            {type="item", name="flywheel", amount=1},
            {type="item", name="bearing", amount=2},
            {type="item", name="iron-gear-wheel", amount=2},
            {type="item", name="electronic-circuit", amount=2}
        },
        results = {
            {type="item", name="gyro", amount=1}
        },
        energy_required = 4,
        lasermill_dlc = {helium = -1},
        allow_productivity = true,
        enabled = false
    }
})

if mods["space-age"] then
    data:extend({
        {
            type = "recipe",
            name = "casting-flywheel",
            icon = "__pf-sa-compat__/graphics/icons/casting-flywheel.png",
            icon_size = 64,
            subgroup = "vulcanus-processes",
            order = "b[casting]-da",
            category = "metallurgy",
            ingredients = {
                {type="fluid", name="molten-zinc", amount=20},
                {type="item", name="iron-gear-wheel", amount=1},
            },
            results = {
                {type="item", name="flywheel", amount=1}
            },
            energy_required = 1,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "casting-pipe-flange",
            icon = "__pf-sa-compat__/graphics/icons/casting-pipe-flange.png",
            icon_size = 64,
            subgroup = "vulcanus-processes",
            order = "b[casting]-ha",
            category = "metallurgy",
            ingredients = {
                {type="fluid", name="molten-zinc", amount=5},
                {type="fluid", name="molten-copper", amount=5},
            },
            results = {
                {type="item", name="pipe-flange", amount=1}
            },
            energy_required = 2,
            allow_productivity = true,
            enabled = false
        }
    })
end

if misc.difficulty == 2 then
    return
end

data:extend({
    {
        type = "recipe",
        name = "electroplating-machine",
        category = mods["space-age"] and "electronics" or "crafting",
        ingredients = {
            {type="item", name="pipe", amount=10},
            {type="item", name="steel-plate", amount=5},
            {type="item", name="electronic-circuit", amount=5},
            {type="item", name="copper-plate", amount=20},
        },
        results = {
            {type="item", name="electroplating-machine", amount=1}
        },
        energy_required = 1,
        allow_productivity = false,
        enabled = false
    },
    {
        type = "recipe",
        name = "advanced-electroplating-machine",
        category = mods["space-age"] and "electromagnetics" or "crafting",
        ingredients = mods["space-age"] and {
            {type="item", name="electroplating-machine", amount=1},
            {type="fluid", name="electrolyte", amount=50},
            {type="item", name="pump", amount=5},
            {type="item", name="supercapacitor", amount=10},
            {type="item", name="processing-unit", amount=5}
        } or {
            {type="item", name="electroplating-machine", amount=1},
            {type="item", name="pump", amount=5},
            {type="item", name="hardened-hull", amount=5},
            {type="item", name="advanced-circuit", amount=20}
        },
        results = {
            {type="item", name="advanced-electroplating-machine", amount=1}
        },
        energy_required = 1,
        allow_productivity = false,
        enabled = false,
        surface_conditions = mods["space-age"] and {
            {
                property = "magnetic-field",
                min = 99,
                max = 99
            }
        } or nil,
    },
    {
        type = "recipe",
        name = "depleted-zinc-salt-reprocessing",
        category = "electroplating",
        icon = "__BrassTacks__/graphics/classic/icons/depleted-zinc-salts.png",
        icon_size = 64,
        subgroup = "electroplating",
        order = "z",
        ingredients = {
            {type="fluid", name="depleted-zinc-salts", amount=300},
        },
        results = {
            {type="item", name="zinc-ore", amount=1}
        },
        energy_required = 8,
        allow_productivity = (not mods["space-age"]) and true or false,
        --effectively costless compared to prodmods in the machines doing the galvanizing.
        --also devalues the already-minor upgrade that is the advanced machine
        --too good in space age bc foundries are op
        enabled = false
    },
    {
        type = "recipe",
        name = "galvanized-panel",
        category = "electroplating",
        ingredients = {
            {type="item", name="iron-plate", amount=5},
            {type="item", name="zinc-plate", amount=1},
            {type="fluid", name="water", amount=50},
        },
        results = {
            {type="fluid", name="depleted-zinc-salts", amount=10},
            {type="item", name="galvanized-panel", amount=5, ignored_by_productivity=mods["quality"] and 5 or 0},
        },
        main_product = "galvanized-panel",
        energy_required = 2,
        auto_recycle = false,
        allow_productivity = true,
        enabled = false
    },
    {
        type = "recipe",
        name = "galvanized-rod",
        category = "electroplating",
        ingredients = {
            {type="item", name="iron-stick", amount=5},
            {type="item", name="zinc-plate", amount=1},
            {type="fluid", name="water", amount=50},
        },
        results = {
            {type="fluid", name="depleted-zinc-salts", amount=10},
            {type="item", name="galvanized-rod", amount=5, ignored_by_productivity=mods["quality"] and 5 or 0}
        },
        main_product = "galvanized-rod",
        energy_required = 2,
        auto_recycle = false,
        allow_productivity = true,
        enabled = false
    },
    {
        type = "recipe",
        name = "galvanized-tubing",
        category = "electroplating",
        ingredients = {
            {type="item", name="pipe", amount=5},
            {type="item", name="zinc-plate", amount=1},
            {type="fluid", name="water", amount=50},
        },
        results = {
            {type="fluid", name="depleted-zinc-salts", amount=10},
            {type="item", name="galvanized-tubing", amount=5, ignored_by_productivity=mods["quality"] and 5 or 0}
        },
        main_product = "galvanized-tubing",
        energy_required = 4,
        auto_recycle = false,
        allow_productivity = true,
        enabled = false
    },
    {
        type = "recipe",
        name = "malleable-logarithmic-casing",
        category = "crafting",
        ingredients = {
            {type="item", name="galvanized-panel", amount=2},
            {type="item", name="galvanized-rod", amount=2},
        },
        results = {
            {type="item", name="malleable-logarithmic-casing", amount=1}
        },
        energy_required = 1,
        lasermill_vanilla = {helium = -1},
        lasermill_dlc = {helium = -1},
        allow_productivity = true,
        enabled = false
    },
    {
        type = "recipe",
        name = "loadbearing-lattice",
        category = "crafting",
        ingredients = {
            {type="item", name="galvanized-steel-plate", amount=1},
            {type="item", name="galvanized-panel", amount=1},
            {type="item", name="galvanized-rod", amount=4},
        },
        results = {
            {type="item", name="loadbearing-lattice", amount=1}
        },
        energy_required = 2,
        lasermill_vanilla = {helium = -1},
        lasermill_dlc = {helium = -1},
        allow_productivity = true,
        enabled = false
    }
})

rm.AddIngredient("complex-joint", "galvanized-rod", 8)

if mods["space-age"] then
    data.raw.recipe["hot-dip-galvanized-steel"].subgroup = "electroplating"
    data.raw.recipe["hot-dip-galvanized-steel"].order = d2

    data:extend({
        {
            type = "recipe",
            name = "spurving-bearing",
            category = "metallurgy",
            surface_conditions =
            {
              {
                property = "pressure",
                min = 4000,
                max = 4000
              }
            },
            ingredients = {
                {type="item", name="tungsten-plate", amount=5},
                {type="item", name="bearing", amount=1},
                {type="item", name="brass-balls", amount=12},
            },
            results = {
                {type="item", name="spurving-bearing", amount=1}
            },
            energy_required = 6,
            allow_productivity = true,
            force_auto_recycle = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "hot-dip-galvanized-panel",
            icon = "__pf-sa-compat__/graphics/icons/hot-dip-galvanized-panel.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "electroplating",
            order = "a2",
            category = "metallurgy",
            ingredients = {
                {type="fluid", name="molten-zinc", amount=10, fluidbox_multiplier=10},
                {type="item", name="iron-plate", amount=5},
            },
            results = {
                {type="item", name="galvanized-panel", amount=5}
            },
            localised_description = {"recipe-description.hint-no-foundry-productivity"},
            maximum_productivity = 0,
            energy_required = 2,
            enabled = false
        },
        {
            type = "recipe",
            name = "hot-dip-galvanized-rod",
            icon = "__pf-sa-compat__/graphics/icons/hot-dip-galvanized-rod.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "electroplating",
            order = "b2",
            category = "metallurgy",
            ingredients = {
                {type="fluid", name="molten-zinc", amount=10, fluidbox_multiplier=10},
                {type="item", name="iron-stick", amount=5},
            },
            results = {
                {type="item", name="galvanized-rod", amount=5}
            },
            localised_description = {"recipe-description.hint-no-foundry-productivity"},
            maximum_productivity = 0,
            energy_required = 2,
            enabled = false
        },
        {
            type = "recipe",
            name = "hot-dip-galvanized-tubing",
            icon = "__pf-sa-compat__/graphics/icons/hot-dip-galvanized-tubing.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "electroplating",
            order = "c2",
            category = "metallurgy",
            ingredients = {
                {type="fluid", name="molten-zinc", amount=10, fluidbox_multiplier=10},
                {type="item", name="pipe", amount=5},
            },
            results = {
                {type="item", name="galvanized-tubing", amount=5}
            },
            localised_description = {"recipe-description.hint-no-foundry-productivity"},
            maximum_productivity = 0,
            energy_required = 2,
            enabled = false
        },
    })
end

if mods["bztin"] and data.raw.item["tinned-cable"] then
    data.raw.recipe["tinned-cable"].category = "electroplating"
    data.raw.recipe["tinned-cable"].allow_productivity = true
    data.raw.recipe["tinned-cable"].auto_recycle = false
    data.raw.item["tinned-cable"].auto_recycle = false
end

if mods["quality"] then
    data.raw.recipe["galvanized-panel"].localised_description = {"recipe-description.hint-prodmod-only-salt"}
    data.raw.recipe["galvanized-rod"].localised_description = {"recipe-description.hint-prodmod-only-salt"}
    data.raw.recipe["galvanized-tubing"].localised_description = {"recipe-description.hint-prodmod-only-salt"}

    data.raw.item["galvanized-panel"].localised_description = {"recipe-description.hint-nonstandard-recycling"}
    data.raw.item["galvanized-rod"].localised_description = {"recipe-description.hint-nonstandard-recycling"}
    data.raw.item["galvanized-tubing"].localised_description = {"recipe-description.hint-nonstandard-recycling"}

    --rm.AddProduct("galvanized-panel", {type="item", name="galvanized-panel", amount=0, ignored_by_productivity=1})
    --rm.AddProduct("galvanized-rod", {type="item", name="galvanized-rod", amount=0, ignored_by_productivity=1})
    --rm.AddProduct("galvanized-tubing", {type="item", name="galvanized-tubing", amount=0, ignored_by_productivity=1})

    data:extend({
        {
            type = "recipe",
            name = "custom-galvanized-panel-recycling",
            localised_name = {"recipe-name.recycling", {"item-name.galvanized-panel"}},
            icons = {
                    {
                        icon = "__quality__/graphics/icons/recycling.png",
                        icon_size = 64
                      },
                      {
                        icon = "__BrassTacks__/graphics/classic/icons/galvanized-panel.png",
                        icon_size = 64
                      },
                      {
                        icon = "__quality__/graphics/icons/recycling-top.png",
                        icon_size = 64
                      }
            },
            category = "recycling",
            ingredients = {
                {type="item", name="galvanized-panel", amount=1}
            },
            results = {
                {type="item", name="iron-plate", amount=1, probability = 0.75},
                {type="item", name="zinc-ore", amount=1, probability = 0.02}
            },
            bespoke = "galvanized-panel",
            energy_required = 1/16,
            allow_productivity = false,
            allow_quality = false, -- not lossy enough to be balanced against other recycling recipes
            hidden = true,
            allow_decomposition = false,
            unlock_results = false
        },
        {
            type = "recipe",
            name = "custom-galvanized-rod-recycling",
            localised_name = {"recipe-name.recycling", {"item-name.galvanized-rod"}},
            icons = {
                    {
                        icon = "__quality__/graphics/icons/recycling.png",
                        icon_size = 64
                      },
                      {
                        icon = "__BrassTacks__/graphics/classic/icons/galvanized-rod.png",
                        icon_size = 64
                      },
                      {
                        icon = "__quality__/graphics/icons/recycling-top.png",
                        icon_size = 64
                      }
            },
            category = "recycling",
            ingredients = {
                {type="item", name="galvanized-rod", amount=1}
            },
            results = {
                {type="item", name="iron-stick", amount=1, probability = 0.75},
                {type="item", name="zinc-ore", amount=1, probability = 0.02}
            },
            bespoke = "galvanized-rod",
            energy_required = 1/16,
            allow_productivity = false,
            allow_quality = false, -- not lossy enough to be balanced against other recycling recipes
            hidden = true,
            allow_decomposition = false,
            unlock_results = false
        },
        {
            type = "recipe",
            name = "custom-galvanized-tubing-recycling",
            localised_name = {"recipe-name.recycling", {"item-name.galvanized-tubing"}},
            icons = {
                    {
                        icon = "__quality__/graphics/icons/recycling.png",
                        icon_size = 64
                      },
                      {
                        icon = "__BrassTacks__/graphics/classic/icons/galvanized-tubing.png",
                        icon_size = 64
                      },
                      {
                        icon = "__quality__/graphics/icons/recycling-top.png",
                        icon_size = 64
                      }
            },
            category = "recycling",
            ingredients = {
                {type="item", name="galvanized-tubing", amount=1}
            },
            results = {
                {type="item", name="pipe", amount=1, probability = 0.75},
                {type="item", name="zinc-ore", amount=1, probability = 0.02}
            },
            bespoke = "galvanized-tubing",
            energy_required = 1/16,
            allow_productivity = false,
            allow_quality = false, -- not lossy enough to be balanced against other recycling recipes
            hidden = true,
            allow_decomposition = false,
            unlock_results = false
        }
    })

    if mods["bztin"] and data.raw.item["tinned-cable"] then
        data.raw.recipe["tinned-cable"].localised_description = {"recipe-description.hint-prodmod-only-organotins"}
    
        data.raw.item["tinned-cable"].localised_description = {"recipe-description.hint-nonstandard-recycling"}
        data:extend({
            {
                type = "recipe",
                name = "custom-tinned-cable-recycling",
                localised_name = {"recipe-name.recycling", {"item-name.tinned-cable"}},
                icons = {
                        {
                            icon = "__quality__/graphics/icons/recycling.png",
                            icon_size = 64
                          },
                          {
                            icon = "__bztin__/graphics/icons/tinned-cable.png",
                            icon_size = 64,
                            icon_mipmaps = 4
                          },
                          {
                            icon = "__quality__/graphics/icons/recycling-top.png",
                            icon_size = 64
                          }
                },
                category = "recycling",
                ingredients = {
                    {type="item", name="tinned-cable", amount=1}
                },
                results = {
                    {type="item", name="copper-cable", amount=1, probability=0.7},
                    {type="item", name="tin-ore", amount=1, probability = 0.005}
                },
                bespoke = "tinned-cable",
                energy_required = 1/32,
                allow_productivity = false,
                allow_quality = false, -- not lossy enough to be balanced against other recycling recipes
                hidden = true,
                allow_decomposition = false,
                unlock_results = false
            }
        })
        rm.AddProduct("tinned-cable", {type="item", name="tinned-cable", amount=0, ignored_by_productivity=8})
    end
else
end