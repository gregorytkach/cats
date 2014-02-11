ViewEnergy = classWithSuper(ViewBase, 'ViewEnergy')

--
-- Properties
--


function ViewEnergy.buttonBuy(self)
    return self._buttonBuy
end

--
-- Methods
--

function ViewEnergy.init(self, params)
    ViewBase.init(self, params)
    
    self._sourceView = display.newGroup()
    
    local managerResources = GameInfo:instance():managerResources()
    
    self._view      = self:createSprite(managerResources:getAsImage(EResourceType.ERT_STATE_MAP_VIEW_ENERGY))
    self._buttonBuy = self:createButton(managerResources:getAsButton(EResourceType.ERT_BUTTON_BUY))
    
end

function ViewEnergy.placeViews(self)
    ViewBase.placeViews(self)
    
    self._buttonBuy:sourceView().x = self:realWidth() / 2
end

function ViewEnergy.cleanup(self)
    
    
    self._view:cleanup()
    self._view = nil
    
    self._buttonBuy:cleanup()
    self._buttonBuy = nil
    
    ViewBase.cleanup(self)
    
end



