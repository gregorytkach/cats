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
    
    self._buttonRemove9Cells = self:createButton(managerResources:getAsButton(EResourceType.ERT_STATE_GAME_BUTTON_REMOVE_9_CELLS))
    
    
    --todo: rewrite '0'
        
    self._labelCountRemove9Cells = self:createLabel('0', EFontType.EFT_2)
    self._sourceView:insert(self._labelCountRemove9Cells:sourceView())

    self._labelCountRemoveBottomRow = self:createLabel('0', EFontType.EFT_2)
  
    self._labelCountShuffle = self:createLabel('0', EFontType.EFT_2)
   
end

function ViewPurchases.placeViews(self)
    
    ViewBase.placeViews(self)
    
    self._buttonRemoveBottomRow:sourceView().x = - self._buttonRemoveBottomRow:realWidth() / 2 - self._buttonShuffle:realWidth() / 2
    self._buttonRemove9Cells:sourceView().x = self._buttonRemove9Cells:realWidth() / 2 + self._buttonShuffle:realWidth() / 2
    
    self._labelCountRemove9Cells:sourceView().x = self._buttonRemove9Cells:sourceView().x
    self._labelCountRemove9Cells:sourceView().y = self._buttonRemove9Cells:sourceView().y + self._buttonRemove9Cells:realHeight() * 0.3
    
    self._labelCountRemoveBottomRow:sourceView().x = self._buttonRemoveBottomRow:sourceView().x
    self._labelCountRemoveBottomRow:sourceView().y = self._buttonRemoveBottomRow:sourceView().y + self._buttonRemoveBottomRow:realHeight() * 0.3
    
    self._labelCountShuffle:sourceView().x = self._buttonShuffle:sourceView().x
    self._labelCountShuffle:sourceView().y = self._buttonShuffle:sourceView().y + self._buttonShuffle:realHeight() * 0.3
    
end

function ViewPurchases.cleanup(self)
    
    
    self._buttonShuffle:cleanup()
    self._buttonShuffle = nil
    
    self._buttonRemoveBottomRow:cleanup()
    self._buttonRemoveBottomRow = nil
    
    self._buttonRemove9Cells:cleanup()
    self._buttonRemove9Cells = nil
    
    self._labelCountRemove9Cells:cleanup()
    self._labelCountRemove9Cells = nil
    
    self._labelCountRemoveBottomRow:cleanup()
    self._labelCountRemoveBottomRow = nil
    
    self._labelCountShuffle:cleanup()
    self._labelCountShuffle = nil
    
    self._sourceView:removeSelf()
    self._sourceView = nil
    
    ViewBase.cleanup(self)
    
end



