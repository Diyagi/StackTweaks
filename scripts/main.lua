ModName, ModVersion = "Stack Tweaks", "1.0.2"
local stackTweaks = require("stackTweaks")

ExecuteInGameThread(function()
    LoadAsset("/Game/SurvivalGameKitV2/Blueprints/Characters/BP_SGKController.BP_SGKController_C")
    RegisterHook("/Game/SurvivalGameKitV2/Blueprints/Characters/BP_SGKController.BP_SGKController_C:ReceiveBeginPlay", function(self)
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
