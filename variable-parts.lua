local parts = {}

parts.experimental = settings.startup["brasstacks-experimental-intermediates"].value
parts.nickel = mods["IfNickel-Updated"] and true or false
if parts.nickel then
  parts.steelValve = settings.startup["ifnickel-steel-valve"].value
  parts.nickelExperiment = settings.startup["ifnickel-experimental-intermediates"].value
else
  parts.steelValve = false
  parts.nickelExperiment = false
end

parts.oldicons = not settings.startup["brasstacks-classic-icons"].value

function parts.qualityIconPath(mod, icon)
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

function parts.preferred(ingredients, quantities)
  for k, v in ipairs(ingredients) do
    if data.raw.item[v] then
      return {type="item", name=v, amount=quantities[k]}
    end
  end
end

function parts.optionalIngredient(item, amount)
  if data.raw.item[item] then
    return {type="item", name=item, amount=amount}
  end
end

if mods["bzfoundry"] and not settings.startup["bzfoundry-minimal"].value then
  parts.foundryEnabled = true
else
  parts.foundryEnabled = false
end

if parts.experimental then
  if data.raw.item["gyro"] then
    if settings.startup["brasstacks-gyro-override"].value then
      parts.gyroscope = "gyro"
    end
  else
    parts.gyroscope = "gyroscope"
  end
end

if parts.experimental and data.raw.item["diamond"] and data.raw.item["tungsten-carbide"] and (mods["aai-industry"] or mods["big-mining-drill"] or mods["Krastorio2"] or mods["vtk-deep-core-mining"] or mods["248k"]) then
  parts.drill = true
else
  parts.drill = false
end

return parts
