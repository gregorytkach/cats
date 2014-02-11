require('game_cats.src.models.game.cells.ECellType')
require('game_cats.src.controllers.game.ControllerCell')

Cell = classWithSuper(Object, 'Cell')

--
--Properties
--
function Cell.type(self)
    return self._type
end

function Cell.controller(self)
    return self._controller
end

function Cell.setController(self, controller)
    self._controller = controller
end

--
--Events
--

--
--Methods
--


function Cell.init(self, params)
    
    assert(params               ~= nil)
    assert(params.type          ~= nil)
    
    self._type = params.type
    
end

function Cell.cleanup(self)
    
    self._controller = nil
    
end
