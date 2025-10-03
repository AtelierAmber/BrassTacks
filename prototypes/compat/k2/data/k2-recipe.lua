local helper = require("prototypes.lib.prototype_helper")
local config = require("prototypes.lib.prototype_config")
local optionals = require("optionals")

if not mods["galdocs-manufacturing"] then
  data.raw.recipe["brass-precursor"] = nil
  local brass_plate = data.raw.recipe["brass-plate"]
  local brass_foundry = data.raw.recipe["brass-plate-foundry"]
  
  if mods["bzaluminum"] then
    --- Brass Plate
    brass_plate.ingredients = {
      helper.item("copper-ore", config.cost), 
      helper.item("zinc-ore", config.cost)
    }
    brass_plate.results = {
      helper.item("brass-plate", config.yield*2)
    }
    brass_plate.main_product = "brass-plate"
    brass_plate.energy_required = 1.6 * config.yield
    --- Foundry, may be disabled via optionals
    if optionals.foundryEnabled then
      brass_foundry.ingredients = {
        helper.item("copper-plate", config.ield),
        helper.item("zinc-plate", config.yield)
      }
      brass_foundry.results = {
        helper.item("brass-plate", config.yield*2)
      }
      brass_foundry.energy_required = 1.6 * config.yield
      brass_foundry.enabled = false
      brass_foundry.category = optionals.foundryEnabled and "founding" or "smelting"
    end
  else
    brass_plate.ingredients = {
      helper.item("copper-plate"),
      helper.item("zinc-plate")
    }
    brass_plate.results = {helper.item("brass-plate", 2)}
    if optionals.foundryEnabled then
      brass_foundry.energy_required = 1.6
    end
  end  
end

---MARK: Brass Intermediates
if settings.startup["brasstacks-experimental-intermediates"].value then
  data:extend({
    {
      type = "recipe",
      name = "elite-gearbox",
      category = "advanced-crafting",
      energy_required = 6,
      ingredients = {
        helper.item("advanced-gearbox"), 
        helper.item("kr-imersium-gear-wheel", 4), 
        helper.item("kr-imersium-beam")},
      results = helper.item("elite-gearbox"),
      enabled = false
    }
  })
  local added = helper.preferred({helper.item("se-heavy-bearing", 4), helper.item("electric-engine-unit")})
  if added then
    table.insert(data.raw.recipe["elite-gearbox"].ingredients, added)
  end
end

---MARK: Enrichment Recipes
data:extend({
  {
    type = "recipe",
    name = "enriched-zinc",
    category = "chemistry",
    energy_required = 3,
    ingredients = {
      helper.item("zinc-ore", 9), 
      helper.fluid("sulfuric-acid", 3), 
      helper.fluid("water", 25, {catalyst_amount = 25})},
    results = {
      helper.item("enriched-zinc", (mods["space-exploration"] and 9) or 6), 
      helper.fluid("kr-dirty-water", 25, {catalyst_amount = 25})},
    main_product = "enriched-zinc",
    enabled = false
    --default white chemplant tint is fine for once!
  },
  {
    type = "recipe",
    name = "enriched-zinc-plate",
    icons = {
      helper.graphic("icons/zinc-plate.png"),
      helper.graphic("icons/enriched-zinc.png", 64, nil, {scale = 0.25, shift = {-8, -8}})},
    category = "smelting",
    energy_required = 16,
    ingredients = {helper.item("enriched-zinc", 5)},
    results = {helper.item("zinc-plate", 5)},
    enabled = false
  },
  {
    type = "recipe",
    name = "dirty-water-filtration-zinc",
    subgroup = "raw-material",
    order = "w013[dirty-water-filtration-zinc]",
    category = "kr-fluid-filtration",
    icons =
    {
      {
        icon = data.raw.fluid["kr-dirty-water"].icon,
        icon_size = data.raw.fluid["kr-dirty-water"].icon_size
      },
      helper.icon("zinc-ore.png", 64, nil, {scale = 0.2, shift = {0, 4}})
    },
    energy_required = 2,
    ingredients = {helper.fluid("kr-dirty-water", 100, {catalyst_amount = 100})},
    results =	{ 
      helper.fluid("water", 90, {catalyst_amount = 90}), 
      helper.item("stone", 1, {probability = 0.3}), 
      helper.item("zinc-ore", 1, {probability = 0.1})},
    crafting_machine_tint =
    {
      primary = {r = 0.75, g = 0.75, b = 1, a = 0.6},
      secondary = {r = 1.0, g = 1.0, b = 1.0, a = 0.9}
    },
    enabled = false
  }
})