require('game_cats.src.models.game.cats.ECatType')
require('game_cats.src.controllers.game.ControllerCat')

Cat = classWithSuper(Object, 'Cat')

--
--Events
--


--
--Properties
--

function Cat.type(self)
    return self._type
end

function Cat.row(self)
    return self._row
end

function Cat.column(self)
    return self._column
end

function Cat.controller(self)
    return self._controller
end

function Cat.setController(self, controller)
    self._controller = controller
end
--
--Events
--

--
--Methods
--

 
function Cat.setPosition(self, row, column)
    
    assert(row    ~= nil)
    assert(column ~= nil)
    
    self._row    = row
    self._column = column
    
    self._controller:update(EControllerUpdate.ECUT_CHANGE_POSITION)
    
end

function Cat.init(self, params)
    
    assert(params               ~= nil)
    assert(params.type          ~= nil)
    assert(params.row           ~= nil)
    assert(params.column        ~= nil)
    
    self._type      = params.type
    
    self._row       = params.row
    self._column    = params.column
    
end

function Cat.cleanup(self)
    
    self._controller = nil
    
    Object.cleanup(self)
end
