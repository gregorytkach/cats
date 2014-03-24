
ViewPopupGameOver = classWithSuper(ViewPopupCatsBase, 'ViewPopupGameOver')


function ViewPopupGameOver.init(self, params)
    ViewPopupCatsBase.init(self, params)
    
    local managerResources  = GameInfo:instance():managerResources()
    local managerString     =  GameInfo:instance():managerString()
    
    self:initBackground(managerResources:getPopupBackground(self._controller:getType()))
    self:initTitle(EStringType.EST_POPUP_GAME_OVER_TITLE)
    
    self._animationCat = managerResources:getAsAnimation(EResourceType.ERT_POPUP_GAME_OVER_ANIMATION_CAT)
    self._sourceView:insert(self._animationCat)
    
    
    self._animationCat:play()

    
    self._viewEnergy   = self:createSprite(managerResources:getAsImage(EResourceType.ERT_POPUP_GAME_OVER_VIEW_ENERGY))
    
    --todo: review "-1"
    self._lavelEnergy  = self:createLabel("-1", EFontType.EFT_0, ELabelTextAlign.ELTA_RIGHT)
    self._lavelEnergy:sourceView():setColorHex("0xFFB600")

    local buttonClose = self:createButton(managerResources:getAsButton(EResourceType.ERT_BUTTON_GREEN), 
    nil, 
    managerString:getString(EStringType.EST_POPUP_GAME_OVER_BUTTON_CLOSE), 
    EFontType.EFT_1)
    buttonClose:label():sourceView():setColorHex("0xE5FBFF")
    self:setButtonClose(buttonClose)
    
end

function ViewPopupGameOver.placeViews(self)
    ViewPopupCatsBase.placeViews(self)
    
    local realHeight = self._background:realHeight()
    local realWidth  = self._background:realWidth()
    
    self._labelTitle:sourceView().x = 0
    self._labelTitle:sourceView().y = 0 - realHeight / 2 + 25 + self._labelTitle:realHeight() / 2
    
    self._animationCat.x = - realWidth / 2 + self._animationCat.contentWidth / 2 + 40
    self._animationCat.y =  0
    

    self._viewEnergy:sourceView().x = self._viewEnergy:realWidth() * 0.75
    self._viewEnergy:sourceView().y = 0 
   
    self._lavelEnergy:sourceView().x = self._viewEnergy:sourceView().x + 0.35 * self._viewEnergy:realWidth()
    self._lavelEnergy:sourceView().y = self._viewEnergy:sourceView().y
  
    self._buttonClose:sourceView().x = 0
    self._buttonClose:sourceView().y = 0 + realHeight / 2 - self._buttonClose:realHeight() * 0.25 
    
end

function ViewPopupGameOver.cleanup(self)
    
    self._animationCat:removeSelf()
    self._animationCat = nil
    
    
    self._viewEnergy:cleanup()
    self._viewEnergy = nil
    
    self._lavelEnergy:cleanup()
    self._lavelEnergy = nil
    
    self._buttonClose:cleanup()
    self._buttonClose = nil
    
    ViewPopupCatsBase.cleanup(self)
end

