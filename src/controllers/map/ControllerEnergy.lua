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
end

function ControllerEnergy.update(self, updateType)
    
    if(updateType == EControllerUpdateBase.ECUT_PLAYER_ENERGY)then
        
    else
        assert(false)
    end
    
end

function ControllerEnergy.cleanup(self)
    self._view:cleanup()
    self._view = nil
    
    Controller.cleanup(self)
end


