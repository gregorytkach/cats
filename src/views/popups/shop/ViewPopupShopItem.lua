ViewPopupShopItem = classWithSuper(ViewBase, 'ViewPopupShopItem')

--
-- Properties
--



function ViewPopupShopItem.buttonBuy(self)
    return self._buttonBuy
end

--
-- Methods
--

function ViewPopupShopItem.init(self, params)
    ViewBase.init(self, params)
    
    assert(params.entry ~= nil)
    
    self._sourceView = display.newGroup()
    
    local managerResources = GameInfo:instance():managerResources()
    local managerString    = GameInfo:instance():managerString()
    
    self._buttonBuy = self:createButton(managerResources:getAsButton(EResourceType.ERT_BUTTON_GREEN), nil,  managerString:getString(EStringType.EST_POPUP_SHOP_BUTTON_BUY), EFontType.EFT_1)
    self._sourceView:insert(self._buttonBuy:sourceView())
    
    self._viewItem      = self:createSprite(managerResources:getAsImage(EResourceType.ERT_POPUP_SHOP_VIEW_ITEM))
    self._sourceView:insert(self._viewItem:sourceView())
    
--    self._labelContentCount     = self:createLabel(params.entry:contentCount(), EFontType.EFT_0)
--    self._labelContentCount:sourceView():setColorHex("0xFFB600")
--    
--    self._labelPrice            = self:createLabel(params.entry:priceHard(), EFontType.EFT_2)
--    
    local iconImage = nil
  

    if(params.entry:type() == EPurchaseTypeBase.EPT_CURRENCY_SOFT)then
--        iconImage = managerResources:getAsImage(EResourceType.ERT_ICON_CURRENCY)
    elseif(params.entry:type() == EPurchaseTypeBase.EPT_ENERGY)then
        
        iconImage = managerResources:getAsImage(EResourceType.ERT_ICON_ENERGY)
        self._icon        = self:createSprite(iconImage) 
        self._sourceView:insert(self._icon:sourceView())
        
    else
        assert(false)
    end
    
    
    
end

function ViewPopupShopItem.placeViews(self)
    
    self._buttonBuy:sourceView():scale(0.75, 1)
    
    self._viewItem:sourceView():scale(1.5, 1)
    
    self._viewItem:sourceView().x  = 50 -  self._viewItem:realWidth() / 2
    
    local viewItemRealWidth = self._viewItem:realWidth()
--    
--    self._labelContentCount:sourceView().x  = self._viewItem:sourceView().x - (viewItemRealWidth / 2) + viewItemRealWidth * 0.2
--    self._labelPrice:sourceView().x         = self._viewItem:sourceView().x + (viewItemRealWidth / 2) - viewItemRealWidth * 0.2
    
    
    self._buttonBuy:sourceView().x = 55 + self._buttonBuy:realWidth() / 2 
    
    if(self._icon ~= nil)then
        self._icon:sourceView().x     =  self._viewItem:sourceView().x - 10
    end
    
    ViewBase.placeViews(self)
end

function ViewPopupShopItem.cleanup(self)
    
--    self._labelContentCount:cleanup()
--    self._labelContentCount = nil
--    
    self._viewItem:cleanup()
    self._viewItem = nil
    
    self._buttonBuy:cleanup()
    self._buttonBuy = nil
    
--    self._icon:cleanup()
--    self._icon = nil
--    
--    self._labelPrice:cleanup()
--    self._labelPrice = nil
    
    ViewBase.cleanup(self)
end



