require('game_cats.src.views.game.ViewTile')

ControllerTile = classWithSuper(Controller, 'ControllerTile')

--
--Properties
--

function ControllerTile.entry(self)
    return self._entry
end

--
--Events
--


--
--Methods
--



function ControllerTile.init(self)
    
    
    local paramsView = 
    {
        controller  = self,
        
    }
    
    local paramsController = 
    {
        view = ViewTile:new(paramsView),
    }
    
    Controller.init(self, paramsController)
    
    self._managerGame = GameInfo:instance():managerGame()
    
end

function ControllerTile.update(self, updateType)
    
    if(updateType == EControllerUpdateBase.ECUT_SCENE_ENTER)then
        
    else
        assert(false)
    end
    
end

function ControllerTile.cleanup(self)
    
    self._managerGame = nil
    
    Controller.cleanup(self)
    
end
