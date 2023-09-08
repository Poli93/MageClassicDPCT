-- Actions, On Init, Custom:
aura_env.totems = setmetatable({
        [28248] = 55,  -- Totem of the Void
        [32330] = 85,  -- Totem of Ancestral Guidance
        [40267] = 165, -- Totem of Hex
    },
    {
        __index = function() return 0 end -- Return 0 for any other item
    }
)

