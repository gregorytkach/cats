require('game_cats.src.views.map.ViewUIMap')
require('game_cats.src.controllers.map.ControllerEnergy')

ControllerUIMap = classWithSuper(Controller, 'ControllerUIMap')

--
-- Properties
--


--
--Events
--
function ControllerUIMap.onViewClicked(self, target, event)
    local result = Controller.onViewClicked(self, target, event)
    
    if(not result)then
        
    end
    
    return result
end
--
-- Methods
--
function ControllerUIMap.init(self)
    local paramsView = 
    {
        controller = self
    }
    
    local paramsController = 
    {
        view = ViewUIMap:new(paramsView)
    }
    
    Controller.init(self, paramsController)
    
    self._controllerEnergy = ControllerEnergy:new()
    self._view:setViewEnergy(self._controllerEnergy:view())
end

function ControllerUIMap.update(self, updateType)
    
    if updateType == EControllerUpdateBase.ECUT_PLAYER_ENERGY then
        
    else
        assert(false)
    end
    
    
end

function ControllerUIMap.cleanup(self)
    self._view:cleanup()
    self._view = nil
    
    Controller.cleanup(self)
end
