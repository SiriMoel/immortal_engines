dofile_once("mods/immortal_engines/files/scripts/utils.lua")
dofile_once("mods/immortal_engines/files/scripts/soul.lua")

ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/immortal_engines/files/actions.lua")

-- translations
local translations = ModTextFileGetContent("data/translations/common.csv")
if translations ~= nil then
    while translations:find("\r\n\r\n") do
        translations = translations:gsub("\r\n\r\n","\r\n")
    end
    local new_translations = ModTextFileGetContent(table.concat({"mods/immortal_engines/files/translations.csv"}))
    translations = translations .. new_translations
    ModTextFileSetContent("data/translations/common.csv", translations)
end