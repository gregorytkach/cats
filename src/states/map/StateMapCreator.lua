require('game_cats.src.states.map.StateMap')

local state = StateMap:new()

GameInfo:instance():managerStates():onCurrentStateCreated(state);

return state:sceneStoryboard()

