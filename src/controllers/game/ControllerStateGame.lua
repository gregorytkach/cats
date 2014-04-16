require('game_cats.src.views.game.ViewStateGame')
require('game_cats.src.controllers.game.ControllerGrid')


ControllerStateGame = classWithSuper(Controller, 'ControllerStateGame')

--
-- Properties
--

function ControllerStateGame.controllerGrid(self)
    
    return self._controllerGrid
    
end

--
--Events
--

function ControllerStateGame.onViewClicked(self, target, event)
    local result = Controller.onViewClicked(self, target, event)
    
    if(not result)then
        
    end
    
    return result
end

--
-- Methods
--

function ControllerStateGame.init(self)
    
    local paramsView = 
    {
        controller = self
    }
    
    local paramsController = 
    {
        view = ViewStateGame:new(paramsView)
    }
    
    Controller.init(self, paramsController)
     
    
    self._controllerGrid = ControllerGrid:new()
    
    self._view:setViewGrid(self._controllerGrid:view())
    
end


function ControllerStateGame.cleanup(self)
    
    self._controllerGrid:cleanup()
    self._controllerGrid = nil
    
    self._view:cleanup()
    self._view = nil
    
    Controller.cleanup(self)
end


