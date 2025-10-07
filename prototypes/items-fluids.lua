local misc = require("__pf-functions__/misc")
local rm = require("__pf-functions__/recipe-manipulation")
local item_sounds = require("__base__/prototypes/item_sounds")
local space_age_item_sounds = "foo"

data:extend({
    {
        type = "item",
        name = "zinc-ore",
        icon = "__BrassTacks__/graphics/icons/zinc-ore.png",
        icon_size = 64,
        mipmap_count = 4,
        pictures = {
          { size = 64, filename = "__BrassTacks__/graphics/icons/zinc-ore.png", scale = 0.5, mipmap_count = 4 },
          { size = 64, filename = "__BrassTacks__/graphics/icons/zinc-ore-1.png", scale = 0.5, mipmap_count = 4 },
          { size = 64, filename = "__BrassTacks__/graphics/icons/zinc-ore-2.png", scale = 0.5, mipmap_count = 4 },
          { size = 64, filename = "__BrassTacks__/graphics/icons/zinc-ore-3.png", scale = 0.5, mipmap_count = 4 }
        },
        subgroup = "raw-resource",
        order = "fa", -- f = copper
        color_hint = { text = "Z" },
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        canonical_cost = 1,
        weight = 2*kg
      },
      {
        type = "item",
        name = "zinc-plate",
        icon = "__BrassTacks__/graphics/classic/icons/zinc-plate.png",
        subgroup = "raw-material",
        order = "a[smelting]-ba",
        color_hint = { text = "Z" },
        inventory_move_sound = item_sounds.metal_small_inventory_move,
        pick_sound = item_sounds.metal_small_inventory_pickup,
        drop_sound = item_sounds.metal_small_inventory_move,
        stack_size = 100,
        default_import_location = "nauvis",
        canonical_cost = 1,
        weight = 1*kg
      },
      {
        type = "item",
        name = "brass-precursor",
        icon = "__BrassTacks__/graphics/classic/icons/brass-precursor.png",
        subgroup = "raw-resource",
        order = "fab",
        color_hint = { text = "B" },
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        canonical_cost = 1,
        weight = 1*kg
      },
      {
        type = "item",
        name = "brass-plate",
        icon = "__BrassTacks__/graphics/classic/icons/brass-plate.png",
        subgroup = "raw-material",
        order = "a[smelting]-bb",
        color_hint = { text = "B" },
        inventory_move_sound = item_sounds.metal_small_inventory_move,
        pick_sound = item_sounds.metal_small_inventory_pickup,
        drop_sound = item_sounds.metal_small_inventory_move,
        stack_size = 100,
        default_import_location = "nauvis",
        canonical_cost = 1,
        weight = 1*kg
      },
      {
        type = "item",
        name = "galvanized-steel-plate",
        icon = "__BrassTacks__/graphics/classic/icons/galvanized-steel-plate.png",
        subgroup = "raw-material",
        order = "a[smelting]-ca",
        color_hint = { text = "G" },
        inventory_move_sound = item_sounds.metal_small_inventory_move,
        pick_sound = item_sounds.metal_small_inventory_pickup,
        drop_sound = item_sounds.metal_small_inventory_move,
        stack_size = 100,
        default_import_location = "nauvis",
        weight = 2.5*kg,
        auto_recycle = false
      },
      {
        type = "item",
        name = "brass-balls",
        icon = "__BrassTacks__/graphics/classic/icons/brass-balls.png",
        subgroup = "intermediate-product",
        order = "c[advanced-intermediates]-1",
        color_hint = { text = "G" },
        inventory_move_sound = item_sounds.low_density_inventory_move,
        pick_sound = item_sounds.low_density_inventory_pickup,
        drop_sound = item_sounds.low_density_inventory_move,
        stack_size = 200,
        default_import_location = "nauvis",
        weight = 0.5*kg
      },
      {
        type = "item",
        name = "bearing",
        icon = "__BrassTacks__/graphics/classic/icons/bearing.png",
        subgroup = "intermediate-product",
        order = "c[advanced-intermediates]-1a",
        color_hint = { text = "G" },
        inventory_move_sound = item_sounds.metal_small_inventory_move,
        pick_sound = item_sounds.metal_small_inventory_pickup,
        drop_sound = item_sounds.metal_small_inventory_move,
        stack_size = 100,
        default_import_location = "nauvis",
        weight = 1.6666*kg
      }
})

if mods["space-age"] then
    space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
    data:extend({
        {
            type = "item",
            name = "brass-asteroid-chunk",
            icon = "__pf-sa-compat__/graphics/icons/brass-asteroid-chunk.png",
            icon_size = 64,
            mipmap_count = 4,
            subgroup = "space-material",
            order = "ca",
            color_hint = { text = "B" },
            inventory_move_sound = item_sounds.resource_inventory_move,
            pick_sound = item_sounds.resource_inventory_pickup,
            drop_sound = item_sounds.resource_inventory_move,
            stack_size = 1,
            default_import_location = "nauvis",
            canonical_cost = 10,
            weight = 100*kg
        },
        {
            type = "item",
            name = "sphalerite",
            icon = "__BrassTacks__/graphics/icons/sphalerite.png",
            icon_size = 64,
            mipmap_count = 4,
            pictures = {
              { size = 64, filename = "__BrassTacks__/graphics/icons/sphalerite.png", scale = 0.5, mipmap_count = 4 },
              { size = 64, filename = "__BrassTacks__/graphics/icons/sphalerite-1.png", scale = 0.5, mipmap_count = 4 },
              { size = 64, filename = "__BrassTacks__/graphics/icons/sphalerite-2.png", scale = 0.5, mipmap_count = 4 },
              { size = 64, filename = "__BrassTacks__/graphics/icons/sphalerite-3.png", scale = 0.5, mipmap_count = 4 }
            },
            subgroup = "raw-resource",
            order = "faa",
            color_hint = { text = "S" },
            inventory_move_sound = item_sounds.resource_inventory_move,
            pick_sound = item_sounds.resource_inventory_pickup,
            drop_sound = item_sounds.resource_inventory_move,
            stack_size = 50,
            default_import_location = "vulcanus",
            canonical_cost = 1,
            weight = 2*kg
        },
        {
            type = "fluid",
            name = "molten-zinc",
            icon = "__pf-sa-compat__/graphics/icons/molten-zinc.png",
            icon_size = 64,
            mipmap_count = 4,
            subgroup = "fluid",
            order = "b[new-fluid]-b[vulcanus]-c",
            default_temperature = 420,
            max_temperature = 2000,
            base_color = {1, 1, 1, 1},
            flow_color = {0.8, 0.8, 0.8, 1},
            visualization_color = {1, 1, 1, 1},
            auto_barrel = false
        },
        {
            type = "item",
            name = "zinc-bacteria",
            icon = "__pf-sa-compat__/graphics/icons/zinc-bacteria.png",
            icon_size = 64,
            mipmap_count = 4,
            pictures = {
                { size = 64, filename = "__pf-sa-compat__/graphics/icons/zinc-bacteria.png", scale = 0.5, mipmap_count = 4 },
                { size = 64, filename = "__pf-sa-compat__/graphics/icons/zinc-bacteria-1.png", scale = 0.5, mipmap_count = 4 },
                { size = 64, filename = "__pf-sa-compat__/graphics/icons/zinc-bacteria-2.png", scale = 0.5, mipmap_count = 4 },
                { size = 64, filename = "__pf-sa-compat__/graphics/icons/zinc-bacteria-3.png", scale = 0.5, mipmap_count = 4 }
              },
            subgroup = "agriculture-processes",
            order = "b[agriculture]-da",
            inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
            pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
            drop_sound = space_age_item_sounds.agriculture_inventory_move,
            color_hint = { text = "Z" },
            stack_size = 50,
            default_import_location = "gleba",
            canonical_cost = 1,
            weight = 1*kg,
            spoil_ticks = 1 * minute,
            spoil_result = "zinc-ore"
        }
    })
end

if misc.difficulty == 1 then
    return
end

data:extend({
    {
        type = "item",
        name = "pipe-flange",
        icon = "__BrassTacks__/graphics/classic/icons/pipe-flange.png",
        subgroup = "intermediate-product",
        order = "a[basic-intermediates]-da",
        inventory_move_sound = item_sounds.metal_small_inventory_move,
        pick_sound = item_sounds.metal_small_inventory_pickup,
        drop_sound = item_sounds.metal_small_inventory_move,
        stack_size = 100,
        default_import_location = "nauvis",
        weight = 1.25*kg
    },
    {
        type = "item",
        name = "flywheel",
        icon = "__BrassTacks__/graphics/classic/icons/flywheel.png",
        subgroup = "intermediate-product",
        order = "a[basic-intermediates]-aa",
        inventory_move_sound = item_sounds.metal_small_inventory_move,
        pick_sound = item_sounds.metal_small_inventory_pickup,
        drop_sound = item_sounds.metal_small_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        weight = 1.25*kg
    },
    {
        type = "item",
        name = "linkages",
        icon = "__BrassTacks__/graphics/classic/icons/linkages.png",
        subgroup = "intermediate-product",
        order = "a[basic-intermediates]-ba",
        inventory_move_sound = item_sounds.mechanical_inventory_move,
        pick_sound = item_sounds.mechanical_inventory_pickup,
        drop_sound = item_sounds.mechanical_inventory_move,
        stack_size = 100,
        default_import_location = "nauvis",
        weight = 1*kg
    },
    {
        type = "item",
        name = "hardened-hull",
        icon = "__BrassTacks__/graphics/classic/icons/hardened-hull.png",
        subgroup = "intermediate-product",
        order = "c[advanced-intermediates]-1ba",
        inventory_move_sound = item_sounds.metal_large_inventory_move,
        pick_sound = item_sounds.metal_large_inventory_pickup,
        drop_sound = item_sounds.metal_large_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        weight = 2.5*kg
    },
    {
        type = "item",
        name = "fast-gearbox",
        icon = "__BrassTacks__/graphics/classic/icons/fast-gearbox.png",
        subgroup = "intermediate-product",
        order = "c[advanced-intermediates]-1c",
        inventory_move_sound = item_sounds.metal_large_inventory_move,
        pick_sound = item_sounds.metal_large_inventory_pickup,
        drop_sound = item_sounds.metal_large_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        weight = 2.5*kg
    },
    {
        type = "item",
        name = "express-gearbox",
        icon = "__BrassTacks__/graphics/classic/icons/express-gearbox.png",
        subgroup = "intermediate-product",
        order = "c[advanced-intermediates]-1d",
        inventory_move_sound = item_sounds.metal_large_inventory_move,
        pick_sound = item_sounds.metal_large_inventory_pickup,
        drop_sound = item_sounds.metal_large_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        weight = 5*kg
    },
    {
        type = "item",
        name = "complex-joint",
        icon = "__BrassTacks__/graphics/classic/icons/complex-joint.png",
        subgroup = "intermediate-product",
        order = "c[advanced-intermediates]-1e",
        inventory_move_sound = item_sounds.mechanical_inventory_move,
        pick_sound = item_sounds.mechanical_inventory_pickup,
        drop_sound = item_sounds.mechanical_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        weight = 2*kg
    },
    {
        type = "item",
        name = "gyro",
        icon = "__BrassTacks__/graphics/classic/icons/gyro.png",
        subgroup = "intermediate-product",
        order = "c[advanced-intermediates]-1d",
        inventory_move_sound = item_sounds.rocket_control_inventory_move,
        pick_sound = item_sounds.rocket_control_inventory_pickup,
        drop_sound = item_sounds.rocket_control_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        weight = 2*kg
    }
})

if misc.difficulty == 2 then
  return
end

data:extend({
  {
    name = "electroplating",
    type = "recipe-category",
    can_recycle = false
  },
  {
    name = "electroplating",
    type = "item-subgroup",
    group = "intermediate-products",
    order = "g2"
  },
  {
    type = "fluid",
    name = "depleted-zinc-salts",
    icon = "__BrassTacks__/graphics/classic/icons/depleted-zinc-salts.png",
    icon_size = 64,
    mipmap_count = 4,
    subgroup = "fluid",
    order = "a[fluid]-a[water]-c",
    default_temperature = 15,
    base_color = {1, 1, 1, 1},
    flow_color = {0.8, 0.8, 0.8, 1},
    visualization_color = {1, 1, 1, 1}
  },
  {
      type = "item",
      name = "electroplating-machine",
      icon = "__BrassTacks__/graphics/icons/electroplating-machine.png",
      subgroup = mods["space-age"] and "smelting-machine" or "production-machine",
      order = mods["space-age"] and "e" or "ca",
      place_result = "electroplating-machine",
      inventory_move_sound = item_sounds.electric_large_inventory_move,
      pick_sound = item_sounds.electric_large_inventory_pickup,
      drop_sound = item_sounds.electric_large_inventory_move,
      stack_size = 10,
      default_import_location = "nauvis",
      weight = 100*kg
  },
  {
      type = "item",
      name = "advanced-electroplating-machine",
      icon = "__BrassTacks__/graphics/icons/advanced-electroplating-machine.png",
      subgroup = mods["space-age"] and "smelting-machine" or "production-machine",
      order = mods["space-age"] and "f" or "cb",
      place_result = "advanced-electroplating-machine",
      inventory_move_sound = item_sounds.electric_large_inventory_move,
      pick_sound = item_sounds.electric_large_inventory_pickup,
      drop_sound = item_sounds.electric_large_inventory_move,
      stack_size = 10,
      default_import_location = mods["space-age"] and "fulgora" or "nauvis",
      weight = 100*kg
  },
  {
      type = "item",
      name = "galvanized-panel",
      icon = "__BrassTacks__/graphics/classic/icons/galvanized-panel.png",
      subgroup = "electroplating",
      order = "a",
      inventory_move_sound = item_sounds.metal_small_inventory_move,
      pick_sound = item_sounds.metal_small_inventory_pickup,
      drop_sound = item_sounds.metal_small_inventory_move,
      stack_size = 100,
      default_import_location = "nauvis",
      weight = 1*kg,
      auto_recycle = false
  },
  {
      type = "item",
      name = "galvanized-rod",
      icon = "__BrassTacks__/graphics/classic/icons/galvanized-rod.png",
      subgroup = "electroplating",
      order = "b",
      inventory_move_sound = item_sounds.metal_small_inventory_move,
      pick_sound = item_sounds.metal_small_inventory_pickup,
      drop_sound = item_sounds.metal_small_inventory_move,
      stack_size = 100,
      default_import_location = "nauvis",
      weight = 0.5*kg,
      auto_recycle = false
  },
  {
      type = "item",
      name = "galvanized-tubing",
      icon = "__BrassTacks__/graphics/classic/icons/galvanized-tubing.png",
      subgroup = "electroplating",
      order = "c",
      inventory_move_sound = item_sounds.metal_small_inventory_move,
      pick_sound = item_sounds.metal_small_inventory_pickup,
      drop_sound = item_sounds.metal_small_inventory_move,
      stack_size = 100,
      default_import_location = "nauvis",
      weight = 1*kg,
      auto_recycle = false
  },
  {
      type = "item",
      name = "malleable-logarithmic-casing",
      icon = "__BrassTacks__/graphics/classic/icons/malleable-logarithmic-casing.png",
      subgroup = "intermediate-product",
      order = "c[advanced-intermediates]-1b",
      inventory_move_sound = item_sounds.metal_small_inventory_move,
      pick_sound = item_sounds.metal_small_inventory_pickup,
      drop_sound = item_sounds.metal_small_inventory_move,
      stack_size = 100,
      default_import_location = "nauvis",
      weight = 1*kg
  },
  {
      type = "item",
      name = "loadbearing-lattice",
      icon = "__BrassTacks__/graphics/classic/icons/loadbearing-lattice.png",
      subgroup = "intermediate-product",
      order = "c[advanced-intermediates]-1bb",
      inventory_move_sound = item_sounds.metal_large_inventory_move,
      pick_sound = item_sounds.metal_large_inventory_pickup,
      drop_sound = item_sounds.metal_large_inventory_move,
      stack_size = 50,
      default_import_location = "nauvis",
      weight = 2.5*kg
  }
})

if mods["space-age"] then
  data:extend({
    {
      type = "item",
      name = "spurving-bearing",
      icon = "__BrassTacks__/graphics/classic/icons/spurving-bearing.png",
      subgroup = "vulcanus-processes",
      order = "c[tungsten]-d",
      inventory_move_sound = item_sounds.mechanical_inventory_move,
      pick_sound = item_sounds.mechanical_inventory_pickup,
      drop_sound = item_sounds.mechanical_inventory_move,
      stack_size = 50,
      default_import_location = "nauvis",
      weight = 2.5*kg
    }
  })
end

data.raw.item["galvanized-steel-plate"].subgroup = "electroplating"
data.raw.item["galvanized-steel-plate"].order = "d"