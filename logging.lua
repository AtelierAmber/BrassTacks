local logger = {
  prototype_warnings = {}
}

local DEBUG = __DebugAdapter ~= nil
-- DEBUG = true

function logger.error(message)
  if DEBUG then
    error(message)
  else
    local output = "\n      BRASS TACKS ERROR: " .. message
    local i = 2
    while true do
      local info = debug.getinfo(i, "nSl")
      if not info then
        break
      end

      output = output .. "\n        " .. info.source .. ":" .. info.currentline
      if info.name then
        output = output .. " in function '" .. info.name .. "'"
      else
        output = output .. " in main chunk"
      end

      i = i + 1
    end
    log(output)
  end
end

function logger.warn(message)
  local output = "\n" .. message .. "\n---------------------------------------\n"
  log(output)
end

function logger.prototype_warning(self, name, type, message)
  local key = type .. "." .. name
  if self.prototype_warnings[key] then
    table.insert(self.prototype_warnings[key].outputs, "\n" .. message)
    return
  end
  local output = "\n" .. message .. "\n---------------------------------------\n"
  self.prototype_warnings[key] = {type = type, name = name, outputs = {output}}
end

function logger.remove_last_prototype_warning(self, name, type)
  local key = type .. "." .. name
  local warning = self.prototype_warnings[key]
  if warning then
    table.remove(warning.outputs)
    if #warning.outputs <= 0 then
      self.prototype_warnings[key] = nil
    end
  end
end

function logger.flush(self)
  local output = "\n      BRASS TACKS PROTOTYPE REPORT:"

  output = output .. "\nReferences to missing prototypes: "
  for key, info in pairs(self.prototype_warnings) do
    if not data.raw[info.type][info.name] then
      for _, message in pairs(info.outputs) do
        output = output .. "\n[" .. key .. "] : " .. message
      end
    end
  end
  self.prototype_warnings = {}
  log(output)
end

return logger