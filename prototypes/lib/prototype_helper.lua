local config = require("prototypes.lib.prototype_config")
local self_name = "BrassTacks-Updated"

local helper = {}

---Returns an item definition
---@param name data.ItemID
---@param count uint16?
---@param extra table<any, any>?
function helper.item(name, count, extra)
  if config.log_missing_prototypes and not data.raw.item[name] then
    brasstacks_logger:prototype_warning(name, "item", "Trying to create item definition for item: " .. name .. " which does not exist!")
  end
  local def = {
    type = "item",
    name = name,
    amount = count and count or 1,
    helper_tag = true
  }
  if extra then
    for key, value in pairs(extra) do
      def[key] = value
    end
  end
  return def
end

---Returns a fluid definition
---@param name data.FluidID
---@param volume uint16?
---@param extra table<any, any>?
function helper.fluid(name, volume, extra)
  if config.log_missing_prototypes and not data.raw.fluid[name] then
    brasstacks_logger:prototype_warning(name, "fluid", "Trying to create fluid definition for fluid: " .. name .. " which does not exist!")
  end
  local def = {
    type = "fluid",
    name = name,
    amount = volume,
    helper_tag = true
  }
  if extra then
    for key, value in pairs(extra) do
      def[key] = value
    end
  end
  return def
end

---Returns a preferred prototype definition from a list definition
---Will return the first one that exists. Will log a warning if none exist and return nil
---@param definitions data.IngredientPrototype[]|data.ProductPrototype[]
---@return any|nil
function helper.preferred(definitions)
  for _, def in pairs(definitions) do
    if data.raw[def.type] then
      return def
    elseif config.log_missing_prototypes and def.helper_tag then
      brasstacks_logger:remove_last_prototype_warning(def.name, def.type)
    end
  end
  return nil
end

function parts.optionalIngredient(item, amount)
  if data.raw.item[item] then
    return {type="item", name=item, amount=amount}
  end
end

---Returns an icon definition from the classic or galdoc icons
---@param name string
---@param size data.SpriteSizeType? If nil it will default to config.default_icon_size
---@param mod string? If nil it will default to self_name
---@param extra table<any, any>? Extra data to add to the definition 
---@return data.IconData
function helper.graphic(name, size, mod, extra)
  size = size or config.default_icon_size
  mod = mod or self_name
  if not mods[mod] then 
    mod = self_name
    brasstacks_logger.warn("Trying to load an icon " .. name .. " from " .. mod .. ", but " .. mod .. " isn't enabled!")
  end

  local prefix = "__" .. mod .. "__/"
  if settings.startup["brasstacks-classic-icons"].value then
    prefix = prefix .. "graphics/classic/"
  else
    prefix = prefix .. "graphics/galdoc/"
  end
  local path = prefix .. icon
  local def = { icon = path, icon_size = size }
  if extra then
    for key, value in pairs(extra) do
      def[key] = value
    end
  end
  return def
end
---Returns an icon definition from the root icon directory
---@param name string
---@param size data.SpriteSizeType? If nil it will default to config.default_icon_size
---@param mod string? If nil it will default to self_name
---@param extra table<any, any>? Extra data to add to the definition 
---@return data.IconData
function helper.icon(name, size, mod, extra)
  size = size or config.default_icon_size
  mod = mod or self_name
  if not mods[mod] then 
    mod = self_name
    brasstacks_logger.warn("Trying to load an icon " .. name .. " from " .. mod .. ", but " .. mod .. " isn't enabled!")
  end

  local path = "__" .. mod .. "__/graphics/icons/" .. icon
  local def = { icon = path, icon_size = size }
  if extra then
    for key, value in pairs(extra) do
      def[key] = value
    end
  end
  return def
end

return helper