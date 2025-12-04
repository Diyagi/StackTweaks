ModName, ModVersion = "Stack Tweaks", "1.0.1"
local stackTweaks = require("stackTweaks")

local preId, posId = nil, nil

-- TODO: Find a function to hook into for this, relying on delay is badge
ExecuteWithDelay(3000, function()
    ExecuteInGameThread(function()
        local masterItemList = StaticFindObject("/Game/SurvivalGameKitV2/Blueprints/Items/MasterLists/MasterItemList.MasterItemList")
        
        masterItemList:ForEachRow(function(rowName, rowData)
            local stackConfig = stackTweaks[rowName]
            if not stackConfig then return end
            
            rowData.AllowStacking_48_02CFD0D74B05709E8E432E824709C714 = stackConfig.allowStack
            rowData.MaxStack_18_C57243124FFDE0AB28797AA6F2C1E5F5 = stackConfig.stackSize
        end)
        
        print("Stack Tweaks Applied!")
    end)
end)