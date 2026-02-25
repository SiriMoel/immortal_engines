dofile_once("mods/immortal_engines/files/scripts/utils.lua")
dofile_once("mods/immortal_engines/files/scripts/soul.lua")

function material_area_checker_success( pos_x, pos_y )
	local entity = GetUpdatedEntityID()

	local x,y = EntityGetTransform(entity)

    ConvertMaterialOnAreaInstantly(x - 25, y - 30, 50, 60, CellFactory_GetType("radioactive_liquid"), CellFactory_GetType("smoke"), false, false)

    AddSoulToSystem(entity, 2)
end
