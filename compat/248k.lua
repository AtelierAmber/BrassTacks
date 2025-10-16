local rm = require("recipe-modify")
local tf = require("techfuncs")
local parts = require("variable-parts")
local cu = require("category-utils")

local advfitting = "bolted-flange"
if mods["bzcarbon"] or mods["BrimStuff-Updated"] then
  advfitting = "airtight-seal"
end

if mods["248k-Redux"] then
  -- electric era
  if parts.experimental then
    rm.ReplaceIngredient("gearbox", "galvanized-steel-plate", "el_materials_ALK", mods["Krastorio2"] and 4 or 2)
    rm.RemoveIngredient("fast-transport-belt", "el_materials_ALK", 1)
    rm.RemoveIngredient("fast-splitter", "el_materials_ALK", 3)
    rm.RemoveIngredient("fast-underground-belt", "el_materials_ALK", 8)
    rm.RemoveIngredient("kr-fast-loader", "el_materials_ALK", 4)

    rm.AddIngredient("el_burner_kerosene_recipe", "flywheel", 5)

    rm.RemoveIngredient("el_arc_furnace_recipe", "steel-plate", 20)
    rm.AddIngredient("el_arc_furnace_recipe", "hardened-hull", 10)

    rm.RemoveIngredient("el_caster_recipe", "steel-plate", 20)
    rm.AddIngredient("el_caster_recipe", "hardened-hull", 10)

    rm.ReplaceIngredient("el_purifier_recipe", "iron-gear-wheel", "articulated-mechanism", 20)

    rm.ReplaceProportional("el_diesel_train_recipe", "iron-gear-wheel", "gearbox", 0.2)
  end

  rm.RemoveIngredient("el_burner_kerosene_recipe", "pipe", 10)
  rm.AddIngredient("el_burner_kerosene_recipe", "engine-unit", 5)

  rm.AddIngredient("el_tank_recipe", "bolted-flange", 8)

  --fission era
  if parts.experimental then
    rm.ReplaceIngredient("fi_crafter_recipe", "iron-gear-wheel", "complex-joint", 10)
    rm.AddIngredient("fi_castor_recipe", "hardened-hull", 20)
    rm.AddIngredient("fu_miner_recipe", "hardened-hull", 20)
    rm.AddIngredient("fi_crusher_recipe", "hardened-hull", 10)

    rm.ReplaceProportional("fi_solid_reactor_recipe", "steel-plate", "hardened-hull", 0.5)
  else
    rm.ReplaceIngredient("fi_crafter_recipe", "iron-gear-wheel", "bearing", 10)
  end

  rm.ReplaceIngredient("fi_crusher_recipe", "iron-gear-wheel", "bearing", 10)
  rm.ReplaceIngredient("fi_fiberer_recipe", "iron-gear-wheel", "bearing", 10)
  rm.ReplaceIngredient("fi_compound_machine_recipe", "iron-gear-wheel", "bearing", 10)

  rm.AddIngredient("fi_empty_solution_recipe", advfitting, 1)

  if mods["aai-industry"] or mods["ThemTharHills-Updated"] then
    rm.ReplaceProportional("fi_crusher_recipe", "engine-unit", "electric-engine-unit", 0.67)
    rm.ReplaceProportional("fi_fiberer_recipe", "engine-unit", "electric-engine-unit", 0.67)
    rm.ReplaceProportional("fi_compound_machine_recipe", "engine-unit", "electric-engine-unit", 0.67)
    tf.removePrereq("electric-engine", "fi_caster_tech")
    tf.addPrereq("fi_crusher_tech", "electric-engine")
  else
    tf.addPrereq("fi_crusher_tech", "lubricant")
  end

  if parts.drill then
    rm.ReplaceIngredient("fu_drill_recipe", "tungsten-carbide", "industrial-drill-head", 1)
    rm.AddIngredient("fu_drill_recipe", "fi_materials_GFK", 3)
    data.raw.item["fu_miner_fuel_item"].fuel_value = "320MJ"
  end

  --fusion era
  --there are several expensive and high tech construction materials by this point. hardened hulls are sort of obsolete
  --also most new machines at this stage are mega energy tech and don't have mechanisms
  if parts.experimental then
    rm.AddIngredient("fu_robo_logistic_recipe", "complex-joint", 1)
    rm.AddIngredient("fu_robo_construction_recipe", "complex-joint", 1)

    if parts.gyroscope then
      rm.AddIngredient("gr_magnet_train_pre_recipe", parts.gyroscope, 10)
      rm.AddIngredient("gr_magnet_wagon_pre_recipe", parts.gyroscope, 1)
      rm.AddIngredient("gr_magnet_tanker_pre_recipe", parts.gyroscope, 1)
    end

    rm.AddIngredient("fu_turbine_recipe", "advanced-gearbox", 10)
  end

  if mods["Krastorio2"] then
    rm.RemoveIngredient("gr_wheel_recipe", "fu_iron", 99999)
    data.raw.recipe["gr_wheel_recipe"].category = "chemistry"
    rm.AddIngredient("gr_wheel_recipe", "fu_copper", 250)
    rm.AddIngredient("gr_wheel_recipe", "248k-zinc-atom", 250)
  else
    data.raw.recipe["gr_wheel_recipe"].category = "fi_refining"
    rm.RemoveIngredient("gr_wheel_recipe", "fu_iron", 250)
    rm.AddIngredient("gr_wheel_recipe", "fu_copper", 125)
    rm.AddIngredient("gr_wheel_recipe", "248k-zinc-atom", 125)
  end

end
