ViewCat = classWithSuper(ViewBase, 'ViewCat')
--
--Properties
--

function ViewCat.getGroup(self)
    
    return self._group
    
end

function ViewCat.setGroup(self, group)
    
    assert(group ~= nil)
    
    self._group = group
    
end

--
--Methods
--



function ViewCat.init(self, params)
    
    assert(params.type  ~= nil)
    
    ViewBase.init(self, params)
    
    local managerResources = GameInfo:instance():managerResources()
    
    self._sourceView = display.newGroup()
    
    local _type = ''..params.type
    
    local image = managerResources:getAsImageWithParam(EResourceType.ERT_STATE_GAME_VIEW_CAT, _type).."%s_01.png"
    
    self._viewCat = self:createSprite(string.format(image, _type ))
    self._sourceView:insert(self._viewCat:sourceView())
    
end


function ViewCat.cleanup(self)
    
    self._viewCat:cleanup()
    self._viewCat = nil
    
    self._sourceView:removeSelf()
    self._sourceView = nil
    
    self._group = nil
    
    ViewBase.cleanup(self)
end