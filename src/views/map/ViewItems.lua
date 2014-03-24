ViewItems = classWithSuper(ViewBase, 'ViewItems')

function ViewItems.init(self, params)
    ViewBase.init(self, params)
    
    self._sourceView = display.newGroup()
    
    self._items = {}
    
end

function ViewItems.addItem(self, view)
    assert(view ~= nil)
    
    table.insert(self._items, view)
    
    self._sourceView:insert(view:sourceView())
end

function ViewItems.placeViews(self)
    ViewBase.placeViews(self)
    
    local viewsPositions = 
    {   
        { x = 117, y = 257 },
        { x = 71, y = 275 },
        { x = 46, y = 370 },
        { x = 232, y = 219 },
        { x = 317, y = 234 },
        { x = 283, y = 198 },
        { x = 331, y = 144 },
        { x = 455, y = 204 },
        { x = 202, y = 387 },
        { x = 387, y = 139 },
        { x = 92,  y = 386 },
        { x = 455, y = 145 },	
        { x = 473, y = 388 },	
        { x = 407, y = 483 },	
        { x = 541, y = 294 },	
        { x = 615, y = 223 },	
        { x = 537, y = 390 },	
        { x = 647, y = 171 },	
        { x = 602, y = 125 },	
        { x = 725, y = 160 },	
        { x = 839, y = 209 },	
        { x = 918, y = 293 },
        { x = 878, y = 483 },	
        { x = 978, y = 261 },	
        { x = 897, y = 165 },	
        { x = 1005, y = 329 },
        { x = 1131, y = 361 },
        { x = 763, y = 92 },
        { x = 1087, y = 211 },	
        { x = 1210, y = 123 },	
        { x = 1197, y = 340 },	
        { x = 1383, y = 346 },	
        { x = 1433, y = 357 },	
        { x = 1017, y = 81 },	
        { x = 1058, y = 349 },	
        { x = 1262, y = 178 },	
        { x = 1133, y = 251 },	
        { x = 1442, y = 65 },	
        { x = 1452, y = 456 },	
        { x = 615, y = 220 },	
        { x = 1477, y = 103 },	
        { x = 409, y = 388 },
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },	
        { x = 500, y = 500 },
    }
    
    for i, view in ipairs(self._items)do
        local viewCoords = viewsPositions[i]
        
        view:placeViews()
        view:sourceView().x = viewCoords.x + application.margin_left
        view:sourceView().y = viewCoords.y
        
        view:hide(0)
    end
    
end





