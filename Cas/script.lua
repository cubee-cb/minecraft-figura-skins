-- CassetteFox Figura Script
-- by cubee
--[[

This script does the following:
- Turn off Ears when a hat is worn (Toggle in Action Menu)
- Customise outfit (currently only watch)

]]

require("physBoneAPI") -- by ChloeSpacedOut

-- init config
local configFile = "CassetteFox"
config:setName(configFile)

-- interpret empty config to mean a fresh install
-- config should never be saved outside of running actions,
-- so this should ALWAYS return nil on remotes
local freshInstall = next(config:load()) == nil

-- hide vanilla model
vanilla_model.PLAYER:setVisible(false)

-- BACKFACE CULLING WOOO
models:setPrimaryRenderType("TRANSLUCENT_CULL")
models:setSecondaryRenderType("EYES")

-- get elements from model
local earsModel = models.model.root.Head.Ears
local watchModel = models.model.root.RightArm.Watch

-- variables
local hatDodge = true
local showWatch = true

--entity init event, used for when the avatar entity is loaded for the first time
function events.entity_init()

end

--tick event, called 20 times per second
function events.tick()

  if (hatDodge) then
    local headItem = player:getItem(6):getID()
    earsModel:setVisible(not (headItem:find("helmet") or headItem:find("cap") or headItem:find("hat")))
  else
    earsModel:setVisible(true)
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

-- functions
function showState(state)
  return state and "SHOWING" or "HIDING"
end

-- sounds
function toggleSound(state)
  if (not player:isLoaded()) then return end
  sounds:playSound("entity.item.pickup", player:getPos(), 0.25, state and 1.5 or 0.5, false)
end

-- pings and keypresses
function pings.actionSetHatDodge(state)
  hatDodge = state
  toggleSound(state)
end

function pings.actionSetWatch(state)
  watchModel:setVisible(state)
  toggleSound(state)
end

-- set up action menu
local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

local actionToggleHatDodge = mainPage:newAction()
  :title("Toggle Hat Dodge")
  :item("minecraft:iron_helmet")
  :hoverColor(0.8, 0.8, 0.3)
  :setOnToggle(function(state)
    pings.actionSetHatDodge(state)
    print(showState(not state) .. " ears when a hat is worn.")
    config:save("hatDodge", state)

    hatDodge = state
  end
)

local actionToggleWatch = mainPage:newAction()
  :title("Toggle Watch")
  :item("minecraft:clock")
  :hoverColor(0.6, 0.9, 0.6)
  :setOnToggle(function(state)
    pings.actionSetWatch(state)
    print("Watch " .. showState(state))
    config:save("showWatch", state)
  end
)

-- send pings from config
if (not freshInstall) then
  pings.actionSetHatDodge(config:load("hatDodge"))
  pings.actionSetWatch(config:load("showWatch"))
end
