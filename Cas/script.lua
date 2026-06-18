-- Auto generated script file --

require("physBoneAPI")

--hide vanilla model
vanilla_model.PLAYER:setVisible(false)

-- BACKFACE CULLING WOOO
models:setPrimaryRenderType("TRANSLUCENT_CULL")
models:setSecondaryRenderType("EYES")

-- get elements from model
local ears = models.model.root.Head.Ears

--entity init event, used for when the avatar entity is loaded for the first time
function events.entity_init()

end

--tick event, called 20 times per second
function events.tick()

  local headItem = player:getItem(6):getID()
  ears:setVisible(not (headItem:find("helmet") or headItem:find("cap")))

end

--render event, called every time your avatar is rendered
--it have two arguments, "delta" and "context"
--"delta" is the percentage between the last and the next tick (as a decimal value, 0.0 to 1.0)
--"context" is a string that tells from where this render event was called (the paperdoll, gui, player render, first person)
function events.render(delta, context)

end

function events.skull_render(delta, context)

end

-- pings and keypresses
