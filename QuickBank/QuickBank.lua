QuickBank = {}
QuickBank.name = "QuickBank"
QuickBank.savedVars = nil

function QuickBank.OnAddOnLoaded(_, addonName)
    if addonName ~= QuickBank.name then return end

    QuickBank.savedVars = ZO_SavedVars:New("QuickBankSavedVars", 1, nil, {
        depositGold = true,
        depositAP = true,
        depositWrits = true,
        depositTelVar = true,
        panelPos = { left = 100, top = 100 }
    })

    QuickBankSettings.Init()
    QuickBankUI.CreatePanel()

    SCENE_MANAGER:GetScene("bank"):RegisterCallback("StateChange", function(oldState, newState)
        if newState == SCENE_SHOWING then
            QuickBankUI.OnBankOpen()
        elseif newState == SCENE_HIDDEN and QuickBankUI.panel then
            QuickBankUI.panel:SetHidden(true)
        end
    end)

    EVENT_MANAGER:UnregisterForEvent(QuickBank.name, EVENT_ADD_ON_LOADED)
end

EVENT_MANAGER:RegisterForEvent(QuickBank.name, EVENT_ADD_ON_LOADED, QuickBank.OnAddOnLoaded)