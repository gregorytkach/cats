require('game_cats.src.views.game.ViewPurchases')
ControllerPurchases = classWithSuper(Controller, 'ControllerPurchases')

--
-- Properties
--

--
--Events
--
function ControllerPurchases.onViewClicked(self, target, event)
    local result = Controller.onViewClicked(self, target, event)
    
    if(not result)then
        
    end
    
    return result
end
--
-- Methods
--
function ControllerPurchases.init(self)
    
    local paramsView = 
    {
        controller = self
    }
    
    local paramsController = 
    {
        view = ViewPurchases:new(paramsView)
    }
    
    Controller.init(self, paramsController)
end

function ControllerPurchases.update(self, updateType)
    
    if(updateType == EControllerUpdateBase.ECUT_SCENE_ENTER)then
        
    else
        assert(false)
    end
    
end

function ControllerPurchases.cleanup(self)
    self._view:cleanup()
    self._view = nil
    
    Controller.cleanup(self)
end


