require('game_cats.src.controllers.game.ControllerCat')
require('game_cats.src.controllers.game.ControllerCell')
require('game_cats.src.views.game.ViewGrid')


ControllerGrid = classWithSuper(Controller, 'ControllerGrid')

--
--Events
--
function ControllerGrid.onCatCreated(self, cat)
    
    local paramsController = 
    {
        entry = cat 
    }
    
    local controllerCat = ControllerCat:new(paramsController)
    table.insert(self._controllersCats, controllerCat)
    
    cat:setController(controllerCat)
    self._view:onCreatedCat(controllerCat)
    
    local offset = controllerCat:view():realHeight() * #self._controllersCells 
    
    controllerCat:onCreated(offset)
    
end

--
--Properties
--


--
--Methods
--

function ControllerGrid.init(self)
    
    local paramsView = 
    {
        controller = self
    }
    
    local paramsController = 
    {
        view = ViewGrid:new(paramsView)
    }
    
    Controller.init(self, paramsController)
    
    
    self._managerGame = GameInfo:instance():managerGame()
    
    local cells = self._managerGame:cells()
    
    self._controllersCells   = {}
    self._controllersCats    = {}
    
    local cellsViews    = {}
    
    local default = 0
    
    for rowIndex, row in ipairs(cells)do
        
        local rowControllers = {}
        local rowViews       = {}
        default = 2 * (rowIndex / 2 - math.floor(rowIndex / 2))
        
        for columnIndex, cell in ipairs(row)do
            
            local paramsControllers = 
            {
                entry = cell,
                default = default
            }
            
            local controllerCell = ControllerCell:new(paramsControllers)   
            
            cell:setController(controllerCell)
            table.insert(rowControllers, controllerCell)
            table.insert(rowViews, controllerCell:view())
            
            default = 1 - default
            
        end
        
        table.insert(self._controllersCells, rowControllers)
        
        table.insert(cellsViews, rowViews)
        
    end
    
    self._view:onCreatedCells(cellsViews)
    
end

function ControllerGrid.update(self, updateType)
    
    if(updateType == EControllerUpdateBase.ECUT_SCENE_ENTER)then
        
        local cats          = self._managerGame:cats()
        local catsViews     = {}
        
        math.randomseed(os.time())
        
        for rowIndex, row in ipairs(cats)do
            
            local rowViews       = {}
            
            for columnIndex, cat in ipairs(row)do
                local paramsControllers = 
                {
                    entry = cat,
                    type  = cat:type(),
                }
                
                local controllerCat = ControllerCat:new(paramsControllers)   
                
                self._view:onCreatedCat(controllerCat)
                
                table.insert(self._controllersCats, controllerCat)
                table.insert(rowViews, controllerCat:view())
                
            end
            
            table.insert(catsViews, rowViews)
            
        end
        
        local offset = self._view:realHeight()
        
        for i, controllerCat in ipairs(self._controllersCats)do
                
            controllerCat:onCreated(offset)
                
        end
        
    elseif(updateType == EControllerUpdateBase.ECUT_SCENE_EXIT)then
        
    elseif(updateType == EControllerUpdate.ECUT_NEED_REMOVE)then
        
        for i = #self._controllersCats, 1, -1 do
            
               local controllerCat = self._controllersCats[i]
               if controllerCat:needRemove() then
                   
                   controllerCat:cleanup()
                   table.remove(self._controllersCats, i)
                   
               end
     
        end
        
        
    else
        assert(false)
    end
end
