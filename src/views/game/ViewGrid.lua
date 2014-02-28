ViewGrid = classWithSuper(ViewBase, 'ViewGrid')

--
--Properties
--

--
--Events
--

function ViewGrid.onCreatedCells(self, cellsViews)
    self._cells = cellsViews
    
    for indexRow, rowCells in ipairs(self._cells)do
        
        for indexCell, cellView in ipairs(rowCells)do
            
            self._layerCells:insert(cellView:sourceView())
            
        end
    end
    
end

function ViewGrid.onCreatedTiles(self, tilesViews)
    self._tiles = tilesViews
    
    for indexRow, rowTile in ipairs(self._tiles)do
        
        for indexCell, cellView in ipairs(rowTile)do
            
            self._layerTiles:insert(cellView:sourceView())
            
        end
    end
    
end


function ViewGrid.onCreatedCat(self, controllerCat) 
    local catView   = controllerCat:view()
    local catSource = catView:sourceView()
    
    self._layerCats:insert(catSource)
   
    catView:setGroup(self._sourceView)
    
    local row       = controllerCat:entry():row()
    local column    = controllerCat:entry():column()
    
    local cellView  = self._cells[row][column]
    
    catSource.x = cellView:sourceView().x
    catSource.y = cellView:sourceView().y
    
    --print(catSource.x..":"..catSource.y)
end


--
--Methods
--

function ViewGrid.init(self, params)
    ViewBase.init(self, params)
    
    self._sourceView    = display.newGroup()
    
    self._layerCells    = display.newGroup()
    self._sourceView:insert(self._layerCells)
    
    self._layerTiles    = display.newGroup()
    self._sourceView:insert(self._layerTiles)
    
    self._layerCats     = display.newGroup()
    self._sourceView:insert(self._layerCats)
    
end



function ViewGrid.placeViews(self)
    ViewBase.placeViews(self)
    
    local cellView = self._cells[1][1]
    
    local cellWidth  = cellView:realWidth()
    local cellHeight = cellView:realHeight()
    
    local offsetX = 3
    local offsetY = 3
    
    local startX = -((#self._cells[1] - 1) * offsetX + cellWidth  * #self._cells[1]) / 2 + cellWidth  / 2
    local startY = -((#self._cells    - 1) * offsetY + cellHeight * #self._cells) / 2    + cellHeight / 2
    
    local currentX = startX
    local currentY = startY
    
    for indexRow, rowCells in ipairs(self._cells)do
        
        for indexColumn, cellView in ipairs(rowCells)do
            
            cellView:sourceView().x = currentX
            cellView:sourceView().y = currentY
            
            local tileView = self._tiles[indexRow][indexColumn]
            
            tileView:sourceView().x = currentX
            tileView:sourceView().y = currentY
            
            currentX = currentX + cellWidth + offsetX 
            
            
            
        end
        
        currentX = startX
        
        currentY = currentY + cellHeight + offsetY 
        
        
        
    end
    
end
