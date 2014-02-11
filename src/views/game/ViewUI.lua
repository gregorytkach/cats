ViewUI = classWithSuper(ViewBase, 'ViewUI')

--
-- Properties
--

function ViewUI.setViewPurchases(self, value)
    
    assert(value ~= nil)
    
    self._viewPurchases = value
    self._sourceView:insert(value:sourceView())
    
end

function ViewUI.setViewProgress(self, value)
    
    assert(value ~= nil)
    
    self._viewProgress = value
    self._sourceView:insert(value:sourceView())
    
end

--function ViewUI.buttonFreeEnergy(self)
--    return self._buttonFreeEnergy
--end
--
--function ViewUI.buttonShop(self)
--    return self._buttonShop
--end

--
-- Methods
--

function ViewUI.init(self, params)
    ViewBase.init(self, params)
    
    self._sourceView       = display.newGroup()
    
    local managerResources = GameInfo:instance():managerResources()
    
    self._buttonPause      = self:createButton(managerResources:getAsButton(EResourceType.ERT_STATE_GAME_BUTTON_PAUSE))
    self._sourceView:insert(self._buttonPause:sourceView())
    
    
    self._viewTurns        = self:createSprite(managerResources:getAsImage(EResourceType.ERT_STATE_GAME_VIEW_TURNS))
    self._sourceView:insert(self._viewTurns:sourceView())
    
end

function ViewUI.placeViews(self)

    self._viewPurchases:placeViews()
    self._viewPurchases:sourceView().x = display.contentCenterX
    self._viewPurchases:sourceView().y = application.margin_top + self._viewPurchases:realHeight() / 2
    
    self._viewProgress:placeViews()
    self._viewProgress:sourceView().x = display.contentCenterX
    self._viewProgress:sourceView().y = application.margin_bottom - self._viewProgress:realHeight() / 2
    
    self._buttonPause:sourceView().x = application.margin_right - self._buttonPause:realWidth() * 0.6
    self._buttonPause:sourceView().y = application.margin_top + self._buttonPause:realHeight() / 2
    
    self._viewTurns:sourceView().x = application.margin_left + self._viewTurns:realWidth() * 0.6
    self._viewTurns:sourceView().y = application.margin_top + self._viewTurns:realHeight() / 2
    
    ViewBase.placeViews(self)
    
end

function ViewUI.cleanup(self)
    
    self._sourceView:removeSelf()
    self._sourceView = nil
    
    self._buttonPause:cleanup()
    self._buttonPause = nil
    
    self._viewTurns:cleanup()
    self._viewTurns = nil
    
    ViewBase.cleanup(self)
end

