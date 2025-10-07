local misc = require("__pf-functions__/misc")

if misc.difficulty < 3 then
    return
end

local electroplater_pipes = assembler2pipepictures()
electroplater_pipes.south =
{
  filename = "__BrassTacks__/graphics/entity/pipe_connector.png",
  priority = "extra-high",
  width = 88,
  height = 61,
  shift = util.by_pixel(0, -31.25),
  scale = 0.5
}

local electroplater = {
    type = "assembling-machine",
    name = "electroplating-machine",
    icon = "__BrassTacks__/graphics/icons/electroplating-machine.png",
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.1, result = "electroplating-machine"},
    fast_replaceable_group = "electroplating-machine",
    max_health = 300,
    corpse = "chemical-plant-remnants",
    dying_explosion = "chemical-plant-explosion",
    circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions.create_vector(
        universal_connector_template,
        {
            { variation = 26, main_offset = util.by_pixel(40, 32), shadow_offset = util.by_pixel(35, 31), show_shadow = true },
            { variation = 26, main_offset = util.by_pixel(40, 32), shadow_offset = util.by_pixel(35, 31), show_shadow = true },
            { variation = 26, main_offset = util.by_pixel(40, 32), shadow_offset = util.by_pixel(35, 31), show_shadow = true },
            { variation = 26, main_offset = util.by_pixel(40, 32), shadow_offset = util.by_pixel(35, 31), show_shadow = true }
        }
    ),
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = data.raw["assembling-machine"]["chemical-plant"].damaged_trigger_effect,
    module_slots = 2,
    allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
    graphics_set = {
      animation = {
        layers = {
          {
            filename = "__BrassTacks__/graphics/entity/electroplating-machine.png",
            width = 192,
            height = 192,
            frame_count = 1,
            line_length = 1,
            repeat_count = 120,
            scale = 0.5    
          },
          {
            filename = "__BrassTacks__/graphics/entity/electroplating-machine-shadow.png",
            draw_as_shadow = true,
            width = 384,
            height = 192,
            frame_count = 1,
            line_length = 1,
            repeat_count = 120,
            shift = {1.5, 0},
            scale = 0.5    
          }
        }
      },
      working_visualisations = {
          {
            animation = {
              filename = "__BrassTacks__/graphics/entity/electroplating-machine-light.png",
              width = 192,
              height = 192,
              draw_as_glow = true,
              frame_count = 7,
              line_length = 7,
              scale = 0.5,
              frame_sequence = {
                1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,4,3, --17
                1,1,1,1,1,1,1,1,1,1,1,1,6,7,5, --32
                1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,3,4,1,4, --53
                1,1,1,1,1,1,1,1,1,1,1,7,5,6, --68
                1,1,1,1,2,3,4,7, --76
                1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,6,7, --99
                1,1,1,5,4,3,4,2,3,2, --109
                1,1,1,1,1,1,1,5,6,7,4
              }
            }
          }
        }
    },
    impact_category = "metal-large",
    open_sound = {filename = "__base__/sound/open-close/fluid-open.ogg", volume = 0.5},
    close_sound = {filename = "__base__/sound/open-close/fluid-close.ogg", volume = 0.5},
    working_sound_old = mods["space-age"] and {
        sound =
        {
          {
            filename = "__space-age__/sound/entity/electromagnetic-plant/electromagnetic-plant-loop.ogg",
            volume = 0.8
          }
        },
        audible_distance_modifier = 1,
        fade_in_ticks = 4,
        fade_out_ticks = 4
    } or table.deepcopy(data.raw["assembling-machine"]["chemical-plant"].working_sound),
    working_sound = {
      main_sounds = table.deepcopy(data.raw["assembling-machine"]["chemical-plant"].working_sound),
      sound_accents = {
        {
          sound = {filename = "__base__/sound/item/electric-large-inventory-pickup.ogg", volume = 0.5},
          frame = 30,
          audible_distance_modifier = 0.4
        },
        {
          sound = {filename = "__base__/sound/item/electric-large-inventory-move.ogg", volume = 0.5},
          frame = 65,
          audible_distance_modifier = 0.4
        },
        {
          sound = {filename = "__base__/sound/item/electric-large-inventory-pickup.ogg", volume = 0.5},
          frame = 98,
          audible_distance_modifier = 0.4
        },
        {
          sound = {filename = "__base__/sound/item/electric-large-inventory-move.ogg", volume = 0.5},
          frame = 117,
          audible_distance_modifier = 0.4
        },
        {
          sound = {filename = "__base__/sound/item/electric-small-inventory-pickup.ogg", volume = 0.35},
          frame = 15,
          audible_distance_modifier = 0.4
        },
        {
          sound = {filename = "__base__/sound/item/electric-small-inventory-pickup.ogg", volume = 0.35},
          frame = 49,
          audible_distance_modifier = 0.4
        },
        {
          sound = {filename = "__base__/sound/item/electric-small-inventory-pickup.ogg", volume = 0.35},
          frame = 73,
          audible_distance_modifier = 0.4
        },
        {
          sound = {filename = "__base__/sound/item/electric-small-inventory-pickup.ogg", volume = 0.35},
          frame = 103,
          audible_distance_modifier = 0.4
        }
      }
    },
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 1 }
    },
    energy_usage = "250kW",
    crafting_categories = {"electroplating"},
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = electroplater_pipes,
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections =
        {
          {
            flow_direction="input",
            direction = defines.direction.north,
            position = {0, -1},
          }
        },
        secondary_draw_orders = {north = -1, west = -1, east = -1}
      },
      {
        production_type = "output",
        pipe_picture = electroplater_pipes,
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections =
        {
          {
            flow_direction="output",
            direction = defines.direction.south,
            position = {0, 1}
          }
        },
        secondary_draw_orders = {north = -1, west = -1, east = -1}
      }
    }
}

local electroplater2 = table.deepcopy(electroplater)

electroplater2.name = "advanced-electroplating-machine"
electroplater2.minable.result = "advanced-electroplating-machine"
electroplater2.icon = "__BrassTacks__/graphics/icons/advanced-electroplating-machine.png"
electroplater2.graphics_set.animation.layers[1].filename = "__BrassTacks__/graphics/entity/advanced-electroplating-machine.png"
electroplater2.energy_usage = "300kW"
electroplater2.crafting_speed = 2
electroplater2.module_slots = 4
if mods["quality"] then
    electroplater2.effect_receiver = { base_effect = { productivity = mods["space-age"] and 1 or 0.5 }}
else
    electroplater2.energy_source.emissions_per_minute = nil
end

data:extend({electroplater, electroplater2})