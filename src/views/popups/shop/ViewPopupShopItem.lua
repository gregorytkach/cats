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
    
    self._buttonBuy = self:createButton(managerResources:getAsButton(EResourceType.ERT_POPUP_SHOP_BUTTON_BUY), nil,  managerString:getString(EStringType.EST_POPUP_SHOP_BUTTON_BUY), EFontType.EFT_1)
    self._sourceView:insert(self._buttonBuy:sourceView())
    
    self._viewItem      = self:createSprite(managerResources:getAsImage(EResourceType.ERT_POPUP_SHOP_VIEW_ITEM))
    self._sourceView:insert(self._viewItem:sourceView())
    
   
    
--    self._labelContentCount     = self:createLabel(params.entry:contentCount(), EFontType.EFT_0)

--    
--    self._labelPrice            = self:createLabel(params.entry:priceHard(), EFontType.EFT_2)
   
    
    local iconImage = nil
 
    if(params.entry:type() == EPurchaseTypeBase.EPT_CURRENCY_SOFT)then
        
        self._viewContentRemove9Cells    = self:createSprite(managerResources:getAsImage(EResourceType.ERT_POPUP_SHOP_VIEW_CONTENT))
        self._sourceView:insert(self._viewContentRemove9Cells:sourceView())
        
        self._viewContentRemoveBottomRow  = self:createSprite(managerResources:getAsImage(EResourceType.ERT_POPUP_SHOP_VIEW_CONTENT))
        self._sourceView:insert(self._viewContentRemoveBottomRow:sourceView())
        
        self._viewContentShuffle  = self:createSprite(managerResources:getAsImage(EResourceType.ERT_POPUP_SHOP_VIEW_CONTENT))
        self._sourceView:insert(self._viewContentShuffle:sourceView())
        
        iconImage = managerResources:getAsImage(EResourceType.ERT_ICON_REMOVE_9_CELLS)
        self._iconRemove9Cells        = self:createSprite(iconImage) 
        
        iconImage = managerResources:getAsImage(EResourceType.ERT_ICON_REMOVE_BOTTOM_ROW)
        self._iconRemoveBottomRow        = self:createSprite(iconImage) 
        
        iconImage = managerResources:getAsImage(EResourceType.ERT_ICON_SHUFFLE)
        self._iconShuffle        = self:createSprite(iconImage) 
        
        --todo: rewrite '3.99'
        
        self._labelContentPrice     = self:createLabel('1$', EFontType.EFT_0)
        self._sourceView:insert(self._labelContentPrice:sourceView())
        
        self._labelContentPlus1     = self:createLabel('+', EFontType.EFT_0)
        self._sourceView:insert(self._labelContentPlus1:sourceView())
        
        self._labelContentPlus2     = self:createLabel('+', EFontType.EFT_0)
        self._sourceView:insert(self._labelContentPlus2:sourceView())
        
    elseif(params.entry:type() == EPurchaseTypeBase.EPT_ENERGY)then
        
        self._viewContent      = self:createSprite(managerResources:getAsImage(EResourceType.ERT_POPUP_SHOP_VIEW_CONTENT))
        self._sourceView:insert(self._viewContent:sourceView())
        
        iconImage = managerResources:getAsImage(EResourceType.ERT_ICON_ENERGY)
        self._icon        = self:createSprite(iconImage) 
        self._sourceView:insert(self._icon:sourceView())
        
        self._labelContentCount     = self:createLabel(params.entry:contentCount(), EFontType.EFT_0)
        self._sourceView:insert(self._labelContentCount:sourceView())
        
        --todo: rewrite '3.99'
        
        self._labelContentPrice     = self:createLabel('3.99', EFontType.EFT_0)
        self._sourceView:insert(self._labelContentPrice:sourceView())
        
    else
        assert(false)
    end
    
    
    
end

function ViewPopupShopItem.placeViews(self)
    
    
    
    self._viewItem:sourceView().x  = 35 -  self._viewItem:realWidth() / 2
    
    
--    
--    self._labelContentCount:sourceView().x  = self._viewItem:sourceView().x - (viewItemRealWidth / 2) + viewItemRealWidth * 0.2
--    self._labelPrice:sourceView().x         = self._viewItem:sourceView().x + (viewItemRealWidth / 2) - viewItemRealWidth * 0.2
    
    
    self._buttonBuy:sourceView().x = 40 + self._buttonBuy:realWidth() / 2 
    
    if(self._icon ~= nil)then
        
        self._viewContent:sourceView().x = self._viewItem:sourceView().x - 10
        self._icon:sourceView().x        =  self._viewItem:sourceView().x - 10
        
        self._labelContentCount:sourceView().x = self._icon:sourceView().x - self._icon:realWidth() - self._labelContentCount:realWidth() / 2
        self._labelContentPrice:sourceView().x = self._icon:sourceView().x + self._icon:realWidth() + self._labelContentPrice:realWidth() / 2
    else
        local offsetContentX = -20
        
        self._viewContentRemove9Cells:sourceView().x = self._viewItem:sourceView().x - self._viewItem:realWidth() * 0.25 + offsetContentX 
        
        self._viewContentRemoveBottomRow:sourceView().x = self._viewItem:sourceView().x  + offsetContentX 
         
        self._viewContentShuffle:sourceView().x = self._viewItem:sourceView().x + self._viewItem:realWidth() * 0.25 + offsetContentX 
        
        self._iconRemove9Cells:sourceView().x = self._viewContentRemove9Cells:sourceView().x - self._viewContentRemove9Cells:realWidth() * 0.3
        self._iconRemove9Cells:sourceView().y = self._viewContentRemove9Cells:sourceView().y - self._viewContentRemove9Cells:realHeight() * 0.3
        
        self._iconRemoveBottomRow:sourceView().x = self._viewContentRemoveBottomRow:sourceView().x - self._viewContentRemoveBottomRow:realWidth() * 0.3
        self._iconRemoveBottomRow:sourceView().y = self._viewContentRemoveBottomRow:sourceView().y - self._viewContentRemoveBottomRow:realHeight() * 0.3
        
        self._iconShuffle:sourceView().x = self._viewContentShuffle:sourceView().x - self._viewContentShuffle:realWidth() * 0.3
        self._iconShuffle:sourceView().y = self._viewContentShuffle:sourceView().y - self._viewContentShuffle:realHeight() * 0.3
        
        self._labelContentPrice:sourceView().x = self._viewItem:sourceView().x + self._viewItem:realWidth() * 0.5 - self._labelContentPrice:realWidth() +  offsetContentX
        
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
    
    if(self._icon ~= nil)then
        
        self._icon:cleanup()
        self._icon = nil
        
        self._viewContent:cleanup()
        self._viewContent = nil
        
        self._labelContentCount:cleanup()
        self._labelContentCount = nil
        
        
    else
        
        self._viewContentRemove9Cells:cleanup() 
        self._viewContentRemove9Cells = nil
        
        self._viewContentRemoveBottomRow:cleanup() 
        self._viewContentRemoveBottomRow = nil
        
        self._viewContentShuffle:cleanup() 
        self._viewContentShuffle = nil
        
        self._iconRemove9Cells:cleanup() 
        self._iconRemove9Cells = nil
        
        self._iconRemoveBottomRow:cleanup() 
        self._iconRemoveBottomRow = nil
        
        self._iconShuffle:cleanup() 
        self._iconShuffle = nil
        
        self._labelContentPlus1:cleanup()
        self._labelContentPlus1 = nil
        
    end
    
    self._labelContentPrice:cleanup()
    self._labelContentPrice = nil
    
--    self._icon:cleanup()
--    self._icon = nil
--    
--    self._labelPrice:cleanup()
--    self._labelPrice = nil
    
    ViewBase.cleanup(self)
end



