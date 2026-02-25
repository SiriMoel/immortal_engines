local card = GetUpdatedEntityID()
local x, y = EntityGetTransform(card)

local comp_soul_amt = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "immeng_soul_amt")

if comp_soul_amt ~= nil then
    local soul_amt = ComponentGetValue2(comp_soul_amt, "value_float")
    local frame = GameGetFrameNum()
    if soul_amt < 1 then
        GameCreateCosmeticParticle("spark_red", x, y, 1, -10 * math.sin(frame), 60 * math.sin(frame), nil, 0.5, 1.2)
    else
        GameCreateCosmeticParticle("spark_blue", x, y, 1, 10 * math.sin(frame), -60 * math.sin(frame), nil, 0.5, 1.2)
    end
end