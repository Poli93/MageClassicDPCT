-- Custom
-- Status
-- Event(s): SPELL_POWER_CHANGED
function()
    -- Get Frost Spell Damage
    aura_env.sp = GetSpellBonusDamage(3) or 0
    return true
end

-- Duration Info
function()
    return aura_env.sp, aura_env.sp, true
end
