-- CassetteFox Figura Script
-- by cubee
--[[

This script does the following:
- Turn off Ears when a hat is worn (Toggle in Action Menu)
- Customise outfit (currently only watch)

]]

require("physBoneAPI") -- by ChloeSpacedOut

-----------------
-- init config --
-----------------

local configFile = "CassetteFox"
config:setName(configFile)

-- interpret empty config to mean a fresh install
local freshInstall = next(config:load()) == nil


------------------------------------
-- set model rendering properties --
------------------------------------

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

----------------------
-- figura functions --
----------------------

--entity init event, used for when the avatar entity is loaded for the first time
function events.entity_init()

end

--tick event, called 20 times per second
function events.tick()

  if (hatDodge and vanilla_model.HELMET:getVisible()) then
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

------------
-- sounds --
------------

function toggleSound(state)
  if (not player:isLoaded()) then return end
  sounds:playSound("entity.item.pickup", player:getPos(), 0.25, state and 1.5 or 0.5, false)
end

---------------------
-- pings functions --
---------------------

function pings.actionSetHatDodge(state)
  hatDodge = state
  toggleSound(state)
end

function pings.actionSetWatch(state)
  watchModel:setVisible(state)
  toggleSound(state)
end

function pings.actionSetHelmet(state)
  toggleSound(state)
  vanilla_model.HELMET:setVisible(state)
end

function pings.actionSetArmour(state)
  toggleSound(state)
  vanilla_model.CHESTPLATE:setVisible(state)
  vanilla_model.LEGGINGS:setVisible(state)
  vanilla_model.BOOTS:setVisible(state)
end

----------------------------------------
-- load config and send updated pings --
----------------------------------------

if (not freshInstall) then
  -- remotes do not run pings
  pings.actionSetHatDodge(config:load("hatDodge"))
  pings.actionSetWatch(config:load("showWatch"))
  pings.actionSetArmour(config:load("showArmour"))
  pings.actionSetHelmet(config:load("showHelmet"))
end

------------------------
-- set up action menu --
------------------------

local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

-- hide ears when wearing a helmet toggle
local actionToggleHatDodge = mainPage:newAction()
  :title("Enable Hat Dodge")
  :toggleTitle("Disable Hat Dodge")
  :item("minecraft:iron_helmet")
  :hoverColor(0.8, 0.8, 0.3)
  :setOnToggle(function(state)
    pings.actionSetHatDodge(state)
    config:save("hatDodge", state)

    hatDodge = state
  end)
  :toggled(config:load("hatDodge"))

-- vanilla helmet toggle
local actionToggleHelmet = mainPage:newAction()
  :title("Show Helmet")
  :toggleTitle("Hide Helmet")
  :item("minecraft:netherite_helmet")
  :hoverColor(0.5, 0.5, 0.5)
  :setOnToggle(function(state)
    pings.actionSetHelmet(state)
    config:save("showHelmet", state)
  end)
  :toggled(config:load("showHelmet"))

-- vanilla armour toggle
local actionToggleHelmet = mainPage:newAction()
  :title("Show Armour")
  :toggleTitle("Hide Armour")
  :item("minecraft:netherite_chestplate")
  :hoverColor(0.5, 0.5, 0.5)
  :setOnToggle(function(state)
    pings.actionSetArmour(state)
    config:save("showArmour", state)
  end)
  :toggled(config:load("showArmour"))

-- watch toggle
local actionToggleWatch = mainPage:newAction()
  :title("Show Watch")
  :toggleTitle("Hide Watch")
  :item("minecraft:clock")
  :hoverColor(0.6, 0.9, 0.6)
  :setOnToggle(function(state)
    pings.actionSetWatch(state)
    config:save("showWatch", state)
  end)
  :toggled(config:load("showWatch"))
