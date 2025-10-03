local helper = require("prototypes.lib.prototype_helper")

data:extend({
  type = "technology",
  name = "kr-matter-zinc-processing",
  icons = {
    {
      icon = "__Krastorio2Assets__/technologies/matter-iron.png",
      icon_size = 256,
      icon_mipmaps = 4,
    },
    helper.icon("zinc-ore.png", nil, nil, {icon_mipmaps = 4, scale = 2})
  },
  effects = {},
  prerequisites = { "kr-matter-processing" },
  order = "g-e-e",
  unit = {
    count = 350,
    ingredients = {
      { "production-science-pack", 1 },
      { "utility-science-pack", 1 },
      { "kr-matter-tech-card", 1 },
    },
    time = 45
  }
})