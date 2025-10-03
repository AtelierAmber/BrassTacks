local helper = require("prototypes.lib.prototype_helper")
local optionals = {}

optionals.experimental = settings.startup["brasstacks-experimental-intermediates"].value
optionals.nickel = mods["IfNickel-Updated"] and true or false
if optionals.nickel then
  optionals.steelValve = settings.startup["ifnickel-steel-valve"].value
  optionals.nickelExperiment = settings.startup["ifnickel-experimental-intermediates"].value
else
  optionals.steelValve = false
  optionals.nickelExperiment = false
end

optionals.oldicons = not settings.startup["brasstacks-classic-icons"].value

optionals.items = {}

function optionals.qualityIconPath(mod, icon)
  local prefix = ""
  --I intend to reuse this function between mods, hence checking for itself and specifying which mod to look in.
  --Other mods may add an alternate recipe and need to look up an icon, etc.
  --Possible that I am over-engineering this system.
  if mod == "brasstacks" and mods["BrassTacks-Updated"] then
    if settings.startup["brasstacks-classic-icons"].value then
      prefix = "__BrassTacks-Updated__/graphics/classic/"
    else
      prefix = "__BrassTacks-Updated__/graphics/galdoc/"
    end
  end
  if prefix ~= "" then
    return prefix .. icon
  end
end

function optionals.preferred(ingredients, quantities)
  for k, v in ipairs(ingredients) do
    if data.raw.item[v] then
      return {type="item", name=v, amount=quantities[k]}
    end
  end
end

function optionals.optionalIngredient(item, amount)
  if data.raw.item[item] then
    return {type="item", name=item, amount=amount}
  end
end

if mods["bzfoundry"] and not settings.startup["bzfoundry-minimal"].value then
  optionals.foundryEnabled = true
else
  optionals.foundryEnabled = false
end

if optionals.experimental then
  if data.raw.item["gyro"] then
    if settings.startup["brasstacks-gyro-override"].value then
      optionals.gyroscope = "gyro"
    end
  else
    optionals.gyroscope = "gyroscope"
  end
end

if optionals.experimental and data.raw.item["diamond"] and data.raw.item["tungsten-carbide"] and (mods["aai-industry"] or mods["big-mining-drill"] or mods["Krastorio2"] or mods["vtk-deep-core-mining"] or mods["248k"]) then
  optionals.drill = true
else
  optionals.drill = false
end

optionals.useadvfitting = mods["bzcarbon"] or mods["BrimStuff-Updated"]

return optionals
