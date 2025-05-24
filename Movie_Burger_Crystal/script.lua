
--hide vanilla model
vanilla_model.PLAYER:setVisible(false)

--tick event, called 20 times per second
function events.tick()
  local headItem = player:getItem(6)
  models.skin.root.Head.Helmet:setVisible(headItem:getCount() == 0)
end
