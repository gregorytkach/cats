require('game_cats.src.models.purchases.EPurchaseType')
require('game_cats.src.models.bonus.EBonusType')

function getManagerLevels()
    local result = {}
    
    local levels = {}
    
    table.insert(levels, getLevel0Data(true))
    table.insert(levels, getLevel0Data(true))
    table.insert(levels, getLevel0Data(true))
    table.insert(levels, getLevel0Data(true))
    table.insert(levels, getLevel0Data(true))
    table.insert(levels, getLevel0Data(true))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    table.insert(levels, getLevel0Data(false))
    
    result.levels = levels
    
    return result
end

function getManagerPlayers()
    local result = {}
    
    local playerData =
    {
        currency_soft                           = 100,
        energy                                  = 3,
        points                                  = 0,
        
        free_purchase_count_remove_bottom_row   = 10,
        free_purchase_count_shuffle             = 3,
        free_purchase_count_remove_9_cells      = 0
    }
    
    result.player_current = playerData
    
    return result
end

function getManagerBonus()
    local result = {}
    
    local bonuses = 
    {
        {   type            = EBonusType.EBT_REMOVE_BOTTOM_ROW,  content_count   = 1  },
    }
    
    result.bonuses      = bonuses  
    result.time_period  = 10
    result.time_left    = 10
    
    result.energy       = 
    {
        time_period = 15 * 60,
        time_left   = 5,
        bonus       =
        {
            type            = EBonusType.EBT_ENERGY,
            content_count   = 1
        }
    }
    
    return result
end

function getManagerPurchasesData()
    local result = {}
    
    local purchaseDataCurrency = 
    {
        content_count   = 1,
        price_hard      = 10,
        price_soft      = 0,
        name            = "currency_10",
        type            = EPurchaseTypeBase.EPT_CURRENCY_SOFT
    }
    
    table.insert(result, purchaseDataCurrency)
    result[1].price_hard     = 0.99
    result[1].content_count  = 1
    
    table.insert(result, purchaseDataCurrency)
    result[2].price_hard     = 9.99
    result[2].content_count  = 10
    
    table.insert(result, purchaseDataCurrency)
    result[3].price_hard     = 99.99
    result[3].content_count  = 100
    
    
    
    local purchaseDataEnergy =
    {
        content_count   = 1,
        price_hard      = 10,
        price_soft      = 0,
        name            = "energy_10",
        type            = EPurchaseTypeBase.EPT_ENERGY
    }
    
    table.insert(result, purchaseDataEnergy)
    table.insert(result, purchaseDataEnergy)
    table.insert(result, purchaseDataEnergy)
    table.insert(result, purchaseDataEnergy)
    
    local purchaseDataAddTime =
    {
        content_count   = 1,
        price_hard      = 0,
        price_soft      = 10,
        name            = "remove_9_cells",
        type            = EPurchaseType.EPT_REMOVE_9_CELLS
    }
    
    table.insert(result, purchaseDataAddTime)
    
    
    
    local purchaseResolve =
    {
        content_count   = 1,
        price_hard      = 0,
        price_soft      = 10,
        name            = "remove_bottom_row",
        type            = EPurchaseType.EPT_REMOVE_BOTTON_ROW
    }
    
    table.insert(result, purchaseResolve)
    
    local purchaseShowTurn =
    {
        content_count   = 1,
        price_hard      = 0,
        price_soft      = 10,
        name            = "shuffle",
        type            = EPurchaseType.EPT_SHUFFLE
    }
    
    table.insert(result, purchaseShowTurn)
    
    return result
end

function getLevel0Data(isComplete)
    local result =
    {
        reward_scores    = 0,
        
        rows             = 9,
        columns          = 9,
        
        turns_limit      = 50,
        
        
        star_points_1    = 100,
        star_points_2    = 200,
        star_points_3    = 300,
        
        progress =
        {
            is_complete      = isComplete,
            stars_count      = 0,
        }
    }
    
    return result
end
