ViewPopupCatsBase = classWithSuper(ViewPopup, 'ViewPopupCatsBase')

function ViewPopupCatsBase.init(self, params)
    ViewPopup.init(self, params)
    
    self._sourceView = display.newGroup()
end

function ViewPopupCatsBase.initBackground(self, image)
    self._background = self:createSprite(image) 
end

function ViewPopupCatsBase.initTitle(self, stringType)
    
    self._labelTitle = self:createLabel(GameInfo:instance():managerString():getString(stringType), EFontType.EFT_2)
    
end


function ViewPopupCatsBase.placeViews(self)
    
    local realHeight = self._background:realHeight()
    
    self._background:sourceView().x = 0
    self._background:sourceView().y = 0
    
    ViewPopup.placeViews(self)
end


function ViewPopupCatsBase.cleanup(self)
    
    self._background:cleanup()
    self._background = nil
    
    self._labelTitle:cleanup()
    self._labelTitle = nil
    
    ViewPopup.cleanup(self)
end

