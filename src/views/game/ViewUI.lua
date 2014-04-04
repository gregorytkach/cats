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
    
    self._buttonBuy = self:createButton(managerResources:getAsButton(EResourceType.ERT_BUTTON_BUY))
    
    self._labelCountMotion = self:createLabel('0', EFontType.EFT_2)
    
    
end

function ViewUI.placeViews(self)

    
    local widthMax = (application.content.width - display.screenOriginX * 2) - 10
     
    
    self._viewProgress:placeViews()
    
    local scaleWidth = 1
    
    if self._viewProgress:realWidth() > widthMax then
        scaleWidth = widthMax / self._viewProgress:realWidth()
        
    end
    
    self._viewProgress:sourceView().xScale = self._viewProgress:sourceView().xScale * scaleWidth
    self._viewProgress:sourceView().yScale = self._viewProgress:sourceView().xScale
    self._viewProgress._scaleWidth = scaleWidth
    
    self._viewProgress:sourceView().x = display.contentCenterX
    self._viewProgress:sourceView().y = application.margin_bottom - self._viewProgress:realHeight() / 2
    
    
    self._viewPurchases:placeViews()
    self._viewPurchases:sourceView().xScale = self._viewPurchases:sourceView().xScale * scaleWidth
    self._viewPurchases:sourceView().yScale = self._viewPurchases:sourceView().xScale
    
    self._viewPurchases:sourceView().x = display.contentCenterX
    self._viewPurchases:sourceView().y = application.margin_top + self._viewPurchases:realHeight() / 2
    
    self._buttonPause:sourceView().xScale = self._buttonPause:sourceView().xScale * scaleWidth
    self._buttonPause:sourceView().yScale = self._buttonPause:sourceView().xScale
    
    self._buttonPause:sourceView().x = application.margin_right - self._buttonPause:realWidth() * 0.6
    self._buttonPause:sourceView().y = application.margin_top + self._buttonPause:realHeight() / 2
    
    self._viewTurns:sourceView().xScale = self._viewTurns:sourceView().xScale * scaleWidth
    self._viewTurns:sourceView().yScale = self._viewTurns:sourceView().xScale
    
    self._viewTurns:sourceView().x = application.margin_left + self._viewTurns:realWidth() * 0.6
    self._viewTurns:sourceView().y = application.margin_top + self._viewTurns:realHeight() / 2
    
    self._buttonBuy:sourceView().xScale = self._buttonBuy:sourceView().xScale * scaleWidth
    self._buttonBuy:sourceView().yScale = self._buttonBuy:sourceView().xScale
    
    self._buttonBuy:sourceView().x = self._viewTurns:sourceView().x + self._viewTurns:realWidth() * 0.3
    self._buttonBuy:sourceView().y = self._viewTurns:sourceView().y + self._viewTurns:realHeight() * 0.3
    
    self._labelCountMotion:sourceView().xScale = self._labelCountMotion:sourceView().xScale * scaleWidth
    self._labelCountMotion:sourceView().yScale = self._labelCountMotion:sourceView().xScale
    
    self._labelCountMotion:sourceView().x = self._viewTurns:sourceView().x
    self._labelCountMotion:sourceView().y = self._viewTurns:sourceView().y
    
    ViewBase.placeViews(self)
    
end

function ViewUI.cleanup(self)
    
    self._sourceView:removeSelf()
    self._sourceView = nil
    
    self._buttonPause:cleanup()
    self._buttonPause = nil
    
    self._viewTurns:cleanup()
    self._viewTurns = nil
    
    self._buttonBuy:cleanup()
    self._buttonBuy = nil
    
    self._labelCountMotion:cleanup()
    self._labelCountMotion = nil
    
    ViewBase.cleanup(self)
end

