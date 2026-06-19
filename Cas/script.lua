-- Auto generated script file --

require("physBoneAPI")

-- init config
local configFile = "CassetteFox"
config:setName(configFile)

-- hide vanilla model
vanilla_model.PLAYER:setVisible(false)

-- BACKFACE CULLING WOOO
models:setPrimaryRenderType("TRANSLUCENT_CULL")
models:setSecondaryRenderType("EYES")

-- get elements from model
local ears = models.model.root.Head.Ears

-- variables
local hatDodge = true

--entity init event, used for when the avatar entity is loaded for the first time
function events.entity_init()

end

--tick event, called 20 times per second
function events.tick()

  if (hatDodge) then
    local headItem = player:getItem(6):getID()
    ears:setVisible(not (headItem:find("helmet") or headItem:find("cap") or headItem:find("hat")))
  else
    ears:setVisible(true)
  end

end

--render event, called every time your avatar is rendered
--it have two arguments, "delta" and "context"
--"delta" is the percentage between the last and the next tick (as a decimal value, 0.0 to 1.0)
--"context" is a string that tells from where this render event was called (the paperdoll, gui, player render, first person)
function events.render(delta, context)

end

function events.skull_render(delta, context)

end

-- local sounds
function toggleSound()
  sounds:playSound("entity.item.pickup", player:getPos(), 1, 2, false)
end

-- pings and keypresses
function pings.actionSetHatDodge(_hatDodge)
  hatDodge = _hatDodge
end

-- set up action menu
local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

hatDodge = true
local actionToggleHatDodge = mainPage:newAction()
  :title("Toggle Hat Dodge")
  :item("minecraft:iron_helmet")
  :hoverColor(1, 0, 1)
  :onLeftClick(function()
    hatDodge = not hatDodge
    pings.actionSetHatDodge(hatDodge)

    print("Now", hatDodge and "HIDING" or "SHOWING", "ears when a hat is worn.")
    toggleSound()
    config:save("hatDodge", hatDodge)
  end)

-- set pings from config
pings.actionSetHatDodge(config:load("hatDodge"))
