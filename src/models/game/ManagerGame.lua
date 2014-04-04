
require('game_cats.src.models.game.cats.ECatType')
require('game_cats.src.models.game.cats.Cat')

require('game_cats.src.models.game.cells.ECellType')
require('game_cats.src.models.game.cells.Cell')

ManagerGame = classWithSuper(ManagerGameBase, 'ManagerGame')

--
--Properties
--

function ManagerGame.scores(self)
    return self._scores
end

function ManagerGame.isCatsComplete(self)
    return self._isCatsComplete
end

function ManagerGame.timerPush(self)
    
    return self._timerPush
    
end

function ManagerGame.focusCat(self)
    return self._focusCat
end

function ManagerGame.setFocusCat(self, value)

    self._focusCat     = value
    
end

function ManagerGame.cells(self)
    return self._cells
end

function ManagerGame.cats(self)
    return self._cats
end

function ManagerGame.tiles(self)
    return self._tiles
end

--
--Events
--

function ManagerGame.onShuffle(self)
    
    self:shuffle()
    
    self:pushes()
    
end

function ManagerGame.onCatsComplete(self)
    
    self._isCatsComplete = true
    
end

function ManagerGame.onRemove9Cells(self)
    
   local remove9Cells = {} 
   
   for i = 1, 9, 1 do
           
      local cat = self._cats[math.random(self._rowsCount)][math.random(self._columnsCount)]
      
      while table.indexOf(remove9Cells, cat) ~= nil do
                
        cat = self._cats[math.random(self._rowsCount)][math.random(self._columnsCount)]
          
      end
      
      table.insert(remove9Cells, cat)
       
   end
  
       
   for i = 1, 9, 1 do
   
       local cat = remove9Cells[i]
       
       cat:controller():update(EControllerUpdate.ECUT_NEED_REMOVE)
       cat:cleanup()
       self._cats[cat:row()][cat:column()] = nil
       self._tiles[cat:row()][cat:column()] = false
       
   end
   
   self._currentState:update(EControllerUpdate.ECUT_NEED_REMOVE)
   self._currentState:update(EControllerUpdate.ECUT_TILES)
   
   self:createNewCats()
   self:pushes()
   
end

function ManagerGame.onRemoveBottomRow(self)
       
   for columnIndex = 1, self._columnsCount, 1 do
       local cat = self._cats[self._rowsCount][columnIndex]
       
       cat:controller():update(EControllerUpdate.ECUT_NEED_REMOVE)
       cat:cleanup()
       self._cats[self._rowsCount][columnIndex] = nil
       self._tiles[cat:row()][cat:column()] = false
       
   end
   
   self._currentState:update(EControllerUpdate.ECUT_NEED_REMOVE)
   self._currentState:update(EControllerUpdate.ECUT_TILES)
   
   self:createNewCats()
   self:pushes()
   
end

function ManagerGame.onGameStart1(self)
        
    for rowIndex = 1, self._rowsCount, 1 do

        local rowCat    = {}

        for columnIndex = 1, self._columnsCount, 1 do
            
            local typeCat = 0
            
            if columnIndex / 2 == math.floor(columnIndex / 2) then
                typeCat = 1
            end
            
            if rowIndex / 2 == math.floor(rowIndex / 2) then
                typeCat = typeCat + 2
            end

            table.insert(rowCat, typeCat)

        end

        table.insert(self._cats, rowCat)

    end
    
    for rowIndex = 1, self._rowsCount, 1 do

        for columnIndex = 1, self._columnsCount, 1 do

            local paramsCat =
            {
                type   = self._cats[rowIndex][columnIndex],
                row    = rowIndex,
                column = columnIndex
            }

            local cat = Cat:new(paramsCat)
            self._cats[rowIndex][columnIndex] = cat
            
        end

    end
    
    if not self:foundCanMakeCombination() then
            
        self._timerPush = timer.performWithDelay(3 * Constants.CHANGE_CELL_TIME,
        function ()
            
            self:onShuffle()

        end,
        1)

    end
    
end

--todo: if onGameStart1 rename
function ManagerGame.onGameStart(self)

    math.randomseed(os.time())

    for rowIndex = 1, self._rowsCount, 1 do

        local rowCat    = {}

        for columnIndex = 1, self._columnsCount, 1 do

            table.insert(rowCat, 1)

        end

        table.insert(self._cats, rowCat)

    end

    local countDouble = math.random(self._rowsCount )

    local indexes = {}
    

    for i = 1, countDouble, 1 do

        local rowIndex = math.random(self._rowsCount - 1) + 1
        local columnIndex = math.random(self._columnsCount - 1) + 1

        if self._cats[rowIndex][columnIndex] == 1 then

            self._cats[rowIndex - 1][columnIndex - 1] = 2
            if math.random(2) == 1 and self._cats[rowIndex - 1][columnIndex] == 1 then

                self._cats[rowIndex][columnIndex - 1] = 2

            elseif self._cats[rowIndex][columnIndex - 1] == 1 then

                self._cats[rowIndex - 1][columnIndex] = 2

            end
        end

    end

    for rowIndex = 1, self._rowsCount - 1, 1 do

        for columnIndex = 1, self._columnsCount - 1, 1 do
            if  self._cats[rowIndex][columnIndex] == 2 then

                if self._cats[rowIndex + 1][columnIndex] == 2 then

                    self._cats[rowIndex][columnIndex] = 1

                end

                if self._cats[rowIndex][columnIndex + 1] == 2 then

                    self._cats[rowIndex][columnIndex] = 1

                end

            end
        end

    end

    for rowIndex = 1, self._rowsCount, 1 do

        for columnIndex = 1, self._columnsCount, 1 do

            local newType = 0
            if self._cats[rowIndex][columnIndex] == 1 then

                local needOtherType = false

                repeat

                    needOtherType = false
                    newType = ECatType.randomType()


                    if columnIndex > 1 then

                        local cat = self._cats[rowIndex][columnIndex - 1]
                        needOtherType = newType == cat:type()

                    end

                    if rowIndex > 1 then

                        local cat = self._cats[rowIndex - 1][columnIndex]
                        needOtherType = needOtherType or (newType == cat:type())

                    end

                until not needOtherType

            elseif self._cats[rowIndex][columnIndex] == 2 then

                if math.random(2) == 1 and rowIndex > 1 then

                     local cat = self._cats[rowIndex - 1][columnIndex]
                     newType = cat:type()

                elseif columnIndex > 1 then

                     local cat = self._cats[rowIndex][columnIndex - 1]
                     newType = cat:type()

                end

            end

            local paramsCat =
            {
                type   = newType,
                row    = rowIndex,
                column = columnIndex
            }

            local cat = Cat:new(paramsCat)
            self._cats[rowIndex][columnIndex] = cat
        end

    end
    
    

end

function ManagerGame.onGameEnd(self)

    ManagerGameBase.onGameEnd(self)
end


--
--Methods
--

function ManagerGame.removeRange(self, indexName, pos, deletes)
    
    assert(indexName ~= nil)
    assert(pos ~= nil)
    assert(deletes ~= nil)
    
    local position  = {}
    
    position[indexName] = pos

    local indexNameOther = 'row'
    local maxCount = self._rowsCount

    if indexName == 'row' then

        indexNameOther = 'column'
        maxCount = self._columnsCount

    end
    
    for i = 1, maxCount, 1 do

        position[indexNameOther] = i
        local cat = self:catByPosition(position)
        
        if table.indexOf(deletes, cat) == nil then

            table.insert(deletes, cat)
            
        end
        
    end
    
    
    
end

function ManagerGame.catByPosition(self, position)

    assert(position.row     ~= nil)
    assert(position.column  ~= nil)

    return self._cats[position.row][position.column]

end

--returns collection of cats which contains in combination
function ManagerGame.foundChain(self, type, indexName, pos,  count)

    local result    = {}

    local position  = {}

    position[indexName] = pos

    local indexNameOther = 'row'
    local maxCount = self._rowsCount

    if indexName == 'row' then

        indexNameOther = 'column'
        maxCount = self._columnsCount

    end

    for i = 1, maxCount - count + 1, 1 do

        position[indexNameOther] = i
        local cat    = self:catByPosition(position)

        if cat:type() == type then

            local found = true

            for j = 1, count - 1, 1 do

                position[indexNameOther] = i + j

                local cat = self:catByPosition(position)

                if cat:type() ~= type then

                    found = false
                    break

                end

            end

            if found then

                for j = 0, count - 1, 1 do

                    position[indexNameOther] = i + j
                    local cat = self:catByPosition(position)

                    if table.indexOf(result, cat) == nil then

                        table.insert(result, cat)

                    end

                end

            end

        end


    end

    return result
end


function ManagerGame.push(self)
    
    if not self._isCatsComplete then
        return
    end
        
    local deletes   = {}
 
    for typeCat = 0, ECatType.ECT_COUNT - 1, 1 do

        for i = 1, self._rowsCount, 1 do

            local foundCombinationRow = self:foundChain(typeCat, 'row', i,  3)

            for j = 1, #foundCombinationRow, 1 do

                local cat = foundCombinationRow[j]

                if table.indexOf(deletes, cat) == nil then

                    table.insert(deletes, cat)

                end

            end

        end

        for i = 1, self._columnsCount, 1 do

            local foundCombinationColumn = self:foundChain(typeCat, 'column', i,  3)

            for j = 1, #foundCombinationColumn, 1 do

                local cat = foundCombinationColumn[j]

                if table.indexOf(deletes, cat) == nil then

                    table.insert(deletes, cat)

                end

            end

        end

    end
    
    
    if #deletes ~= 0  then
            
        self:foundCombinations(deletes)
            
        for _, cat in ipairs(deletes) do

            self:tryBomb(cat, deletes)
          
        end

        for i = 1, #deletes, 1 do

            local cat = deletes[i]
            
            if cat._newType == nil then

                self._cats[cat:row()][cat:column()] = nil
               
            elseif cat._newType == ECatType.ECT_COLOR_BOMB then
                                                
                local params =
                {
                    type    = cat._newType,
                    row     = cat:row(),
                    column  = cat:column(),
                }

                local newCat = Cat:new(params)
                self._currentState:controllerGrid():onCatCreatedStatic(newCat)
                newCat:controller():view():sourceView().isVisible = true
                self._cats[cat:row()][cat:column()] = newCat
                
            elseif cat._newType == ECatType.ECT_ROW_BOMB and cat._bombType == nil then
                
                cat:controller():view():setBomb(true)
                cat._bombType = cat._newType
                
            elseif cat._newType == ECatType.ECT_COLUMN_BOMB and cat._bombType == nil then
                
                cat:controller():view():setBomb(false)
                cat._bombType = cat._newType
                
             end
            
            if cat._newType == nil or cat._newType == ECatType.ECT_COLOR_BOMB then
                self._tiles[cat:row()][cat:column()] = false
                cat:controller():update(EControllerUpdate.ECUT_NEED_REMOVE)
                cat:cleanup()
            else
                cat._newType = nil
            end
         
        end
        
        
        self._currentState:update(EControllerUpdate.ECUT_NEED_REMOVE)
        self._currentState:update(EControllerUpdate.ECUT_TILES)
        
        self:createNewCats()
        
    else 

        timer.cancel(self._timerPush)
        self._timerPush = nil
        
        self._currentState:unblock() 
        self._catTo = nil
        
        if not self:foundCanMakeCombination() then
            
            self:onShuffle()
            
        end

    end

end

function ManagerGame.createNewCats(self)
    
    local lastCreatedCat = nil
    self._isCatsComplete = false
    
    for i = 1, self._columnsCount, 1 do

        for foundNil = self._rowsCount, 1, -1   do

            local catFoundNil = self._cats[foundNil][i]

            if catFoundNil == nil then --and self._cells[catFoundNil][i] ~= ECellType.ECLT_EMPTY then

                local found = false

                for j = foundNil - 1, 1, -1 do

                    local cat = self._cats[j][i]

                    if cat ~= nil then

                        self._cats[foundNil][i] = cat
                        self._cats[j][i] = nil

                        cat:setPosition(foundNil, i)
                        found = true
                        break

                    end

                end

                if not found then
                    
                    local params =
                    {
                        type    = ECatType.randomType(),
                        row     = foundNil,
                        column  = i
                    }

                    local cat = Cat:new(params)
                    self._currentState:controllerGrid():onCatCreated(cat)

                    self._cats[foundNil][i] = cat
                    lastCreatedCat = cat
                     
                end

            end

        end
    end
    
    
    if lastCreatedCat ~= nil then
            
        lastCreatedCat:setIsLast(true)
        
    else
                
        self._isCatsComplete = true
        
    end
    
    self._currentState:update(EControllerUpdate.ECUT_NEW_CATS)
end

function ManagerGame.foundCombination(self, cat, catsCombinations)
        
    if table.indexOf(catsCombinations, cat) ~= nil or table.indexOf(catsCombinations[1], cat) == nil then
        
        return
        
    end


    table.insert(catsCombinations, cat)
    self._countInCombination = self._countInCombination + 1

    local catUp

    if cat:row() < self._rowsCount then

       catUp = self._cats[cat:row() + 1][cat:column()]

       if catUp ~= nil and catUp:type() == cat:type()  then

           self:foundCombination(catUp, catsCombinations)

      end

    end

    local catDown

    if cat:row() > 1 then

       catDown = self._cats[cat:row() - 1][cat:column()]

       if catDown ~= nil and catDown:type() == cat:type()  then

           self:foundCombination(catDown, catsCombinations)

       end

    end

    local catRight

    if cat:column() < self._columnsCount then

       catRight = self._cats[cat:row()][cat:column() + 1]

       if catRight ~= nil and catRight:type() == cat:type() and table.indexOf(catsCombinations, catRight) == nil then

           self:foundCombination(catRight, catsCombinations)

       end

    end

    local catLeft

    if cat:column() > 1 then

       catLeft = self._cats[cat:row()][cat:column() - 1]

       if catLeft ~= nil and catLeft:type() == cat:type()  then

           self:foundCombination(catLeft, catsCombinations)

       end

    end

end

function ManagerGame.tryBomb(self, cat, deletes)
    
    local result = true
    local indexName = nil
    local pos
    
    if cat._bombType == ECatType.ECT_COLUMN_BOMB then
            
        indexName = 'column'
        pos = cat:column()
        
    elseif cat._bombType == ECatType.ECT_ROW_BOMB then
        
        indexName = 'row'
        pos = cat:row()
        
    end
    
    result = indexName ~= nil
    
    if result then
                       
        self:removeRange(indexName, pos, deletes)
        --cat._newType = nil
        
    end
    
    return result
    
end



function ManagerGame.foundCombinations(self, cats)

    local catsCombinations = {}
    table.insert(catsCombinations, cats)
    
    for i = 1, #cats, 1 do

        local cat = cats[i]

        if table.indexOf(catsCombinations, cat) == nil then

            self._countInCombination = 0
            self:foundCombination(cat, catsCombinations)
            
            self._scores = self._scores + self._countInCombination
            print(self._countInCombination)
            
            if self._countInCombination >= 5 then
                            
--                local catTo = self._catTo
--                            
--                if catTo == nil or (catTo ~= nil and table.indexOf(cats, catTo) == nil) then
                    local catTo = catsCombinations[#catsCombinations - math.random(self._countInCombination) + 1]
                --end
                
                if cat:type() == catTo:type() then
             
                    catTo._newType = ECatType.ECT_COLOR_BOMB 
                    
                end
                
            elseif self._countInCombination == 4 then
                
                local foundCombinationRow    = self:foundChain(cat:type(), 'row',    cat:row() ,  4)
                local foundCombinationColumn = self:foundChain(cat:type(), 'column', cat:column(),  4)
                
                local newType = nil
                if table.indexOf(foundCombinationRow, cat) ~= nil then
                                
                    newType = ECatType.ECT_ROW_BOMB
                    
                elseif table.indexOf(foundCombinationColumn, cat) ~= nil then
                    
                    newType = ECatType.ECT_COLUMN_BOMB
                    
                end
                
                --local catTo = self._catTo
                            
                --if catTo == nil or (catTo ~= nil and table.indexOf(cats, catTo) == nil) then
                    local catTo = catsCombinations[#catsCombinations - math.random(self._countInCombination) + 1]
                --end
                
                if cat:type() == catTo:type() then
             
                    catTo._newType = newType 
                    
                end
                
            end
            
            self._currentState:update(EControllerUpdate.ECUT_SCORES) 
            
        end

    end


end

function ManagerGame.pushes(self)
    
    if self._timerPush ~= nil then
            
        return
        
    end
    
    self._currentState:block()

    self._timerPush = timer.performWithDelay(Constants.CHANGE_CELL_TIME ,
    function ()

        self:push()

    end,
    0)
    
end
 

function ManagerGame.tryChangeTo(self, catTo)

    assert(self._focusCat ~= nil)
    assert(catTo ~= nil)

    local catFrom = self._focusCat

    local rowFrom       = catFrom:row()
    local columnFrom    = catFrom:column()

    local rowTo         = catTo:row()
    local columnTo      = catTo:column()
    
    if catFrom:type() < ECatType.ECT_COUNT and catTo:type() < ECatType.ECT_COUNT then
            
        local canFromTo = self:canMakeCombination(catFrom, catTo)
        local canToFrom = false
        
        if not canFromTo then
            canToFrom = self:canMakeCombination(catTo, catFrom)
        end
        
        if canFromTo or canToFrom then

            catFrom:setPosition(rowTo, columnTo)
            catTo:setPosition(rowFrom, columnFrom)
            
            if canFromTo then
                self._catTo = catTo
            elseif canToFrom then
                self._catTo = catFrom
            end
                                
            self:pushes()
 
            self:setFocusCat(nil)

        else

            catFrom:setPosition(rowTo, columnTo)
            catTo:setPosition(rowFrom, columnFrom)

            self._timerChangeCell = timer.performWithDelay(Constants.CHANGE_CELL_TIME,
            function ()
                self._timerChangeCell = nil

                catFrom:setPosition(rowFrom, columnFrom)
                catTo:setPosition(rowTo, columnTo)
            end,
            1)

            --self._catTo = nil

        end
        
    elseif (catFrom:type() == ECatType.ECT_COLOR_BOMB and catTo:type() < ECatType.ECT_COUNT) 
        or (catTo:type() == ECatType.ECT_COLOR_BOMB and catFrom:type() < ECatType.ECT_COUNT) then
        
            catFrom:setPosition(rowTo, columnTo)
            catTo:setPosition(rowFrom, columnFrom)
            
            local catBomb
            
            if catFrom:type() == ECatType.ECT_COLOR_BOMB then
                            
                catBomb = catFrom
                catBomb._bombType = catTo:type()
                
            else
                
                catBomb = catTo
                catBomb._bombType = catFrom:type()
                
            end
            
            self._timerChangeCell = timer.performWithDelay(Constants.CHANGE_CELL_TIME,
            function ()
                self._timerChangeCell = nil

                self:deleteCatsByColorBomb(catBomb)
            end,
            1)
            
        elseif (catFrom:type() == ECatType.ECT_COLOR_BOMB) and (catFrom:type() == catTo:type() ) then 
            
            catFrom:setPosition(rowTo, columnTo)
            catTo:setPosition(rowFrom, columnFrom)

            self._timerChangeCell = timer.performWithDelay(Constants.CHANGE_CELL_TIME,
            function ()
                self._timerChangeCell = nil

                catFrom:setPosition(rowFrom, columnFrom)
                catTo:setPosition(rowTo, columnTo)
            end,
            1)

            --self._catTo = nil
            
    end

end


function ManagerGame.deleteCatsByColorBomb(self, value)
    
    assert(value ~= nil)
    for row = 1, self._rowsCount, 1 do
        for column = 1, self._columnsCount, 1 do
                    
            local cat = self._cats[row][column]
            if cat:type() == value._bombType or cat == value then
                            
                self._tiles[cat:row()][cat:column()] = false
                cat:controller():update(EControllerUpdate.ECUT_NEED_REMOVE)
                cat:cleanup()
                self._cats[row][column] = nil
                
            end
            
        end
    end
    
    self._currentState:update(EControllerUpdate.ECUT_NEED_REMOVE)
    self._currentState:update(EControllerUpdate.ECUT_TILES)
    self:createNewCats()
    self:pushes()
    
end

function ManagerGame.init(self, params)
    ManagerGameBase.init(self, params)

    self._scores = 0

    self._rowsCount     = self._currentLevel:rows()
    self._columnsCount  = self._currentLevel:columns()

    self._focusRow    = 0
    self._focusColumn = 0

    self._cats   = {}
    self._cells  = {}
    self._tiles  = {}

    for rowIndex = 1, self._rowsCount, 1 do

        local rowCell   = {}

        for columnIndex = 1, self._columnsCount, 1 do

            local paramsCell =
            {
                type = ECellType.ECLT_CAT
            }

            local cell  = Cell:new(paramsCell)
            table.insert(rowCell, cell)

        end

        table.insert(self._cells, rowCell)

    end
    
    for rowIndex = 1, self._rowsCount, 1 do

        local rowTile   = {}

        for columnIndex = 1, self._columnsCount, 1 do
        
            local tile  = true
            table.insert(rowTile, tile)

        end

        table.insert(self._tiles, rowTile)

    end
    
    self._isCatsComplete = true
    
end

function ManagerGame.shuffleArray(self, array)
    
    if #array == 1 then
        return
    end
    
    for i = 1, #array, 1 do
                
        local firstIndex = math.random(#array - 1)
        
        local secondIndex = math.random(#array)
        
        if secondIndex == firstIndex then
            
            secondIndex = firstIndex + math.random(#array - firstIndex)
            
        end
        
        local cache = array[firstIndex]
        array[firstIndex] = array[secondIndex]
        array[secondIndex] = cache
        
    end
    
end

function ManagerGame.shuffle(self)
    
    for rowIndex = 1, self._rowsCount, 1 do
                
        self:shuffleArray(self._cats[rowIndex])
        
    end
    
    self:shuffleArray(self._cats)
    
    for rowIndex = 1, self._rowsCount, 1 do
                
        for columnIndex = 1, self._columnsCount, 1 do
            
            local cat = self._cats[rowIndex][columnIndex]
            
            cat:setPosition(rowIndex, columnIndex)
            
        end
        
    end
    
end


function ManagerGame.canMakeCombination(self, catFrom, catTo)

    assert(catFrom ~= nil)
    assert(catTo ~= nil)

    local result

    local rowFrom       = catFrom:row()
    local columnFrom    = catFrom:column()

    local rowTo         = catTo:row()
    local columnTo      = catTo:column()

    self._cats[rowTo][columnTo]     = catFrom
    self._cats[rowFrom][columnFrom] = catTo

    local foundCombinationRow    = self:foundChain(catFrom:type(), 'row',      rowTo ,     3)
    local foundCombinationColumn = self:foundChain(catFrom:type(), 'column',   columnTo,  3)

    local isCombinationFoundRow = table.indexOf(foundCombinationRow, catFrom) ~= nil
    local isCombinationFoundColumn   = table.indexOf(foundCombinationColumn, catFrom) ~= nil
    
    
    result = isCombinationFoundRow or isCombinationFoundColumn

    if not result then

        self._cats[rowTo][columnTo]     = catTo
        self._cats[rowFrom][columnFrom] = catFrom

    end

    return result

end


function ManagerGame.foundCanMakeCombination(self)

    local result = false

    for rowIndex = 1, self._rowsCount - 1, 1 do

        for columnIndex = 1, self._columnsCount - 1, 1 do

            local cat = self._cats[rowIndex][columnIndex]
            local catDown = self._cats[rowIndex + 1][columnIndex]
            local catRight = self._cats[rowIndex][columnIndex + 1]


            if cat:type() ~= catDown:type() then

                result = self:canMakeCombination(cat, catDown)

                if not result then
                    
                    result = self:canMakeCombination(catDown, cat)

                end

            end

             if cat:type() ~= catRight:type() and not result then

                    result = self:canMakeCombination(cat, catRight)

                    if not result then

                        result = self:canMakeCombination(catRight, cat)

                    end

            end

            if result then

                    self._cats[rowIndex][columnIndex] = cat
                    self._cats[rowIndex + 1][columnIndex] = catDown
                    self._cats[rowIndex][columnIndex + 1] = catRight

                    break

            end

        end

        if result then

            break

        end
    end
    

    return result

end

function ManagerGame.cleanup(self)

    if self._timerPush ~= nil then
        timer.cancel(self._timerPush)
        self._timerPush = nil
    end

    if self._timerChangeCell ~= nil then
        timer.cancel(self._timerChangeCell)
        self._timerChangeCell = nil
    end

    ManagerGameBase.cleanup(self)
end

