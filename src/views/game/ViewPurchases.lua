ViewPurchases = classWithSuper(ViewBase, 'ViewPurchases')

--
-- Properties
--


function ViewPurchases.buttonBuy(self)
    return self._buttonBuy
end

--
-- Methods
--

function ViewPurchases.init(self, params)
    ViewBase.init(self, params)
    
    self._sourceView = display.newGroup()
    
    local managerResources = GameInfo:instance():managerResources()
   
    self._buttonShuffle = self:createButton(managerResources:getAsButton(EResourceType.ERT_STATE_GAME_BUTTON_SHUFFLE))
    self._sourceView:insert(self._buttonShuffle:sourceView())
    
    self._buttonRemoveBottomRow = self:createButton(managerResources:getAsButton(EResourceType.ERT_STATE_GAME_BUTTON_REMOVE_BOTTOM_ROW))
    self._sourceView:insert(self._buttonRemoveBottomRow:sourceView())
    
    self._buttonRemove9Cells = self:createButton(managerResources:getAsButton(EResourceType.ERT_STATE_GAME_BUTTON_REMOVE_9_CELLS))
    self._sourceView:insert(self._buttonRemove9Cells:sourceView())
    
end

function ViewPurchases.placeViews(self)
    
    ViewBase.placeViews(self)
    
    self._buttonRemoveBottomRow:sourceView().x = - self._buttonRemoveBottomRow:realWidth() / 2 - self._buttonShuffle:realWidth() / 2
    self._buttonRemove9Cells:sourceView().x = self._buttonRemove9Cells:realWidth() / 2 + self._buttonShuffle:realWidth() / 2
    
end

function ViewPurchases.cleanup(self)
    
    
    self._buttonShuffle:cleanup()
    self._buttonShuffle = nil
    
    self._buttonRemoveBottomRow:cleanup()
    self._buttonRemoveBottomRow = nil
    
    self._buttonRemove9Cells:cleanup()
    self._buttonRemove9Cells = nil
    
    self._sourceView:removeSelf()
    self._sourceView = nil
    
    ViewBase.cleanup(self)
    
end



