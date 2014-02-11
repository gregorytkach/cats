

ViewPopupPause = classWithSuper(ViewPopupCatsBase, 'ViewPopupPause')

--
-- Properties
--

--function ViewPopupPause.setRewardCurrency(self, value)
--    assert(value ~= nil)
--    
--    self._labelRewardCount:setValue(value)
--end

--
-- Methods
--


function ViewPopupPause.init(self, params)
    
    ViewPopupCatsBase.init(self, params)
    
    local managerResources  = GameInfo:instance():managerResources()
    local managerString     =  GameInfo:instance():managerString()
    
    self:initBackground(managerResources:getPopupBackground(self._controller:getType()))
    self:initTitle(EStringType.EST_POPUP_PAUSE_TITLE)
   
    local buttonClose = self:createButton(managerResources:getAsButton(EResourceType.ERT_BUTTON_GREEN), 
    nil, 
    managerString:getString(EStringType.EST_POPUP_PAUSE_BUTTON_CLOSE), 
    EFontType.EFT_1)
    buttonClose:label():sourceView():setColorHex("0xE5FBFF")
    self:setButtonClose(buttonClose)
    
    self._buttonReplay = self:createButton(managerResources:getAsButton(EResourceType.ERT_BUTTON_BLUE), 
    nil, 
    managerString:getString(EStringType.EST_POPUP_PAUSE_BUTTON_REPLAY), 
    EFontType.EFT_1)
    
end


function ViewPopupPause.placeViews(self)
    
    local realHeight = self._background:realHeight()
    local realWidth  = self._background:realWidth()
    
    self._labelTitle:sourceView().x = 0
    self._labelTitle:sourceView().y = 0 - realHeight / 2 + 20 + self._labelTitle:realHeight() / 2
   
    self._buttonClose:sourceView().x =  0.25 * realWidth
    self._buttonClose:sourceView().y = 0 + realHeight / 2 - self._buttonClose:realHeight() * 0.25 
    
    self._buttonReplay:sourceView().x =  - 0.25 * realWidth
    self._buttonReplay:sourceView().y = 0 + realHeight / 2 - self._buttonReplay:realHeight() * 0.25 
    
    local xScale = self._buttonReplay:realWidth() / self._buttonClose:realWidth()
    local yScale = self._buttonReplay:realHeight() / self._buttonClose:realHeight()
    
    self._buttonClose:sourceView():scale(xScale, yScale )
    
end

function ViewPopupPause.cleanup(self)
    
    self._buttonClose:cleanup()
    self._buttonClose = nil
    
    self._buttonReplay:cleanup()
    self._buttonReplay = nil
    
    ViewPopupCatsBase.cleanup(self)
    
end
