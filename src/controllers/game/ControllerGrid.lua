require('game_cats.src.controllers.game.ControllerCat')
require('game_cats.src.controllers.game.ControllerCell')
require('game_cats.src.controllers.game.ControllerTile')
require('game_cats.src.controllers.game.ControllerBonusDog')
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
    
    local currentColumn = controllerCat:entry():column()
    
    if currentColumn ~= self._currentColumn then
        self._delay = self._delay + Constants.CHANGE_CELL_TIME
    end
    
    self._currentColumn = currentColumn
    
    controllerCat:onCreated(offset, self._delay)
    
    
    
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
    
    self._delay = 0
    self._managerGame = GameInfo:instance():managerGame()
    
    local cells = self._managerGame:cells()
    
    
    self._controllersCells   = {}
    self._controllersCats    = {}
    self._controllersTiles   = {}
    
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
    
    local tiles = self._managerGame:tiles()
    
    local tilesViews    = {}
    
    
    for rowIndex, row in ipairs(tiles)do
        
        local rowControllers = {}
        local rowViews       = {}
        
        for columnIndex, tile in ipairs(row)do
            
            local controllerTile = ControllerTile:new()   
            
            table.insert(rowControllers, controllerTile)
            
            local tileView = controllerTile:view()
            table.insert(rowViews, tileView)
            
            if not tile then
                tileView:hide()
            end
            
            
        end
        
        table.insert(self._controllersTiles, rowControllers)
        
        table.insert(tilesViews, rowViews)
        
    end
    
    self._view:onCreatedTiles(tilesViews)
    
    self._controllerBonusDog = ControllerBonusDog:new()
    self._controllerBonusDog:view():sourceView().isVisible = false
    
    self._view:sourceView():insert(self._controllerBonusDog:view():sourceView())
    
    self._bottomRow = {}
    
    
    
    local cellStart = cellsViews[#cellsViews][#cellsViews[1]]
    local cellStop  = cellsViews[#cellsViews][1]
    
    self._startBonusDogCell = cellStart:sourceView()
    self._stopBonusDogCell  = cellStop:sourceView()
    
    
    
    self._delay = 0
    
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
                
            controllerCat:onCreated(offset, (controllerCat:entry():column() - 1) * Constants.CHANGE_CELL_TIME )
                
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
        
    elseif(updateType == EControllerUpdate.ECUT_TILES)then
        
        local tiles = self._managerGame:tiles()
                
        for rowIndex, row in ipairs(self._controllersTiles)do
            for columnIndex, controllerTile in ipairs(row)do
                
               local tile = tiles[rowIndex][columnIndex]
                
               if not tile then
                    controllerTile:view():hide()
               end  
                
            end
        end
        
    elseif(updateType == EControllerUpdate.ECUT_NEW_CATS) then
        
        self._delay = 0
        
    elseif(updateType == EControllerUpdate.ECUT_BONUS_DOG)then
        
        self._controllerBonusDog:transition(self._startBonusDogCell, self._stopBonusDogCell)
        
        local cats = self._managerGame:cats()
        for i = 1, #cats[1], 1 do
            local cat     = cats[#cats][i]
            local catView = cat:controller():view()
            table.insert(self._bottomRow, catView)
        end
        
        local catView = self._bottomRow[#self._bottomRow]
        table.remove(self._bottomRow, #self._bottomRow)
        catView:hide()
        
        self._timerBonusDog = timer.performWithDelay(Constants.BONUS_DOG_TIME / #self._bottomRow, 
        function ()
            local catView = self._bottomRow[#self._bottomRow]
            catView:hide()
            table.remove(self._bottomRow, #self._bottomRow)
        end, 
        #self._bottomRow)
        
    else
        assert(false)
    end
end

function ControllerGrid.cleanup(self)
    
    if self._timerBonusDog ~= nil then
        timer.cancel(self._timerBonusDog)
    end
    
    
    for i = #self._bottomRow, 1, -1 do
        table.remove(self._bottomRow, i)
    end
      
    self._startBonusDogCell = nil
    self._stopBonusDogCell  = nil
    
end
