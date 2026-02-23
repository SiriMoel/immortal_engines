local card = GetUpdatedEntityID()

local comp_soul_amt = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "immeng_soul_amt")

if comp_soul_amt ~= nil then
    --EntitySetName(card, "Reaper Engine - " .. tostring(ComponentGetValue2(comp_soul_amt, "value_float")))
    --GamePrint("Reaper Engine - " .. tostring(ComponentGetValue2(comp_soul_amt, "value_float")))
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(card, "AbilityComponent"), "ui_name", "Reaper Engine [" .. tostring(ComponentGetValue2(comp_soul_amt, "value_float")) .. "]")
end