local config = {}

config.log_missing_prototypes = true
config.default_icon_size = 64


config.yield = 1
config.cost = 1
if mods["Krastorio2"] then
  config.yield = 5
  config.cost = 10
  if mods["space-exploration"] then
    config.yield = 15
    config.cost = 20
  end
end

return config