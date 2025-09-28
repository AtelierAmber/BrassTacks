local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")
local cu = require("category-utils")

local advfitting = "bolted-flange"
if mods["bzcarbon"] or mods["BrimStuff"] then
  advfitting = "airtight-seal"
end

if mods["space-exploration"] then
  rm.AddIngredient("se-vulcanite-rocket-fuel", advfitting, 1)
  rm.RemoveProduct("se-core-fragment-omni", "zinc-ore", 3)

  if parts.gyroscope then
    -- gyroscope already added - this is mostly a consolation prize
    rm.RemoveIngredient("rocket-control-unit", "iron-plate", 5)
    rm.RemoveIngredient("rocket-control-unit", "aluminum-plate", 5)
  end
end

if mods["Krastorio2"] then
  if not parts.nickel then
    local ing = {}
    ing = data.raw.recipe["pumpjack"].ingredients
    data.raw.recipe["kr-mineral-water-pumpjack"].ingredients = ing
  end

  if mods["bzlead"] and parts.experimental then
    rm.RemoveIngredient("kr-fluid-storage-1", "lead-plate", 10)
    rm.RemoveIngredient("kr-fluid-storage-2", "lead-plate", 30)
    rm.RemoveIngredient("kr-advanced-furnace", "lead-plate", 20)
  end

  if rm.CheckIngredient("chemical-science-pack", "sulfuric-acid") then
    data.raw.recipe["chemical-science-pack"].category = data.raw.recipe["logistic-science-pack"].category
    rm.RemoveIngredient("chemical-science-pack", "sulfuric-acid", 999)
    rm.ReplaceIngredient("chemical-science-pack", "glass", "battery", 5)
  end

  if not mods["space-exploration"] then
    if rm.CheckIngredient("production-science-pack", "fast-transport-belt") then
      rm.AddIngredient("production-science-pack", "kr-steel-pump", 1)
    end
    if rm.CheckIngredient("utility-science-pack", "rocket-fuel") and parts.experimental then
        rm.AddIngredient("utility-science-pack", "complex-joint", 5)
    end
  end
end

if false then
  --i hate deleting things so i wont
  --this will not work, delivery cannons are designed to not be removable-from and will quickly clog
  --the cannon sending logic also assumes exactly one output item from the recipe (the packed capsule)

  local function add_catalyst(recipe, ingredient, amount, losschance, scrap, scrap_amount)
    rm.AddIngredient(recipe, ingredient, amount)
    rm.AddProductRaw(recipe, {type="item", name=ingredient, amount=amount, probability=1.0 - losschance, catalyst_amount=amount})
    if scrap then
      rm.AddProductRaw(recipe, {type="item", name=scrap, amount=scrap_amount, probability=losschance})
    end
  end

  for k, v in pairs(se_delivery_cannon_recipes) do
    local recname = "se-delivery-cannon-package-" .. (v.name or "NOTHING-AT-ALL")
    if data.raw.recipe[recname] then
      add_catalyst(v.name, "skyseeker-armature", 1, 0.005, "se-scrap", 40)
    end
  end
end

if mods["Krastorio2"] or parts.nickelExperiment or parts.drill or data.raw.item["skyseeker-armature"] then
  cu.moveItem("articulated-mechanism", "articulated-components", "a")
  cu.moveItem("inserter-parts", "articulated-components", "b")
  cu.moveItem("automation-core", "articulated-components", "c")
  cu.moveItem("motorized-articulator", "articulated-components", "d")
  cu.moveItem("complex-joint", "articulated-components", "e")
  cu.moveItem("machining-tool", "articulated-components", "f")
  cu.moveItem("advanced-machining-tool", "articulated-components", "g")
  cu.moveItem("gimbaled-thruster", "articulated-components", "h")
  cu.moveItem("skyseeker-armature", "articulated-components", "i")
  cu.moveItem("industrial-drill-head", "articulated-components", "j")
end

if mods["space-exploration"] then
  cu.moveItem("gimbaled-thruster", "rocket-part", "p")
  cu.moveItem("skyseeker-armature", "intersurface-part", "r")
end

if data.raw.recipe["airtight-seal"] or parts.nickelExperiment then
  if not (parts.nickelExperiment and data.raw.recipe["airtight-seal"] and data.raw.recipe["titanium-palladium-flange"] and mods["space-exploration"]) then
    cu.moveItem("empty-barrel", "plumbing-components", "a")
    cu.moveRecipe("empty-barrel", "plumbing-components", "a")
  end
  cu.moveItem("bolted-flange", "plumbing-components", "b")
  cu.moveItem("gasket", "plumbing-components", "c")
  cu.moveItem("airtight-seal", "plumbing-components", "c")
  cu.moveItem("titanium-palladium-flange", "plumbing-components", "d")
  cu.moveRecipe("titanium-palladium-flange", "plumbing-components", "d")
  cu.moveItem("invar-valve", "plumbing-components", "e")
  cu.moveItem("flow-controller", "plumbing-components", "f")
  cu.moveItem("advanced-flow-controller", "plumbing-components", "g")
  cu.moveItem("rocket-engine-nozzle", "plumbing-components", "h")
  cu.moveRecipe("rocket-engine-nozzle", "plumbing-components", "h")
  cu.moveItem("self-regulating-valve", "plumbing-components", "i")
end

if mods["space-exploration"] then
  cu.moveItem("rocket-engine-nozzle", "rocket-part", "o")
  cu.moveRecipe("rocket-engine-nozzle", "rocket-part", "o")
end

if (parts.experimental and parts.nickelExperiment) or not mods["IfNickel-Updated"] then
  cu.moveItem("iron-gear-wheel", "rotary-components", "a")
  cu.moveItem("flywheel", "rotary-components", "b")
  cu.moveItem("drive-belt", "rotary-components", "c")
  cu.moveItem("brass-balls", "rotary-components", "d")
  cu.moveItem("bearing", "rotary-components", "e")
  cu.moveItem("cooling-fan", "rotary-components", "f")
  if parts.gyroscope then
    cu.moveItem(parts.gyroscope, "rotary-components", "g")
  end
  if not mods["IfNickel-Updated"] then
    cu.moveItem("motor", "rotary-components", "h")
    cu.moveItem("electric-motor", "rotary-components", "i")
    cu.moveItem("engine-unit", "rotary-components", "j")
    cu.moveItem("electric-engine-unit", "rotary-components", "k")
  end
else if parts.experimental and mods["Krastorio2"] then
  cu.moveItem("flywheel", "gear-components", "g")
  cu.moveItem("brass-balls", "gear-components", "h")
  cu.moveItem("bearing", "gear-components", "i") -- 9 gear components. one extra slot will be taken up by the alt gearbox if SE is installed.
end end

if parts.experimental and mods["Krastorio2"] then
  cu.moveItem("iron-gear-wheel", "gear-components", "a")
  cu.moveItem("kr-steel-gear-wheel", "gear-components", "b")
  cu.moveItem("kr-imersium-gear-wheel", "gear-components", "c")
  cu.moveItem("gearbox", "gear-components", "d")
  cu.moveItem("advanced-gearbox", "gear-components", "e")
  cu.moveItem("elite-gearbox", "gear-components", "f")
end

if parts.experimental or mods["Krastorio2"] then
  cu.moveItem("iron-stick", "frame-components", "a")
  cu.moveItem("iron-beam", "frame-components", "b")
  cu.moveItem("kr-steel-beam", "frame-components", "c")
  if mods["Krastorio2"] then
    cu.moveItem("galvanized-steel-plate", "frame-components", "ca")
  end
  cu.moveItem("kr-imersium-beam", "frame-components", "d")
  cu.moveItem("hardened-hull", "frame-components", "e")
  cu.moveRecipe("hardened-hull-iridium", "frame-components", "f")
  cu.moveItem("low-density-structure", "frame-components", "g")
  cu.moveRecipe("low-density-structure", "frame-components", "g")
  cu.moveRecipe("low-density-structure-nanotubes", "frame-components", "ga")
  cu.moveRecipe("se-low-density-structure-beryllium", "frame-components", "gb")
  if mods["LunarLandings"] then
    cu.moveRecipe("ll-low-density-structure-aluminium", "frame-components", "h")
    cu.moveItem("ll-heat-shielding", "frame-components", "i")
    cu.moveRecipe("ll-heat-shielding", "frame-components", "i")
  end
end
