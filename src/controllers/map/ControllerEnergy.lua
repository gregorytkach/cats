require('game_cats.src.views.map.ViewEnergy')
ControllerEnergy = classWithSuper(Controller, 'ControllerEnergy')

--
-- Properties
--

--
--Events
--
function ControllerEnergy.onViewClicked(self, target, event)
    local result = Controller.onViewClicked(self, target, event)
    
    if(not result)then
        
        if(target == self._view:buttonBuy())then
            
            local popupShop = self._currentState:getPopup(EPopupType.EPT_SHOP)
            
            popupShop:showEnergy()
            
            self._currentState:showPopup(EPopupType.EPT_SHOP)
            
        else
            assert(false)
        end
        
    end
    
    return result
end
--
-- Methods
--
function ControllerEnergy.init(self)
    
    local paramsView = 
    {
        controller = self
    }
    
    local paramsController = 
    {
        view = ViewEnergy:new(paramsView)
    }
    
    Controller.init(self, paramsController)
    
    self._currentState =  GameInfo:instance():managerStates():currentState()
end

function ControllerEnergy.update(self, updateType)
    
    if(updateType == EControllerUpdateBase.ECUT_PLAYER_ENERGY)then
        
    else
        assert(false)
    end
    
end

function ControllerEnergy.cleanup(self)
    
    self._currentState = nil
    
    self._view:cleanup()
    self._view = nil
    
    Controller.cleanup(self)
end


