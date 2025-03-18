-- ========================= --
--- Framework Normalization ---
-- ========================= --
if (Config.Framework == 'auto' and GetResourceState('qbx_core') == 'started') or Config.Framework == 'qbox' then
    Config.Framework = 'qbox'
elseif (Config.Framework == 'auto' and GetResourceState('qb-core') == 'started') or Config.Framework == 'qb' then
    Config.Framework = 'qb'
elseif (Config.Framework == 'auto' and GetResourceState('es_extended') == 'started') or Config.Framework == 'esx' then
    Config.Framework = 'esx'
elseif Config.Framework == 'standalone' then
    lib.print.info(
        'You are using the standalone framework. Make sure to implement the functions in `(client/server)/custom/frameworks/standalone.lua`.')
else
    error('You need to set the Config.Framework to \'qb\', \'esx\' or \'qbox\'!')
end
-- ========================= --
--- Framework Normalization ---
-- ========================= --

-- =================== --
--- Banking Detection ---
-- =================== --
if Config.Banking == 'auto' then
    debugPrint('Auto-detecting banking option...')

    --- A list of supported bankings by default. Do not change this list unless you know what you are doing.
    local bankings = {
        'tgg-banking',
        'okokBanking',
        'Renewed-Banking',
        'snipe-banking',
        's1n_banking',
        'fd_banking',
        'qb-banking',
        'esx_addonaccount',
        'qb-management',
    }

    for i = 1, #bankings do
        if GetResourceState(bankings[i]):find('start') then
            Config.Banking = bankings[i]
            break
        end
    end

    if Config.Banking == 'auto' then
        print("^6[Billing] ^1[ERROR]^7: shared:resourceDetection.lua: No banking resource found. Make sure to install one of the supported bankings.")
        return
    end

    debugPrint('Auto-detected banking option: ' .. Config.Banking)
end
-- =================== --
--- Banking Detection ---
-- =================== --

-- ================= --
--- Phone Detection ---
-- ================= --
if Config.PhoneResourceName == 'auto' then
    debugPrint('Auto-detecting phone resource...')

    --- A list of supported bankings by default. Do not change this list unless you know what you are doing.
    local phoneResources = {
        'yflip-phone',
        'yphone',
        'yseries',
    }

    for i = 1, #phoneResources do
        if GetResourceState(phoneResources[i]):find('start') then
            Config.PhoneResourceName = phoneResources[i]
            break
        end
    end

    if Config.PhoneResourceName == 'auto' then
        print("^6[Billing] ^1[ERROR]^7: shared:resourceDetection.lua: No phone resource found. Make sure to install one of the supported phone resources.")
        return
    end

    debugPrint('Auto-detected phone resource: ' .. Config.PhoneResourceName)
end
-- ================= --
--- Phone Detection ---
-- ================= --
