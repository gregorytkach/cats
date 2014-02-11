ViewMapItem = classWithSuper(ViewBase, 'ViewMapItem')

--
-- Properties
--

function ViewMapItem.button(self)
    return self._button
end

--
-- Methods
--

function ViewMapItem.init(self, params)
    ViewBase.init(self, params)
    
    self._sourceView = display.newGroup()
    
    local managerResources = GameInfoBase:instance():managerResources()
    
    self._button = self:createButton(managerResources:getAsButton(EResourceType.ERT_STATE_MAP_BUTTON_ITEM))
    
end

function ViewMapItem.placeViews(self)
    ViewBase.placeViews(self)
    
    self._button:sourceView().x = 0
    self._button:sourceView().y = 0
end

function ViewMapItem.cleanup(self)
    
    self._button:cleanup()
    self._button = nil
    
    ViewBase.cleanup(self)
end



