require('game_cats.src.views.popups.shop.ViewPopupShopContent')

ViewPopupShop = classWithSuper(ViewPopupCatsBase, 'ViewPopupShop')

--
--Properties
--


function ViewPopupShop.buttonPurchase(self)
    return self._buttonPurchase
end

function ViewPopupShop.buttonEnergy(self)
    return self._buttonEnergy
end

function ViewPopupShop.contentPurchase(self)
    return self._contentPurchase
end

function ViewPopupShop.contentEnergy(self)
    return self._contentEnergy
end

--
-- Methods
--
function ViewPopupShop.init(self, params)
    
    ViewPopupCatsBase.init(self, params)
    
    local managerResources  = GameInfo:instance():managerResources()
    local managerString     =  GameInfo:instance():managerString()
    
    self:initBackground(managerResources:getPopupBackground(self._controller:getType()))
    self:initTitle(EStringType.EST_POPUP_SHOP_TITLE)
   
    local buttonClose = self:createButton(managerResources:getAsButton(EResourceType.ERT_BUTTON_BLUE), 
    nil, 
    managerString:getString(EStringType.EST_POPUP_SHOP_BUTTON_CLOSE), 
    EFontType.EFT_1)
    buttonClose:label():sourceView():setColorHex("0xE5FBFF")
    self:setButtonClose(buttonClose)
    
    self._buttonEnergy = self:createButton(managerResources:getAsButton(EResourceType.ERT_POPUP_SHOP_BUTTON_TAB), 
    nil, 
    managerString:getString(EStringType.EST_POPUP_SHOP_BUTTON_ENERGY), 
    EFontType.EFT_1)
    
    self._buttonPurchase = self:createButton(managerResources:getAsButton(EResourceType.ERT_POPUP_SHOP_BUTTON_TAB), 
    nil, 
    managerString:getString(EStringType.EST_POPUP_SHOP_BUTTON_PURCHASE), 
    EFontType.EFT_1)
    
    self._contentEnergy = ViewPopupShopContent:new(params)
    self._sourceView:insert(self._contentEnergy:sourceView())
    
    self._contentPurchase = ViewPopupShopContent:new(params)
    self._sourceView:insert(self._contentPurchase:sourceView())
    
end


function ViewPopupShop.placeViews(self)
    
    local realHeight = self._background:realHeight()
    local realWidth  = self._background:realWidth()
    
    self._labelTitle:sourceView().x = 0
    self._labelTitle:sourceView().y = 0 - realHeight / 2 + 20 + self._labelTitle:realHeight() / 2
    
    self._buttonEnergy:sourceView().x = 0 - 0.22 * realWidth
    self._buttonEnergy:sourceView().y = 0 - realHeight * 0.3
    
    self._buttonPurchase:sourceView().x = 0 + 0.22 * realWidth
    self._buttonPurchase:sourceView().y = 0 - realHeight * 0.3
    
    self._buttonClose:sourceView().x = 0
    self._buttonClose:sourceView().y = 0 + realHeight / 2 - self._buttonClose:realHeight()  
    
    local contentOffsetY = 80 - realHeight / 2 + self._buttonPurchase:realHeight()
    
    self._contentPurchase:placeViews()
    
    self._contentPurchase:sourceView().x = 5
    self._contentPurchase:sourceView().y = contentOffsetY
    
    self._contentEnergy:placeViews()
    
    self._contentEnergy:sourceView().x = 5
    self._contentEnergy:sourceView().y = contentOffsetY
    
end

function ViewPopupShop.cleanup(self)
    
    self._buttonEnergy:cleanup()
    self._buttonEnergy = nil
    
    self._buttonPurchase:cleanup()
    self._buttonPurchase = nil
    
    ViewPopupCatsBase.cleanup(self)
    
end
