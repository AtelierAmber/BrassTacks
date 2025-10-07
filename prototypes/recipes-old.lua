local parts = require("variable-parts")

local yield = 1
local cost = 1

if mods["Krastorio2"] then
  yield = 5
  cost = 10
  if mods["space-exploration"] then
    yield = 15
    cost = 20
  end
end

if not mods["galdocs-manufacturing"] then
  if mods["Krastorio2"] then
    if mods["bzaluminum"] then
      data:extend({
        {
          type = "recipe",
          name = "brass-plate",
          category = "smelting",
          normal = {
            energy_required = 1.6 * yield,
            ingredients = {{"copper-ore", cost}, {"zinc-ore", cost}},
            result = "brass-plate",
            result_count = yield * 2
          },
          expensive = {
            energy_required = 1.6 * yield,
            ingredients = {{"copper-ore", cost}, {"zinc-ore", cost}},
            result = "brass-plate",
            result_count = yield
          }
        },
        {
          type = "recipe",
          name = "brass-plate-foundry",
          category = parts.foundryEnabled and "founding" or "smelting",
          normal = {
            enabled = false,
            energy_required = 1.6 * yield,
            ingredients = {{"copper-plate", yield}, {"zinc-plate", yield}},
            result = "brass-plate",
            result_count = yield * 2
          },
          expensive = {
            enabled = false,
            energy_required = 1.6 * yield,
            ingredients = {{"copper-plate", yield}, {"zinc-plate", yield}},
            result = "brass-plate",
            result_count = yield
          }
        }
      })
    else
      data:extend({
        {
          type = "recipe",
          name = "brass-plate",
          category = "smelting",
          normal = {
            energy_required = 1.6,
            ingredients = {{"copper-plate", 1}, {"zinc-plate", 1}},
            result = "brass-plate",
            result_count = 2
          },
          expensive = {
            energy_required = 1.6,
            ingredients = {{"copper-plate", 1}, {"zinc-plate", 1}},
            result = "brass-plate",
            result_count = 1
          }
        }
      })
      if parts.foundryEnabled then
        data:extend({
          {
            type = "recipe",
            name = "brass-plate-foundry",
            category = "founding",
            normal = {
              enabled = false,
              energy_required = 1.6,
              ingredients = {{"copper-plate", 1}, {"zinc-plate", 1}},
              result = "brass-plate",
              result_count = 2
            },
            expensive = {
              enabled = false,
              energy_required = 1.6,
              ingredients = {{"copper-plate", 1}, {"zinc-plate", 1}},
              result = "brass-plate",
              result_count = 1
            }
          }
        })
      end
    end
  else
    data:extend({
      {
        type = "recipe",
        name = "brass-plate",
        category = "smelting",
        energy_required = 1.6,
        ingredients = {{"brass-precursor", 1}},
        result = "brass-plate"
      }
    })
    if mods["bzaluminum"] then
      data:extend({
        {
          type = "recipe",
          name = "brass-precursor",
          category = "crafting",
          normal = {
            energy_required = 0.5,
            ingredients = {{"copper-ore", 2}, {"zinc-ore", 2}},
            result = "brass-precursor",
            result_count = 2
          },
          expensive = {
            energy_required = 0.5,
            ingredients = {{"copper-ore", 2}, {"zinc-ore", 2}},
            result = "brass-precursor",
            result_count = 1
          }
        }
      })
      if not parts.foundryEnabled then
        data:extend({
          {
            type = "recipe",
            name = "brass-precursor-foundry",
            category = "crafting",
            normal = {
              enabled = false,
              energy_required = 0.5,
              ingredients = {{"copper-plate", 1}, {"zinc-plate", 1}},
              result = "brass-precursor",
              result_count = 2
            },
            expensive = {
              enabled = false,
              energy_required = 0.5,
              ingredients = {{"copper-plate", 1}, {"zinc-plate", 1}},
              result = "brass-precursor",
              result_count = 1
            }
          }
        })
      end
    else
      data:extend({
        {
          type = "recipe",
          name = "brass-precursor",
          category = "crafting",
          normal = {
            energy_required = 0.5,
            ingredients = {{"copper-plate", 1}, {"zinc-plate", 1}},
            result = "brass-precursor",
            result_count = 2
          },
          expensive = {
            energy_required = 0.5,
            ingredients = {{"copper-plate", 1}, {"zinc-plate", 1}},
            result = "brass-precursor",
            result_count = 1
          }
        }
      })
    end
    if parts.foundryEnabled then
      data:extend({
        {
          type = "recipe",
          name = "brass-plate-foundry",
          category = "founding",
          normal = {
            energy_required = 3.2,
            ingredients = {{"copper-plate", 1}, {"zinc-plate", 1}},
            result = "brass-plate",
            result_count = 2,
            enabled = false
          },
          expensive = {
            energy_required = 1.6,
            ingredients = {{"copper-plate", 1}, {"zinc-plate", 1}},
            result = "brass-plate",
            result_count = 1,
            enabled = false
          }
        }
      })
    end
  end
  if not mods["exotic-industries"] then
    data:extend({
      {
        type = "recipe",
        name = "zinc-plate",
        category = "smelting",
        energy_required = 3.2 * yield,
        ingredients = {{"zinc-ore", cost}},
        result = "zinc-plate",
        result_count = yield
      }
    })
  end
end

data:extend({
  {
    type = "recipe",
    name = "pipe-flange",
    category = "crafting",
    energy_required = 2.5,
    ingredients = {{"brass-plate", 2}},
    result = "pipe-flange",
    enabled = not mods["Krastorio2"],
    lasermill = {helium=1, productivity=true}
  },
  {
    type = "recipe",
    name = "brass-balls",
    category = "advanced-crafting",
    enabled = false,
    energy_required = 0.5,
    ingredients = {{"brass-plate", 1}},
    result = "brass-balls",
    result_count = 2,
    lasermill = {helium=1, productivity=true, type="gubbins", multiply=2}
  },
  {
    type = "recipe",
    name = "bearing",
    category = "crafting-with-fluid",
    normal = {
      enabled = false,
      energy_required = 4,
      ingredients = {{"brass-plate", 2}, {"brass-balls", 4}, {type="fluid", name="lubricant", amount=5}},
      result = "bearing"
    },
    expensive = {
      enabled = false,
      energy_required = 4,
      ingredients = {{"brass-plate", 2}, {"brass-balls", 8}, {type="fluid", name="lubricant", amount=10}},
      result = "bearing"
    }
  }
})

if mods["bzcarbon"] or mods["BrimStuff"] then
  data:extend({
    {
      type = "recipe",
      name = "airtight-seal",
      category = "advanced-crafting",
      enabled = false,
      energy_required = 2.5,
      ingredients = {{"pipe-flange", 1}, {"graphite", 2}},
      result = "airtight-seal",
      lasermill = {helium=data.raw.item["silver-brazing-alloy"] and 4 or 2, productivity=true}
    }
  })
  if mods["space-exploration"] then
    data:extend({
      {
        type = "recipe",
        name = "airtight-seal-vitalic",
        category = "advanced-crafting",
        icons = {
          {
            icon = parts.qualityIconPath("brasstacks", "icons/airtight-seal.png"),
            icon_size = 64
          },
          {
            icon = "__space-exploration-graphics__/graphics/icons/vitalic-epoxy.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          },
         },
        enabled = false,
        allow_decomposition = false,
        energy_required = 250,
        ingredients = {{"pipe-flange", 150}, {"graphite", 50}, {"se-vitalic-epoxy", 1}},
        result = "airtight-seal",
        result_count = 200,
        always_show_products = true,
        localised_name = {"recipe-name.airtight-seal-vitalic"},
        lasermill = {helium=100, convert=true, se_variant="space-crafting", se_tooltip_entity="se-space-assembling-machine", unlock="airtight-seal-vitalic", icon_offset={8, -8}}
      }
    })
  end
end

if settings.startup["brasstacks-experimental-intermediates"].value then
  data:extend({
    {
      type = "recipe",
      name = "flywheel",
      category = "crafting",
      normal = {
        energy_required = 2,
        ingredients = {{"iron-gear-wheel", 1}, {"zinc-plate", 3}},
        result = "flywheel"
      },
      expensive = {
        energy_required = 2,
        ingredients = {{"iron-gear-wheel", 1}, {"zinc-plate", 8}},
        result = "flywheel"
      },
      lasermill = {helium = 2, productivity = true}
    },
    {
      type = "recipe",
      name = "articulated-mechanism",
      category = "crafting",
      normal = {
        energy_required = 1,
        ingredients = {{"brass-plate", 1}, parts.preferred({"aluminum-plate", "iron-plate"}, {1, 1}), {"iron-stick", 3}},
        result = "articulated-mechanism",
        result_count = 2
      },
      expensive = {
        --aluminum is doublecosted in expensive mode
        energy_required = mods["bzaluminum"] and 1 or 0.5,
        ingredients = {{"brass-plate", mods["bzaluminum"] and 2 or 1}, parts.preferred({"aluminum-plate", "iron-plate"}, {1, 1}), {"iron-stick", mods["bzaluminum"] and 6 or 3}},
        result = "articulated-mechanism",
        result_count = mods["bzaluminum"] and 2 or 1
      }
    },
    {
      type = "recipe",
      name = "hardened-hull",
      category = "crafting",
      energy_required = 2,
      ingredients = {{"galvanized-steel-plate", 1}, parts.nickel and {"invar-plate", 1} or {"iron-plate", 2}, parts.preferred({"bronze-plate", "brass-plate"}, {2, 2})},
      result = "hardened-hull",
      enabled = false,
      lasermill = {helium=5, productivity=true}
    },
    {
      type = "recipe",
      name = "complex-joint",
      category = "crafting-with-fluid",
      normal = {
        energy_required = 8,
        ingredients = {{"bearing", 1}, {"galvanized-steel-plate", 1}, parts.preferred({"cermet", "zirconia", "plastic-bar"}, {1, 4, 2}), {"articulated-mechanism", 8}, {type="fluid", name="lubricant", amount=5}},
        result = "complex-joint",
        enabled = false
      },
      expensive = {
        energy_required = 8,
        ingredients = {{"bearing", 1}, {"galvanized-steel-plate", 1}, parts.preferred({"cermet", "zirconia", "plastic-bar"}, {2, 4, 4}), {"articulated-mechanism", 12}, {type="fluid", name="lubricant", amount=10}},
        result = "complex-joint",
        enabled = false
      }
    },
    {
      type = "recipe",
      name = "gearbox",
      category = "crafting",
      energy_required = 3,
      ingredients = {{"galvanized-steel-plate", 1}, {"iron-gear-wheel", mods["Krastorio2"] and 8 or 10}},
      result = "gearbox",
      result_count = 2,
      enabled = false
    },
    {
      type = "recipe",
      name = "advanced-gearbox",
      category = "crafting-with-fluid",
      energy_required = 3,
      ingredients = {{"gearbox", 1}, {"iron-gear-wheel", mods["Krastorio2"] and 4 or 5}, {"bearing", 2}, {"flywheel", 1}, {type="fluid", name="lubricant", amount=20}},
      result = "advanced-gearbox",
      enabled = false
    }
  })

  if not mods["galdocs-manufacturing"] then
    data:extend({
      {
        type = "recipe",
        name = "galvanized-steel-plate",
        category = parts.foundryEnabled and "founding" or "advanced-crafting",
        normal = {
          energy_required = parts.foundryEnabled and 6.4 or 3,
          ingredients = {{"steel-plate", 1}, {"zinc-plate", 1}},
          result = "galvanized-steel-plate",
          enabled = false
        },
        expensive = {
          energy_required = parts.foundryEnabled and 6.4 or 3,
          ingredients = {{"steel-plate", 1}, {"zinc-plate", 2}},
          result = "galvanized-steel-plate",
          enabled = false
        }
      }
    })
  end

  if mods["Krastorio2"] then
    data:extend({
      {
        type = "recipe",
        name = "elite-gearbox",
        category = "advanced-crafting",
        energy_required = 6,
        ingredients = {{"advanced-gearbox", 1}, {"imersium-gear-wheel", 4}, {"imersium-beam", 1}, parts.preferred({"se-heavy-bearing", "electric-engine-unit"}, {4, 1})},
        result = "elite-gearbox",
        enabled = false
      }
    })
  end

  if mods["space-exploration"] then
    data:extend({
      {
        type = "recipe",
        name = "complex-joint-iridium",
        category = "crafting-with-fluid",
        icons = {
          {
            icon = parts.qualityIconPath("brasstacks", "icons/complex-joint.png"),
            icon_size = 64
          },
          {
            icon = "__space-exploration-graphics__/graphics/icons/iridium-plate.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          },
         },
        localised_name = {"recipe-name.complex-joint-iridium"},
        normal = {
          energy_required = 64,
          ingredients = {{"bearing", 8}, {"se-iridium-plate", 1}, parts.preferred({"cermet", "zirconia", "plastic-bar"}, {8, 32, 16}), {"articulated-mechanism", 48}, {type="fluid", name="lubricant", amount=40}},
          result = "complex-joint",
          result_count = 8,
          enabled = false,
          always_show_products = true
        },
        expensive = {
          energy_required = 64,
          ingredients = {{"bearing", 8}, {"se-iridium-plate", 1}, parts.preferred({"cermet", "zirconia", "plastic-bar"}, {16, 32, 32}), {"articulated-mechanism", 72}, {type="fluid", name="lubricant", amount=80}},
          result = "complex-joint",
          result_count = 8,
          enabled = false,
          always_show_products = true
        }
      },
      {
        type = "recipe",
        name = "gearbox-iridium",
        category = "advanced-crafting",
        icons = {
          {
            icon = parts.qualityIconPath("brasstacks", "icons/gearbox.png"),
            icon_size = 64
          },
          {
            icon = "__space-exploration-graphics__/graphics/icons/iridium-plate.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          },
         },
        energy_required = 48,
        ingredients = {{"se-iridium-plate", 1}, {"iron-gear-wheel", mods["Krastorio2"] and 64 or 80}, {"electric-motor", mods["Krastorio2"] and 12 or 16}},
        result = "gearbox",
        result_count = 16,
        enabled = false,
        always_show_products = true,
        localised_name = {"recipe-name.gearbox-iridium"}
      },
      {
        type = "recipe",
        name = "hardened-hull-iridium",
        category = "advanced-crafting",
        icons = {
          {
            icon = parts.qualityIconPath("brasstacks", "icons/hardened-hull.png"),
            icon_size = 64
          },
          {
            icon = "__space-exploration-graphics__/graphics/icons/iridium-plate.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          },
         },
        energy_required = 16,
        ingredients = {{"se-iridium-plate", 1}, {"galvanized-steel-plate", 4}, parts.nickel and {"invar-plate", 4} or {"iron-plate", 8}, parts.preferred({"bronze-plate", "brass-plate"}, {16, 16}), parts.optionalIngredient("lead-plate", 8)},
        result = "hardened-hull",
        result_count = 8,
        enabled = false,
        always_show_products = true,
        localised_name = {"recipe-name.hardened-hull-iridium"},
        lasermill = {helium=30, convert=true, se_variant="space-crafting", se_tooltip_entity="se-space-assembling-machine", unlock="se-heat-shielding-iridium", icon_offset={8, -8}}
      }
    })
  end

  if parts.gyro then
    data:extend({
      {
        type = "recipe",
        name = parts.gyro,
        category = "crafting",
        energy_required = 5,
        --preferred can't be used - ifnickel loads after this.
        ingredients = {{"flywheel", 1}, {"bearing", 2}, {"advanced-circuit", 1}, (mods["aai-industry"] and {"electric-motor", 1}) or (mods["IfNickel"] and {"motor", 1}) or (mods["Krastorio2"] and {"steel-gear-wheel", 1}) or {"iron-gear-wheel", 2}},
        result = parts.gyro,
        enabled = false
      }
    })
  end

  if mods["aai-signal-transmission"] or mods["LunarLandings"] then
    data:extend({
      {
        type = "recipe",
        name = "skyseeker-armature",
        category = "crafting",
        energy_required = 20,
        ingredients = {{"complex-joint", 1}, {"low-density-structure", 1}, {"electric-engine-unit", 1}, parts.preferred({"steel-gear-wheel", "iron-gear-wheel"}, {3, 6}), parts.preferred({"gyro", "gyro"}, {1, 1})},
        result = "skyseeker-armature",
        enabled = false
      }
    })
  end

  if mods["LunarLandings"] and mods["IfNickel"] then
    data:extend({
      {
        type = "recipe",
        name = "hardened-hull-alumina",
        icons = {
          {
            icon = parts.qualityIconPath("brasstacks", "icons/hardened-hull.png"),
            icon_size = 64
          },
          {
            icon = "__LunarLandings__/graphics/icons/alumina.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          },
         },
        category = "crafting",
        energy_required = 2,
        ingredients = {{"galvanized-steel-plate", 1}, {"ll-alumina", 1}, parts.preferred({"bronze-plate", "brass-plate"}, {2, 2})},
        result = "hardened-hull",
        enabled = false,
        lasermill = {helium=5, productivity=true, convert=true}
      }
    })
  end
end

if parts.drill then
  data:extend({
    {
      type = "recipe",
      name = "industrial-drill-head",
      category = "advanced-crafting",
      energy_required = 5,
      ingredients = {{"complex-joint", 1}, {"electric-engine-unit", 1}, {"tungsten-carbide", 2}, {"diamond", 2}},
      result = "industrial-drill-head",
      enabled = false
    },
  })
end

if mods["Krastorio2"] then
  local matterutil = require("__Krastorio2__/lib/public/data-stages/matter-util")
  data:extend(
    {
      {
        type = "recipe",
        name = "enriched-zinc",
        category = "chemistry",
        energy_required = 3,
        ingredients = {{"zinc-ore", 9}, {type="fluid", name="sulfuric-acid", amount=3}, {type="fluid", name="water", amount=25, catalyst_amount = 25}},
        results = {{"enriched-zinc", mods["space-exploration"] and 9 or 6}, {type="fluid", name="dirty-water", amount=25, catalyst_amount=25}},
        main_product = "enriched-zinc",
        enabled = false
        --default white chemplant tint is fine for once!
      },
      {
        type = "recipe",
        name = "enriched-zinc-plate",
        icons = {
          { icon = parts.qualityIconPath("brasstacks", "icons/zinc-plate.png"), icon_size = 64 },
          { icon = parts.qualityIconPath("brasstacks", "icons/enriched-zinc.png"), icon_size = 64, scale=0.25, shift= {-8, -8}},
        },
        category = "smelting",
        energy_required = 16,
        ingredients = {{"enriched-zinc", 5}},
        result = "zinc-plate",
        result_count = 5,
        enabled = false
      },
      {
    		type = "recipe",
    		name = "dirty-water-filtration-zinc",
        subgroup = "raw-material",
    		order = "w013[dirty-water-filtration-zinc]",
    		category = "fluid-filtration",
    		icons =
    		{
    			{
    				icon = data.raw.fluid["dirty-water"].icon,
    				icon_size = data.raw.fluid["dirty-water"].icon_size
    			},
    			{
    				icon = "__BrassTacks__/graphics/icons/zinc-ore.png",
    				icon_size =	64,
    				scale = 0.2,
    				shift = {0, 4}
    			}
    		},
    		energy_required = 2,
    		ingredients = { {type = "fluid", name = "dirty-water", amount = 100, catalyst_amount = 100} },
    		results =	{ {type = "fluid", name = "water", amount = 90, catalyst_amount = 90}, {type = "item",  name = "stone", probability = 0.3, amount = 1}, {type = "item",  name = "zinc-ore", probability = 0.1, amount = 1},
    		},
    		crafting_machine_tint =
    		{
    			primary = {r = 0.75, g = 0.75, b = 1, a = 0.6},
    			secondary = {r = 1.0, g = 1.0, b = 1.0, a = 0.9}
    		},
        enabled = false
    	},
      {
        type = "technology",
        name = "kr-matter-zinc-processing",
        icons = {
          {
            icon = "__Krastorio2Assets__/technologies/matter-iron.png",
            icon_size = 256,
            icon_mipmaps = 4,
          },
          {
            icon = "__BrassTacks__/graphics/icons/zinc-ore.png",
            icon_size = 64,
            icon_mipmaps = 4,
            scale = 2
          }
        },
        effects = {},
        prerequisites = { "kr-matter-processing" },
        order = "g-e-e",
        unit = {
          count = 350,
          ingredients = {
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "matter-tech-card", 1 },
          },
          time = 45
        }
      }
    }
  )
  matterutil.createMatterRecipe({
    item_name = "zinc-ore",
    minimum_conversion_quantity = 10,
    matter_value = 5,
    energy_required = 1,
    need_stabilizer = false,
    unlocked_by_technology = "kr-matter-zinc-processing"
  })
  matterutil.createMatterRecipe({
    item_name = "zinc-plate",
    minimum_conversion_quantity = 10,
    matter_value = mods["space-exploration"] and 7.5 or 10,
    energy_required = 3,
    only_deconversion = true,
    need_stabilizer = true,
    unlocked_by_technology = "kr-matter-zinc-processing"
  })
end

if mods["space-exploration"] then
  se_delivery_cannon_recipes["zinc-ore"] = {name= "zinc-ore"}
  se_delivery_cannon_recipes["zinc-plate"] = {name= "zinc-plate"}
  se_delivery_cannon_recipes["zinc-ingot"] = {name= "zinc-ingot"}
  se_delivery_cannon_recipes["brass-plate"] = {name= "brass-plate"}
  se_delivery_cannon_recipes["brass-ingot"] = {name= "brass-ingot"}
  if parts.experimental then
    se_delivery_cannon_recipes["hardened-hull"] = {name= "hardened-hull"}
  end
  if mods["Krastorio2"] then
    se_delivery_cannon_recipes["enriched-zinc"] = {name= "enriched-zinc"}
  end

  data:extend(
    {
      {
        type = "recipe",
        icon = parts.qualityIconPath("brasstacks", "icons/molten-zinc.png"),
        icon_size = 64,
        subgroup = "zinc",
        name = "molten-zinc",
        category = "smelting",
        energy_required = 60,
        ingredients = {{mods["Krastorio2"] and "enriched-zinc" or "zinc-ore", 24}, {type="fluid", name="se-pyroflux", amount=10}},
        results = {{type="fluid", name="molten-zinc", amount= mods["Krastorio2"] and 750 or 900}},
        enabled = false
      },
      {
        type = "recipe",
        name = "zinc-ingot",
        category = "casting",
        energy_required = 25,
        ingredients = {{type="fluid", name="molten-zinc", amount=250}},
        result = "zinc-ingot",
        result_count = 1,
        enabled = false
      },
      {
        type = "recipe",
        name = "zinc-ingot-to-plate",
        icons = {
          { icon = parts.qualityIconPath("brasstacks", "icons/zinc-plate.png"), icon_size = 64 },
          { icon = parts.qualityIconPath("brasstacks", "icons/zinc-ingot.png"), icon_size = 64, scale=0.25, shift= {-8, -8}},
        },
        category = "crafting",
        energy_required = 5,
        ingredients = {{"zinc-ingot", 1}},
        result = "zinc-plate",
        result_count = 10,
        allow_decomposition = false,
        enabled = false
      },
      {
        type = "recipe",
        name = "brass-ingot",
        category = "casting",
        energy_required = 25,
        ingredients = {{type="fluid", name="se-molten-copper", amount=250}, {type="item", name="zinc-ingot", amount=1}},
        result = "brass-ingot",
        result_count = 2,
        enabled = false
      },
      {
        type = "recipe",
        name = "brass-ingot-to-plate",
        icons = {
          { icon = parts.qualityIconPath("brasstacks", "icons/brass-plate.png"), icon_size = 64 },
          { icon = parts.qualityIconPath("brasstacks", "icons/brass-ingot.png"), icon_size = 64, scale=0.25, shift= {-8, -8}},
        },
        category = "crafting",
        energy_required = 5,
        ingredients = {{"brass-ingot", 1}},
        result = "brass-plate",
        result_count = 10,
        allow_decomposition = false,
        enabled = false
      }
    }
  )

  if false then
    --I'm not going to add this for now. It's currently not possible to add recipes to the main matter liberation tech without doing stupid things.
    --Matter liberation is supposed to be a mediocre stepping stone to K2 matter. I don't particularly want to make resource specific technologies for such a thing.
    --I'll add this if there is ever a painless interface for adding matter stuff like there is for delivery cannons.
    -- ~~or if the tech is moved to be created earlier than final fixes which non dynamically generated prototypes are SUPPOSED TO BE ANYWAY~~
    data:extend({
      {
        type = "recipe",
        name = "se-kr-zinc-to-particle-stream",
        localised_name = {"recipe-name.se-kr-matter-liberation", {"item-name.zinc-ore"}},
        icons = {
          {icon = "__space-exploration-graphics__/graphics/blank.png", icon_size = 64, scale = 0.5},
          {icon = "__space-exploration-graphics__/graphics/icons/fluid/particle-stream.png", icon_size = 64,  scale = 0.33, shift = {-8,8}},
          {icon = "__BrassTacks__/graphics/icons/zinc-ore.png", icon_size = 64, scale = 0.33, shift={8, -8}},
          {icon = "__space-exploration-graphics__/graphics/icons/transition-arrow.png", icon_size = 64, scale = 0.5},
        },
        category = "space-materialisation",
        subgroup = "advanced-particle-stream",
        energy_required = 30,
        ingredients = {{"zinc-ore", 10}, {"se-kr-matter-liberation-data", 1}, {type="fluid", name="se-particle-stream", amount = 50}},
        results = {{type="item", name="se-kr-matter-liberation-data", amount=1, probability=0.99}, {type="item", name="se-broken-data", amount=1, probability=0.01}, {type="fluid", name="se-particle-stream", amount = 60}},
        allow_decomposition = false,
        enabled = false
      }
    })
  end
end

if mods["FreightForwarding"] then
  data:extend({
    {
      type = "recipe",
      name = "brazen-nodule-dredging",
      category = "ff-dredging",
      energy_required = 50,
      ingredients = {},
      results = {{type="item", name="brazen-nodule", amount_min=100, amount_max=200}},
      show_amount_in_title = false,
      always_show_products = true,
      enabled = false
    },
    {
      type = "recipe",
      name = "brazen-nodule-washing",
      category = "chemistry",
      energy_required = 15,
      allow_decomposition = false,
      ingredients = {{"brazen-nodule", 18}, {type="fluid", name="sulfuric-acid", amount=15}},
      results = {{type="item", name="zinc-ore", amount_min=40, amount_max=50}, {type="item", name="copper-ore", amount_min=0, amount_max=8}, {type="item", name="stone", amount_min=0, amount_max=4}, {type="item", name="brazen-nodule", amount_min=0, amount_max=6}},
      main_product = "zinc-ore",
      enabled = false
      --default white chemplant tint is fine for once!
    }
  })
end

if mods["248k"] then
  data:extend({
    {
      type = "recipe",
      name = "248k-zinc-atom-hot",
      category = "fu_star_engine_core_crafting_category",
      energy_required = 1,
      ingredients = {{type="fluid", name="fu_protium_heated", amount=30000}},
      results = {{type="fluid", name="248k-zinc-atom-hot", amount=1000}},
      subgroup = "fu_star_engine_subgroup_b",
      enabled=false
    },
    {
      type = "recipe",
      name = "248k-zinc-atom",
      category = "fu_star_engine_cooler_crafting_category",
      energy_required = 1,
      ingredients = {{type="fluid", name="248k-zinc-atom-hot", amount=500}},
      results = {{type="fluid", name="248k-zinc-atom", amount=500}},
      subgroup = "fu_star_engine_subgroup_c",
      enabled=false
    },
    {
      type = "recipe",
      name = "zinc-from-atoms",
      category = "crafting-with-fluid",
      energy_required = 6,
      ingredients = {{type="fluid", name="248k-zinc-atom", amount=500}},
      result = "zinc-plate",
      result_count = 500,
      subgroup = "fu_star_engine_subgroup_d",
      enabled=false
    },
    {
      type = "recipe",
      name = "brass-from-atoms",
      category = "chemistry",
      energy_required = 6,
      ingredients = {{type="fluid", name="248k-zinc-atom", amount=250}, {type="fluid", name="fu_copper", amount=250}},
      result = "brass-plate",
      result_count = 500,
      subgroup = "fu_star_engine_subgroup_d",
      enabled=false
    }
  })
end

if mods["LunarLandings"] then
  data:extend({
    {
      type = "recipe",
      name = "cheese-ore-processing",
      category = "ll-electric-smelting",
      subgroup = "ll-raw-material-moon",
      order = "a[moon-rock]-c",
      icon = "__BrassTacks__/graphics/icons/cheese-ore.png",
      icon_size = 64,
      energy_required = 10,
      ingredients = { {"cheese-ore", 20} },
      results = {{type="item", name="zinc-ore", amount=10}, {type="item", name="ll-moon-rock", amount=3}, {type="fluid", name="light-oil", amount=10, fluidbox_index = 1}},
      always_show_products = true,
      enabled = false
    }
  })
end
