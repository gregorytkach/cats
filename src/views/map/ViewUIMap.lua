ViewUIMap = classWithSuper(ViewBase, 'ViewUIMap')

--
-- Properties
--

function ViewUIMap.setViewEnergy(self, value)
    assert(value ~= nil)
    
    self._viewEnergy = value
    self._sourceView:insert(value:sourceView())
end

function ViewUIMap.buttonFreeEnergy(self)
    return self._buttonFreeEnergy
end

function ViewUIMap.buttonShop(self)
    return self._buttonShop
end

--
-- Methods
--

function ViewUIMap.init(self, params)
    ViewBase.init(self, params)
    
    self._sourceView        = display.newGroup()
    
    local managerResources = GameInfo:instance():managerResources()
    
    self._viewStars         = self:createSprite(managerResources:getAsImage(EResourceType.ERT_STATE_MAP_VIEW_STARS))
    self._buttonShop        = self:createButton(managerResources:getAsButton(EResourceType.ERT_STATE_MAP_BUTTON_SHOP))
    self._buttonFreeEnergy  = self:createButton(managerResources:getAsButton(EResourceType.ERT_STATE_MAP_BUTTON_FREE_ENERGY))
    
end

function ViewUIMap.placeViews(self)
    
    self._buttonShop:sourceView().x = application.margin_right - self._buttonShop:realWidth() / 2 - 5
    self._buttonShop:sourceView().y = application.margin_top   + self._buttonShop:realHeight() / 2
    
    self._buttonFreeEnergy:sourceView().x = self._buttonShop:sourceView().x - self._buttonShop:realWidth() / 2 - self._buttonFreeEnergy:realWidth() / 2 - 5 
    self._buttonFreeEnergy:sourceView().y = self._buttonShop:sourceView().y
    
    self._viewStars:sourceView().x = application.margin_left + self._viewStars:realWidth() / 2
    self._viewStars:sourceView().y = application.margin_top  + self._viewStars:realHeight() / 2
    
    self._viewEnergy:placeViews()
    self._viewEnergy:sourceView().x = self._viewStars:sourceView().x
    self._viewEnergy:sourceView().y = self._viewStars:sourceView().y + self._viewStars:realHeight() / 2 + self._viewEnergy:realHeight() / 2
    
    ViewBase.placeViews(self)
end

function ViewUIMap.cleanup(self)
    
    self._buttonShop:cleanup()
    self._buttonShop = nil
    
    self._buttonFreeEnergy:cleanup()
    self._buttonFreeEnergy = nil
    
    self._viewStars:cleanup()
    self._viewStars = nil
    
    ViewBase.cleanup(self)
end

