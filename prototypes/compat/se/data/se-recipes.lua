local optionals = require("optionals")
local helper = require("prototypes.lib.prototype_helper")

data:extend({
    {
      type = "recipe",
      icon = helper.graphic("icons/molten-zinc.png").icon,
      icon_size = 64,
      subgroup = "zinc",
      name = "molten-zinc",
      category = "smelting",
      energy_required = 60,
      ingredients = {
        helper.item((mods["Krastorio2"] and "enriched-zinc" or "zinc-ore"), 24), 
        helper.fluid("se-pyroflux", 10)},
      results = {helper.fluid("molten-zinc", mods["Krastorio2"] and 750 or 900)},
      enabled = false
    },
    {
      type = "recipe",
      name = "zinc-ingot",
      category = "casting",
      energy_required = 25,
      ingredients = {helper.fluid("molten-zinc", 250)},
      results = {helper.item("zinc-ingot")},
      enabled = false
    },
    {
      type = "recipe",
      name = "zinc-ingot-to-plate",
      icons = {
        helper.graphic("icons/zinc-plate.png"),
        helper.graphic("icons/zinc-ingot.png", nil, nil, {scale=0.25, shift= {-8, -8}}),
      },
      category = "crafting",
      energy_required = 5,
      ingredients = {helper.item("zinc-ingot")},
      results = {helper.item("zinc-plate")},
      enabled = false,
      allow_decomposition = false
    },
    {
      type = "recipe",
      name = "brass-ingot",
      category = "casting",
      energy_required = 25,
      ingredients = {
        helper.fluid("se-molten-copper", 250), 
        helper.item("zinc-ingot")},
      results = {helper.item("brass-ingot", 2)},
      enabled = false
    },
    {
      type = "recipe",
      name = "brass-ingot-to-plate",
      icons = {
        helper.graphic("icons/brass-plate.png"),
        helper.graphic("icons/brass-ingot.png", 64, nil, {scale=0.25, shift= {-8, -8}}),
      },
      category = "crafting",
      energy_required = 5,
      ingredients = {helper.item("brass-ingot")},
      results = {helper.item("brass-plate", 10)},
      allow_decomposition = false,
      enabled = false
    }
  }
)

if optionals.useadvfitting then
  data:extend({
    {
      type = "recipe",
      name = "airtight-seal-vitalic",
      category = "advanced-crafting",
      icons = {
        helper.graphic("icons/airtight-seal.png"),
        helper.graphic("icons/vitalic-epoxy.png", nil, "space-exploration-graphics", 
          {scale = 0.25, shift = {-8, -8}})},
      allow_decomposition = false,
      energy_required = 250,
      ingredients = {
        helper.item("bolted-flange", 150), 
        helper.item("graphite", 50), 
        helper.item("se-vitalic-epoxy")},
      results = {helper.item("airtight-seal", 200)},
      enabled = false,
      always_show_products = true,
      localised_name = {"recipe-name.airtight-seal-vitalic"},
      lasermill = {helium=100, convert=true, se_variant="space-crafting", se_tooltip_entity="se-space-assembling-machine", unlock="airtight-seal-vitalic", icon_offset={8, -8}}
    }
  })
end

if optionals.experimental then
  data:extend({
    {
      type = "recipe",
      name = "complex-joint-iridium",
      category = "crafting-with-fluid",
      icons = {
        helper.graphic("icons/complex-joint.png"),
        {
          icon = "__space-exploration-graphics__/graphics/icons/iridium-plate.png",
          icon_size = 64,
          scale = 0.25,
          shift = {-8, -8}
        },
       },
      localised_name = {"recipe-name.complex-joint-iridium"},
      energy_required = 64,
      ingredients = {
        helper.item("bearing", 8), 
        helper.item("se-iridium-plate"), 
        helper.preferred({
          helper.item("cermet", 8), 
          helper.item("zirconia", 32), 
          helper.item("plastic-bar", 16)}), 
        helper.item("articulated-mechanism", 48), 
        helper.fluid("lubricant", 40)},
      results = {helper.item("complex-joint", 8)},
      enabled = false,
      always_show_products = true,
    },
    {
      type = "recipe",
      name = "gearbox-iridium",
      category = "advanced-crafting",
      icons = {
        helper.graphic("icons/gearbox.png"),
        {
          icon = "__space-exploration-graphics__/graphics/icons/iridium-plate.png",
          icon_size = 64,
          scale = 0.25,
          shift = {-8, -8}
        },
       },
      energy_required = 48,
      ingredients = {
        helper.item("se-iridium-plate"), 
        helper.item("iron-gear-wheel", (mods["Krastorio2"] and 64 or 80)), 
        helper.item("electric-motor", (mods["Krastorio2"] and 12 or 16))},
      results = {helper.item("gearbox", 16)},
      enabled = false,
      always_show_products = true,
      localised_name = {"recipe-name.gearbox-iridium"}
    },
    {
      type = "recipe",
      name = "hardened-hull-iridium",
      category = "advanced-crafting",
      icons = {
        helper.graphic("icons/hardened-hull.png"),
        {
          icon = "__space-exploration-graphics__/graphics/icons/iridium-plate.png",
          icon_size = 64,
          scale = 0.25,
          shift = {-8, -8}
        },
       },
      energy_required = 16,
      ingredients = {
        helper.item("se-iridium-plate"), 
        helper.item("galvanized-steel-plate", 4), 
        optionals.nickel and {type="item", name="invar-plate", amount=4} or {type="item", name="iron-plate", amount=8}, 
        helper.preferred({
          helper.item("bronze-plate", 16),
          helper.item("brass-plate", 16)}), 
        helper.preferred({helper.item("lead-plate", 8)})},
      results = {helper.item("hardened-hull", 8)},
      enabled = false,
      always_show_products = true,
      localised_name = {"recipe-name.hardened-hull-iridium"},
      lasermill = {helium=30, convert=true, se_variant="space-crafting", se_tooltip_entity="se-space-assembling-machine", unlock="se-heat-shielding-iridium", icon_offset={8, -8}}
    }
  })
end

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
        {icon = "__BrassTacks-Updated__/graphics/icons/zinc-ore.png", icon_size = 64, scale = 0.33, shift={8, -8}},
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