require('game_cats.src.views.game.ViewUI')
require('game_cats.src.controllers.game.ControllerPurchases')
require('game_cats.src.controllers.game.ControllerProgress')


ControllerUI = classWithSuper(Controller, 'ControllerUI')

--
-- Properties
--


--
--Events
--
function ControllerUI.onViewClicked(self, target, event)
    local result = Controller.onViewClicked(self, target, event)
    
    if(not result)then
        
    end
    
    return result
end
--
-- Methods
--
function ControllerUI.init(self)
    local paramsView = 
    {
        controller = self
    }
    
    local paramsController = 
    {
        view = ViewUI:new(paramsView)
    }
    
    Controller.init(self, paramsController)
    
    self._controllerPurchases = ControllerPurchases:new()
    self._view:setViewPurchases(self._controllerPurchases:view())
    
    
    self._controllerProgress = ControllerProgress:new()
    self._view:setViewProgress(self._controllerProgress:view())
    
    
    
    
end

function ControllerUI.update(self, updateType)
    
    if updateType == EControllerUpdateBase.ECUT_PLAYER_ENERGY then
        
    else
        assert(false)
    end
    
    
end

function ControllerUI.cleanup(self)
    
    self._view:cleanup()
    self._view = nil
    
    self._controllerPurchases:cleanup()
    self._controllerPurchases = nil
    
    Controller.cleanup(self)
end


