brasstacks_logger = require("logging")
local new_data = true

require("prototypes.items")

if new_data then
  require("prototypes.core-recipes")
  require("prototypes.compat.compat-data")
else
  require("prototypes.recipes")
end
require("prototypes.zinc")
require("prototypes.technology")
require("prototypes.particle")
