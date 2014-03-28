

ViewPopupWin = classWithSuper(ViewPopupCatsBase, 'ViewPopupWin')

--
-- Properties
--

--function ViewPopupWin.setRewardCurrency(self, value)
--    assert(value ~= nil)
--    
--    self._labelRewardCount:setValue(value)
--end

--
-- Methods
--


function ViewPopupWin.init(self, params)
    
    ViewPopupCatsBase.init(self, params)
    
    local managerResources  = GameInfo:instance():managerResources()
    local managerString     =  GameInfo:instance():managerString()
    
    self:initBackground(managerResources:getPopupBackground(self._controller:getType()))
    self:initTitle(EStringType.EST_POPUP_WIN_TITLE)
    
    self._animationCat = managerResources:getAsAnimation(EResourceType.ERT_POPUP_WIN_ANIMATION_CAT)
    self._sourceView:insert(self._animationCat)
    
    self._animationCat:play()
    
    self._viewTile   = self:createSprite(managerResources:getAsImage(EResourceType.ERT_POPUP_WIN_VIEW_TILE))
   
    local buttonClose = self:createButton(managerResources:getAsButton(EResourceType.ERT_BUTTON_GREEN), 
    nil, 
    managerString:getString(EStringType.EST_POPUP_WIN_BUTTON_CLOSE), 
    EFontType.EFT_1)
    buttonClose:label():sourceView():setColorHex("0xE5FBFF")
    self:setButtonClose(buttonClose)
    
    self._labelText = self:createLabel(GameInfo:instance():managerString():getString(EStringType.EST_POPUP_WIN_TEXT), EFontType.EFT_1)
    
    self._labelTilesCount = self:createLabel("15", EFontType.EFT_0, ELabelTextAlign.ELTA_RIGHT)
    
    
end


function ViewPopupWin.placeViews(self)
    
    local realHeight = self._background:realHeight()
    local realWidth  = self._background:realWidth()
    
    self._labelTitle:sourceView().x = 0
    self._labelTitle:sourceView().y = 0 - realHeight / 2 + 25 + self._labelTitle:realHeight() / 2

    self._animationCat.x = - realWidth / 2 + self._animationCat.contentWidth / 2 + 40
    self._animationCat.y =  0

    self._viewTile:sourceView().x = realWidth * 0.2
    self._viewTile:sourceView().y = self._viewTile:realHeight() / 2 
   
    self._buttonClose:sourceView().x = 0
    self._buttonClose:sourceView().y = 0 + realHeight / 2 - self._buttonClose:realHeight() * 0.25 
    
    self._labelText:sourceView().x = self._viewTile:sourceView().x
    self._labelText:sourceView().y = self._viewTile:sourceView().y - self._viewTile:realHeight() / 2 -  self._labelText:realHeight() / 2
    
    self._labelTilesCount:sourceView().x = self._viewTile:sourceView().x
    self._labelTilesCount:sourceView().y = self._viewTile:sourceView().y + self._viewTile:realHeight() / 2 + self._labelTilesCount:realHeight() / 2
    
end

function ViewPopupWin.cleanup(self)
    
    self._animationCat:removeSelf()
    self._animationCat = nil
    
    self._viewTile:cleanup()
    self._viewTile = nil
    
    self._labelText:cleanup()
    self._labelText = nil
    
    self._labelTilesCount:cleanup()
    self._labelTilesCount = nil
    
    ViewPopupCatsBase.cleanup(self)
    
end
