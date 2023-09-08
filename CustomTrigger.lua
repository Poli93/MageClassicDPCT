-- Trigger State Updater (Advanced)
-- Event(s): UNIT_SPELL_HASTE:player SPELLS_CHANGED SPELL_UPDATE_COOLDOWN PLAYER_TALENT_UPDATE
function(allstates, event, isFake)
    if not allstates[""] then allstates[""] = {
            show = true,
            changed = true,
            progressType = "static"
        }
    end
    local state = allstates[""]
    state.changed = true
    
    local desc = GetSpellDescription(GetSpellInfo(133))
    local min, max = desc:match("(%d+) to (%d+)")
    if not min then
        min, max = 0, 0 
    end
    state.base = (min + max) / 2
    
    -- Use Mind Blast for GCD time
    local cast_time = select(4,GetSpellInfo(select(1,GetSpellInfo(133)))) / 1000
    state.cast_time = math.max(cast_time, 1)
    
    if event == "SPELLS_CHANGED" and not isFake then
        C_Timer.After(0.5, function()
                WeakAuras.ScanEvents("SPELLS_CHANGED", true)
        end)
    end
    
    return true
end



