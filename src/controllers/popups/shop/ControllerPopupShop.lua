require('game_cats.src.views.popups.shop.ViewPopupShop')
require('game_cats.src.controllers.popups.shop.ControllerPopupShopItem')

ControllerPopupShop = classWithSuper(ControllerPopup, 'ControllerPopupShop')

--
-- Properties
--

function ControllerPopupShop.getType(self)
    return EPopupType.EPT_SHOP
end

--
-- Events
--

function ControllerPopupShop.onViewClicked(self, target, event)
    
    local result = ControllerPopup.onViewClicked(self, target, event)
    
    if(not result)then
        
        if(target == self._view:buttonPurchase())then
            self:showPurchase()
        elseif(target == self._view:buttonEnergy())then
            self:showEnergy()
        else
            assert(false)
        end
        
    end
    
    return result
end

--
-- Methods
--


function ControllerPopupShop.init(self)
    
    local paramsView =
    {
        controller = self
    }
    
    local paramsController =
    {
        view = ViewPopupShop:new(paramsView)
    }
    
    ControllerPopup.init(self, paramsController)
    
    self._items = {}
    
    local purchases = GameInfo:instance():managerPurchases():purchases()
    
    for i, purchase in ipairs(purchases)do
        
        if(purchase:type() == EPurchaseTypeBase.EPT_CURRENCY_SOFT or purchase:type() == EPurchaseTypeBase.EPT_ENERGY)then
            
            local paramsItem = 
            {
                entry = purchase
            }
            
            local controllerItem  = ControllerPopupShopItem:new(paramsItem)
            table.insert(self._items, controllerItem)
            
            if(purchase:type() == EPurchaseTypeBase.EPT_CURRENCY_SOFT)then
                
                
                
                self._view:contentPurchase():addItem(controllerItem:view())
                
            elseif(purchase:type() == EPurchaseTypeBase.EPT_ENERGY)then
                
                self._view:contentEnergy():addItem(controllerItem:view())
                
            else
                assert(false)
            end
            
        end
        
    end
    
    self:showPurchase()
end

function ControllerPopupShop.showPurchase(self)
    
    self._view:buttonPurchase():setIsEnabled(false)
    self._view:buttonEnergy():setIsEnabled(true)
    
    self._view:contentPurchase():sourceView().alpha   = 1
    self._view:contentEnergy():sourceView().alpha     = 0
end

function ControllerPopupShop.showEnergy(self)
    
    self._view:buttonPurchase():setIsEnabled(true)
    self._view:buttonEnergy():setIsEnabled(false)
    
    self._view:contentPurchase():sourceView().alpha   = 0
    self._view:contentEnergy():sourceView().alpha     = 1
    
end

function ControllerPopupShop.cleanup(self)
    
    self._view:cleanup(self)
    self._view = nil
    
    ControllerPopup.cleanup(self)
end

