function()
    -- 1 Spell Known
    -- 2 TSU Base Damage, Cast Time
    -- 3 Spell Power
    -- 4 Character Stats
    -- 5 Darkness (10% damage)
    -- 6 Shadow Power (Crit Damage Bonus)
    -- 7 Twin Disciplines (5% Damage)
    -- 8 Crit Bonus Meta Gem
    -- 9 T7 10% Crit Chance
    -- 10 Glyph of SWD (10% damage under 35%)
    -- 11 Target 35% Health
    local s = aura_env.states
    
    local coeff = 1
    -- Remove Darkness from base so it can stack additively with swp_mult later
    local base = s[2].base / (s[5].show and 1.1 or 1)
    local additional = s[2].additional 
    local damage = (base + additional) + (coeff * s[3].value)
    
    local crit_damage = 1+((1.5) * (s[8].show and 1.03 or 1) - 1) * (s[6].show and 2 or 1)
    local crit = s[4].criticalpercent / 100 + (s[9].show and 0.1 or 0)
    
    local execute = (s[10].show and s[11].show) and 0.1 or 0
    
    local multipliers = (1 + execute + (s[5].show and 0.1 or 0) + (s[7].show and 0.05 or 0)) * ((crit * crit_damage) + (1-crit))
    
    aura_env.dpct = damage * multipliers / s[2].cast_time
    aura_env.finaldamage = damage * multipliers

    
    -- DEBUG
    if false then
        DevTools_Dump({
                [aura_env.id] = {
                    base = s[2].base,
                    additional = s[2].additional
                    coeff = coeff,
                    cast_time = s[2].cast_time,
                    sp = s[3].value,
                    meta = not not s[10].show,
                    T6 = not not s[11].show,
                    crit = crit,
                    crit_damage = crit_damage,
                    multipliers = multipliers,
                    damage = damage * multipliers,
                    execute = execute,
                }
        })
    end
    return string.format("%d", aura_env.dpct), string.format("%d", aura_env.finaldamage)
end

