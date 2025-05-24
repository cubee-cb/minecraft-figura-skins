
require("physBoneAPI")

-- BACKFACE CULLING WOOO
models:setPrimaryRenderType("TRANSLUCENT_CULL")
--models:setSecondaryRenderType("EYES")

local leagueTarget = models.haircan.root.LeagueTarget
local league = models.haircan.root.World.LeagueFollower

local followerPos = vec(0, 0, 0)

--entity init event, used for when the avatar entity is loaded for the first time
function events.entity_init()
  --player functions goes here
  --leftHairPhysBone = physBone:getPhysBone(models.haircan.root.Head.PhysBoneHairLeft)
  --rightHairPhysBone = physBone:getPhysBone(models.haircan.root.Head.PhysBoneHairRight)

  --leftHairPhysBone:setMass(0.2)
  --rightHairPhysBone:setMass(0.2)
  followerPos = leagueTarget:partToWorldMatrix():apply()
end

--tick event, called 20 times per second
function events.tick()
  --code goes here

  -- update league
  local leaguePos = league:partToWorldMatrix():apply()
  local targetPos = leagueTarget:partToWorldMatrix():apply()

  followerPos = followerPos - (followerPos - targetPos) / 10

  league:setPos(followerPos * 16)
end

--render event, called every time your avatar is rendered
--it have two arguments, "delta" and "context"
--"delta" is the percentage between the last and the next tick (as a decimal value, 0.0 to 1.0)
--"context" is a string that tells from where this render event was called (the paperdoll, gui, player render, first person)
function events.render(delta, context)
  --code goes here
end
