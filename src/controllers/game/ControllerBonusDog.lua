require('game_cats.src.views.game.ViewBonusDog')

ControllerBonusDog = classWithSuper(Controller, 'ControllerBonusDog')

--
--Properties
--


--
--Events
--


--
--Methods
--


function ControllerBonusDog.tryCleanupTweenDogMoved(self)
   
    if self._tweenDogMoved ~= nil then
        transition.cancel(self._tweenDogMoved)
        self._tweenDogMoved = nil
    end
    
end

function ControllerBonusDog.transition(self, start, stop)
    
    local source = self._view:sourceView()
    
    source.isVisible = true
    source.x = start.x + self._view:realWidth()
    source.y = start.y
    
    self._view:animation():play()
        
    local tweenParams =
    {
        x           = stop.x - self._view:realWidth(),
        y           = stop.y,
        time        = 2 * Constants.CHANGE_CELL_TIME ,
        onComplete  = function () 
                        self._view:animation():pause()
                        source.isVisible = false 
                      end,
    }

    self._tweenDogMoved = transition.to(source, tweenParams) 

    
end


function ControllerBonusDog.init(self)
    
    
    local paramsView = 
    {
        controller  = self,
        
    }
    
    local paramsController = 
    {
        view = ViewBonusDog:new(paramsView),
    }
    
    Controller.init(self, paramsController)
    
    
    
end


function ControllerBonusDog.cleanup(self)
    
    self:tryCleanupTweenDogMoved()
    
    
    Controller.cleanup(self)
    
end
