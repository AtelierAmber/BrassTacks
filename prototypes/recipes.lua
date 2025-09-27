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
          energy_required = 1.6 * yield,
          ingredients = {{type="item", name="copper-ore", amount=cost}, {type="item", name="zinc-ore", amount=cost}},
          results = {{type="item", name="brass-plate", amount=yield*2}},
          main_product = "brass-plate",
        },
        {
          type = "recipe",
          name = "brass-plate-foundry",
          category = parts.foundryEnabled and "founding" or "smelting",
          enabled = false,
          energy_required = 1.6 * yield,
          ingredients = {{type="item", name="copper-plate", amount=yield}, {type="item", name="zinc-plate", amount=yield}},
          results = {{type="item", name="brass-plate", amount=yield*2}},
        }
      })
    else
      data:extend({
        {
          type = "recipe",
          name = "brass-plate",
          category = "smelting",
          energy_required = 1.6,
          ingredients = {{type="item", name="copper-plate", amount=1}, {type="item", name="zinc-plate", amount=1}},
          results = {{type="item", name="brass-plate",amount=2}}
        }
      })
      if parts.foundryEnabled then
        data:extend({
          {
            type = "recipe",
            name = "brass-plate-foundry",
            category = "founding",
            enabled = false,
            energy_required = 1.6,
            ingredients = {{type="item", name="copper-plate", amount=1}, {type="item", name="zinc-plate", amount=1}},
            results = {{type="item", name="brass-plate",amount=2}}
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
        ingredients = {{type="item", name="brass-precursor", amount=1}},
        result = "brass-plate"
      }
    })
    if mods["bzaluminum"] then
      data:extend({
        {
          type = "recipe",
          name = "brass-precursor",
          category = "crafting",
          energy_required = 0.5,
          ingredients = {{type="item", name="copper-ore", amount=2}, {type="item", name="zinc-ore", amount=2}},
          results = {{type="item", name="brass-precursor",amount=2}}
        }
      })
      if not parts.foundryEnabled then
        data:extend({
          {
            type = "recipe",
            name = "brass-precursor-foundry",
            category = "crafting",
            enabled = false,
            energy_required = 0.5,
            ingredients = {{type="item", name="copper-plate", amount=1}, {type="item", name="zinc-plate", amount=1}},
            results = {{type="item", name="brass-precursor",amount=2}}
          }
        })
      end
    else
      data:extend({
        {
          type = "recipe",
          name = "brass-precursor",
          category = "crafting",
          energy_required = 0.5,
          ingredients = {{type="item", name="copper-plate", amount=1}, {type="item", name="zinc-plate", amount=1}},
          results = {{type="item", name="brass-precursor",amount=2}}
        }
      })
    end
    if parts.foundryEnabled then
      data:extend({
        {
          type = "recipe",
          name = "brass-plate-foundry",
          category = "founding",
          energy_required = 3.2,
          ingredients = {{type="item", name="copper-plate", amount=1}, {type="item", name="zinc-plate", amount=1}},
          results = {{type="item", name="brass-plate",amount=2}},
          enabled = false
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
        ingredients = {{type="item", name="zinc-ore", amount=cost}},
        result = "zinc-plate",
        result_count = yield
      }
    })
  end
end

data:extend({
  {
    type = "recipe",
    name = "bolted-flange",
    category = "crafting",
    energy_required = 2.5,
    ingredients = {{type="item", name="brass-plate", amount=2}},
    result = "bolted-flange",
    enabled = not mods["Krastorio2"],
    lasermill = {helium=1, productivity=true}
  },
  {
    type = "recipe",
    name = "brass-balls",
    category = "advanced-crafting",
    enabled = false,
    energy_required = 0.5,
    ingredients = {{type="item", name="brass-plate", amount=1}},
    results = {{type="item", name="brass-balls",amount=2}},
    lasermill = {helium=1, productivity=true, type="gubbins", multiply=2}
  },
  {
    type = "recipe",
    name = "bearing",
    category = "crafting-with-fluid",
    enabled = false,
    energy_required = 4,
    ingredients = {{type="item", name="brass-plate", amount=2}, {type="item", name="brass-balls", amount=4}, {type="fluid", name="lubricant", amount=5}},
    result = "bearing"
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
      ingredients = {{type="item", name="bolted-flange", amount=1}, {type="item", name="graphite", amount=2}},
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
        ingredients = {{type="item", name="bolted-flange", amount=150}, {type="item", name="graphite", amount=50}, {type="item", name="se-vitalic-epoxy", amount=1}},
        results = {{type="item", name="airtight-seal",amount=200}},
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
      energy_required = 2,
      ingredients = {{type="item", name="iron-gear-wheel", amount=1}, {type="item", name="zinc-plate", amount=3}},
      result = "flywheel",
      lasermill = {helium = 2, productivity = true}
    },
    {
      type = "recipe",
      name = "articulated-mechanism",
      category = "crafting",
      energy_required = 1,
      ingredients = {{type="item", name="brass-plate", amount=1}, parts.preferred({"aluminum-plate", "iron-plate"}, {1, 1}), {type="item", name="iron-stick", amount=3}},
      results = {{type="item", name="articulated-mechanism",amount=2}},
    },
    {
      type = "recipe",
      name = "hardened-hull",
      category = "crafting",
      energy_required = 2,
      ingredients = {{type="item", name="galvanized-steel-plate", amount=1}, parts.nickel and {type="item", name="invar-plate", amount=1} or {type="item", name="iron-plate", amount=2}, 
                     parts.preferred({"bronze-plate", "brass-plate"}, {2, 2})},
      result = "hardened-hull",
      enabled = false,
      lasermill = {helium=5, productivity=true}
    },
    {
      type = "recipe",
      name = "complex-joint",
      category = "crafting-with-fluid",
      energy_required = 8,
      ingredients = {{type="item", name="bearing", amount=1}, {type="item", name="galvanized-steel-plate", amount=1}, parts.preferred({"cermet", "zirconia", "plastic-bar"}, {1, 4, 2}), 
                     {type="item", name="articulated-mechanism", amount=8}, {type="fluid", name="lubricant", amount=5}},
      result = "complex-joint",
      enabled = false,
    },
    {
      type = "recipe",
      name = "gearbox",
      category = "crafting",
      energy_required = 3,
      ingredients = {{type="item", name="galvanized-steel-plate", amount=1}, {type="item", name="iron-gear-wheel", amount=(mods["Krastorio2"] and 8 or 10)}},
      results = {{type="item", name="gearbox",amount=2}},
      enabled = false
    },
    {
      type = "recipe",
      name = "advanced-gearbox",
      category = "crafting-with-fluid",
      energy_required = 3,
      ingredients = {{type="item", name="gearbox", amount=1}, {type="item", name="iron-gear-wheel", amount=(mods["Krastorio2"] and 4 or 5)}, 
                     {type="item", name="bearing", amount=2}, {type="item", name="flywheel", amount=1}, {type="fluid", name="lubricant", amount=20}},
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
        energy_required = parts.foundryEnabled and 6.4 or 3,
        ingredients = {{type="item", name="steel-plate", amount=1}, {type="item", name="zinc-plate", amount=1}},
        result = "galvanized-steel-plate",
        enabled = false,
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
        ingredients = {{type="item", name="advanced-gearbox", amount=1}, {type="item", name="imersium-gear-wheel", amount=4}, {type="item", name="imersium-beam", amount=1}, 
                       parts.preferred({"se-heavy-bearing", "electric-engine-unit"}, {4, 1})},
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
        energy_required = 64,
        ingredients = {{type="item", name="bearing", amount=8}, {type="item", name="se-iridium-plate", amount=1}, parts.preferred({"cermet", "zirconia", "plastic-bar"}, {8, 32, 16}), 
                       {type="item", name="articulated-mechanism", amount=48}, {type="fluid", name="lubricant", amount=40}},
        results = {{type="item", name="complex-joint",amount=8}},
        enabled = false,
        always_show_products = true,
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
        ingredients = {{type="item", name="se-iridium-plate", amount=1}, {type="item", name="iron-gear-wheel", amount=(mods["Krastorio2"] and 64 or 80)}, {type="item", name="electric-motor", amount=(mods["Krastorio2"] and 12 or 16)}},
        results = {{type="item", name="gearbox",amount=16}},
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
        ingredients = {{type="item", name="se-iridium-plate", amount=1}, {type="item", name="galvanized-steel-plate", amount=4}, parts.nickel and 
                       {type="item", name="invar-plate", amount=4} or {type="item", name="iron-plate", amount=8}, parts.preferred({"bronze-plate", "brass-plate"}, {16, 16}), parts.optionalIngredient("lead-plate", 8)},
        results = {{type="item", name="hardened-hull",amount=8}},
        enabled = false,
        always_show_products = true,
        localised_name = {"recipe-name.hardened-hull-iridium"},
        lasermill = {helium=30, convert=true, se_variant="space-crafting", se_tooltip_entity="se-space-assembling-machine", unlock="se-heat-shielding-iridium", icon_offset={8, -8}}
      }
    })
  end

  if parts.gyroscope then
    data:extend({
      {
        type = "recipe",
        name = parts.gyroscope,
        category = "crafting",
        energy_required = 5,
        --preferred can't be used - ifnickel loads after this.
        ingredients = {{type="item", name="flywheel", amount=1}, {type="item", name="bearing", amount=2}, {type="item", name="advanced-circuit", amount=1}, 
                       (mods["aai-industry"] and {type="item",name="electric-motor", amount=1}) or (mods["IfNickel"] and {type="item",name="motor", amount=1}) or (mods["Krastorio2"] and {type="item",name="steel-gear-wheel", amount=1}) or {type="item",name="iron-gear-wheel", amount=2}},
        result = parts.gyroscope,
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
        ingredients = {{type="item", name="complex-joint", amount=1}, {type="item", name="low-density-structure", amount=1}, {type="item", name="electric-engine-unit", amount=1}, 
                        parts.preferred({"steel-gear-wheel", "iron-gear-wheel"}, {3, 6}), parts.preferred({"gyro", "gyroscope"}, {1, 1})},
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
        ingredients = {{type="item", name="galvanized-steel-plate", amount=1}, {type="item", name="ll-alumina", amount=1}, parts.preferred({"bronze-plate", "brass-plate"}, {2, 2})},
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
      ingredients = {{type="item", name="complex-joint", amount=1}, {type="item", name="electric-engine-unit", amount=1}, {type="item", name="tungsten-carbide", amount=2}, {type="item", name="diamond", amount=2}},
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
        ingredients = {{type="item", name="zinc-ore", amount=9}, {type="fluid", name="sulfuric-acid", amount=3}, {type="fluid", name="water", amount=25, catalyst_amount = 25}},
        results = {{type="item", name="enriched-zinc", amount=(mods["space-exploration"] and 9 or 6)}, {type="fluid", name="dirty-water", amount=25, catalyst_amount=25}},
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
        ingredients = {{type="item", name="enriched-zinc", amount=5}},
        results = {{type="item", name="zinc-plate",amount=5}},
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
        ingredients = {{type="item", name=(mods["Krastorio2"] and "enriched-zinc" or "zinc-ore"), amount=24}, {type="fluid", name="se-pyroflux", amount=10}},
        results = {{type="fluid", name="molten-zinc", amount= mods["Krastorio2"] and 750 or 900}},
        enabled = false
      },
      {
        type = "recipe",
        name = "zinc-ingot",
        category = "casting",
        energy_required = 25,
        ingredients = {{type="fluid", name="molten-zinc", amount=250}},
        results = {{type="item", name="zinc-ingot",amount=1}},
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
        ingredients = {{type="item", name="zinc-ingot", amount=1}},
        results = {{type="item", name="zinc-plate",amount=10}},
        allow_decomposition = false,
        enabled = false
      },
      {
        type = "recipe",
        name = "brass-ingot",
        category = "casting",
        energy_required = 25,
        ingredients = {{type="fluid", name="se-molten-copper", amount=250}, {type="item", name="zinc-ingot", amount=1}},
        results = {{type="item", name="brass-ingot",amount=2}},
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
        ingredients = {{type="item", name="brass-ingot", amount=1}},
        results = {{type="item", name="brass-plate",amount=10}},
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
        ingredients = {{type="item", name="zinc-ore", amount=10}, {type="item", name="se-kr-matter-liberation-data", amount=1}, {type="fluid", name="se-particle-stream", amount = 50}},
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
      ingredients = {{type="item", name="brazen-nodule", amount=18}, {type="fluid", name="sulfuric-acid", amount=15}},
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
      results = {{type="item", name="zinc-plate",amount=500}},
      subgroup = "fu_star_engine_subgroup_d",
      enabled=false
    },
    {
      type = "recipe",
      name = "brass-from-atoms",
      category = "chemistry",
      energy_required = 6,
      ingredients = {{type="fluid", name="248k-zinc-atom", amount=250}, {type="fluid", name="fu_copper", amount=250}},
      results = {{type="item", name="brass-plate",amount=500}},
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
      ingredients = { {type="item", name="cheese-ore", amount=20} },
      results = {{type="item", name="zinc-ore", amount=10}, {type="item", name="ll-moon-rock", amount=3}, {type="fluid", name="light-oil", amount=10, fluidbox_index = 1}},
      always_show_products = true,
      enabled = false
    }
  })
end
