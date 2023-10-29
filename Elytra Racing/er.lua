local world = World:new('creative');

---------------------------------------------------
----------Elytra Racing Lobby----------------------
---------------------------------------------------

function er_mode(data)
        local p = Player:new(data["player"]);
        p:setMode("ADVENTURE");
end

registerHook("REGION_ENTER", "er_mode", "creative-centralan_8");
registerHook("REGION_LEAVE", "er_mode", "creative-er_gamemode);
