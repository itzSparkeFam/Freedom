Skin = {}
Skin.Enabled = true                                                              -- Set to false if you want use some third-party skin creator resource. Might need additional configuration.
Skin.EnableRefreshSkinCommand = true                                             -- /refreshSkin command can be turned off here
Skin.EnableAutoMaskClipping = true                                               -- Fix for face clipping trough the mask.
Skin.GenerateRandomSkin = true                                                   -- Set to false to let players start customization from default freemdoe ped, not the randomized
Skin.CreatingPoint = vector4(-819.68, -723.71, 105.87, 2.87)                     -- This is coordinates where player creating his player (skin) after register
Skin.EnableTattoosDeleting = true                                                -- Set to false to not let players delete tattoos
Skin.RememberLastOutfit = false                                                  -- Set to true to save your last weared outfit
Skin.EnableONXCustomFaces = GetResourceState("cfx_onx_mp_faces") ~= "missing"    -- Set to true if you're using
Skin.OpenCustomSkinMenuOnLoad = true                                             -- Used only if Skin.Enabled is set to false, set to false if u have double skin menu when creating new character
Skin.HardcodedMasksToClip = {                                                    -- Masks that needs to shrink, even tho game says no
    [11] = true,
    [30] = true,
}


Skin.MaskClippingWhitelist = { -- Masks that shouldn't be shrinked even if game says yes
    [11] = true,
    [72] = true,
    [114] = true,
    [145] = true,
    [148] = true,
}

Skin.Categories = { -- Here you can adjust skin components categories
    {
        name = "dna",
        icon = "./images/DnaIcon.svg",
    },
    {
        name = "clothes",
        icon = "./images/ClothesIcon.svg",
    },
    {
        name = "details",
        icon = "./images/BodyIcon.svg",
    },
    {
        name = "accessories",
        icon = "./images/AccessoriesIcon.svg",
    },
}

Skin.BlacklistedInputValues = { -- Here you can blacklist some clothes (inputs values)
    -- [`modelName`]] = {
    --     ["input_name"] = { numbersOfBlacklistedValues },
    -- },
    -- Example:
    -- [`mp_m_freemode_01`] = {
    --     ["tshirt_1"] = { 15, 16, 17 },
    -- },
    -- [`mp_f_freemode_01`] = {
    --     ["tshirt_1"] = { 17, 18 },
    -- },
}

Skin.WhitelistedInputValues = { -- Here you can whitelist (overwrite blacklist for some players) some clothes (inputs values)
    -- [`modelName`] = {
    --     {
    --         name = "input_name",
    --         values = { 1, 2, 3, 4, 5 },
    --         jobs = {},
    --         gangs = {},
    --         identifiers = {}
    --     },
    -- },

    -- [`mp_m_freemode_01`] = {
    --     {
    --         name = "tshirt_1",
    --         values = { 15, 16 },
    --         jobs = { "police" },
    --         gangs = { "ballas" },
    --         identifiers = { "license:8cbd53588ae8a50cf28da72afa411ca2453fde40" }
    --     },
    -- },
    -- [`mp_f_freemode_01`] = {
    --     {
    --         name = "tshirt_1",
    --         values = { 17 },
    --         jobs = { "ambunalce" },
    --         gangs = { "vagos" },
    --         identifiers = { "discord:863013393253138452" }
    --     },
    -- },
}

Skin.Presets = { -- This is list of predefined presets. You can create some preset and use them while opening skin menu (must be Skin.Components[i].name)
    ["barber"] = {
        "hair", "beard", "eyebrows", "chest"
    },

    ["clothing"] = {
        "tshirt", "torso", "arms", "bproof", "pants", "shoes", "helmet", "mask", "watches", "ears", "chain", "glasses",
        "bags", "makeup",
    },

    ["surgeon"] = {
        "player", "jaw", "nose", "eyebrows", "blush", "age", "chin", "moles", "cheeks", "blemishes", "complexion", "sun",
        "bodyb",
    },

    ["skinCommand"] = {
        "player", "tshirt", "torso", "arms", "bproof", "pants", "shoes", "hair", "lipstick", "jaw", "eyebrows", "nose", "blush", "makeup", "helmet", "mask",  "watches", "age", "chin", "beard", "ears", "chain", "glasses", "moles", "cheeks", "bags", "blemishes", "complexion", "sun", "chest", "bodyb", "decals", "eyes"
    },

    ["creator"] = {
        "player", "tshirt", "torso", "arms", "bproof", "pants", "shoes", "hair", "lipstick", "jaw", "eyebrows", "nose", "blush", "makeup", "helmet", "mask",  "watches", "age", "chin", "beard", "ears", "chain", "glasses", "moles", "cheeks", "bags", "blemishes", "complexion", "sun", "chest", "bodyb", "decals", "eyes"
    },

    ["tattoo"] = {
        "tattoos_head", "tattoos_torso", "tattoos_right_arm", "tattoos_left_arm", "tattoos_right_leg", "tattoos_left_leg",
    }
}

Skin.Components = { -- This is array including all skin components, here you can move components between categories or change components inputs
    {
        name = "player",
        label = _L("Skin.Ped.Title"),
        description = _L("Skin.Ped.Description"),
        category = "dna",
        inputs = { "sex", "mom", "dad", "faceMix", "skinMom", "skinDad", "skinMix" }
    },
    {
        name = "tshirt",
        label = _L("Skin.Tshirt.Title"),
        description = _L("Skin.Tshirt.Description"),
        category = "clothes",
        inputs = { "tshirt_1", "tshirt_2" }
    },
    {
        name = "torso",
        label = _L("Skin.Torso.Title"),
        description = _L("Skin.Torso.Description"),
        category = "clothes",
        inputs = { "torso_1", "torso_2" }
    },
    {
        name = "arms",
        label = _L("Skin.Arms.Title"),
        description = _L("Skin.Arms.Description"),
        category = "clothes",
        inputs = { "arms", "arms_2" }
    },
    {
        name = "bproof",
        label = _L("Skin.Bproof.Title"),
        description = _L("Skin.Bproof.Description"),
        category = "clothes",
        inputs = { "bproof_1", "bproof_2" }
    },
    {
        name = "pants",
        label = _L("Skin.Pants.Title"),
        description = _L("Skin.Pants.Description"),
        category = "clothes",
        inputs = { "pants_1", "pants_2" }
    },
    {
        name = "shoes",
        label = _L("Skin.Shoes.Title"),
        description = _L("Skin.Shoes.Description"),
        category = "clothes",
        inputs = { "shoes_1", "shoes_2" }
    },
    {
        name = "hair",
        label = _L("Skin.Hair.Title"),
        description = _L("Skin.Hair.Description"),
        category = "dna",
        inputs = { "hair_1", "hair_2", "hair_3", "hair_4" }
    },
    {
        name = "lipstick",
        label = _L("Skin.Lipstick.Title"),
        description = _L("Skin.Lipstick.Description"),
        category = "details",
        inputs = { "lip_thickness", "lipstick_1", "lipstick_2", "lipstick_3" }
    },
    {
        name = "jaw",
        label = _L("Skin.Jaw.Title"),
        description = _L("Skin.Jaw.Description"),
        category = "dna",
        inputs = { "neck_thickness", "jaw_1", "jaw_2" }
    },
    {
        name = "eyebrows",
        label = _L("Skin.Eyebrows.Title"),
        description = _L("Skin.Eyebrows.Description"),
        category = "dna",
        inputs = { "eyebrows_1", "eyebrows_2", "eyebrows_5", "eyebrows_6", "eyebrows_3" }
    },
    {
        name = "nose",
        label = _L("Skin.Nose.Title"),
        description = _L("Skin.Nose.Description"),
        category = "dna",
        inputs = { "nose_1", "nose_2", "nose_3", "nose_4", "nose_5", "nose_6" }
    },
    {
        name = "blush",
        label = _L("Skin.Blush.Title"),
        description = _L("Skin.Blush.Description"),
        category = "details",
        inputs = { "blush_1", "blush_2", "blush_3" }
    },
    {
        name = "makeup",
        label = _L("Skin.Makeup.Title"),
        description = _L("Skin.Makeup.Description"),
        category = "details",
        inputs = { "makeup_1", "makeup_2", "makeup_3", "makeup_4" }
    },
    {
        name = "helmet",
        label = _L("Skin.Helmet.Title"),
        description = _L("Skin.Helmet.Description"),
        category = "clothes",
        inputs = { "helmet_1", "helmet_2" }
    },
    {
        name = "mask",
        label = _L("Skin.Mask.Title"),
        description = _L("Skin.Mask.Description"),
        category = "clothes",
        inputs = { "mask_1", "mask_2" }
    },
    {
        name = "watches",
        label = _L("Skin.Watches.Title"),
        description = _L("Skin.Watches.Description"),
        category = "accessories",
        inputs = { "watches_1", "watches_2", "bracelets_1", "bracelets_2" }
    },
    {
        name = "age",
        label = _L("Skin.Age.Title"),
        description = _L("Skin.Age.Description"),
        category = "details",
        inputs = { "age_1", "age_2" }
    },
    {
        name = "chin",
        label = _L("Skin.Chin.Title"),
        description = _L("Skin.Chin.Description"),
        category = "dna",
        inputs = { "chin_1", "chin_2", "chin_3", "chin_4" }
    },
    {
        name = "beard",
        label = _L("Skin.Beard.Title"),
        description = _L("Skin.Beard.Description"),
        category = "dna",
        inputs = { "beard_1", "beard_2", "beard_3" }
    },
    {
        name = "ears",
        label = _L("Skin.Ears.Title"),
        description = _L("Skin.Ears.Description"),
        category = "accessories",
        inputs = { "ears_1", "ears_2" }
    },
    {
        name = "chain",
        label = _L("Skin.Chain.Title"),
        description = _L("Skin.Chain.Description"),
        category = "accessories",
        inputs = { "chain_1", "chain_2" }
    },
    {
        name = "glasses",
        label = _L("Skin.Glasses.Title"),
        description = _L("Skin.Glasses.Description"),
        category = "accessories",
        inputs = { "glasses_1", "glasses_2" }
    },
    {
        name = "moles",
        label = _L("Skin.Moles.Title"),
        description = _L("Skin.Moles.Description"),
        category = "details",
        inputs = { "moles_1", "moles_2" }
    },
    {
        name = "cheeks",
        label = _L("Skin.Cheeks.Title"),
        description = _L("Skin.Cheeks.Description"),
        category = "dna",
        inputs = { "cheeks_1", "cheeks_2", "cheeks_3" }
    },
    {
        name = "bags",
        label = _L("Skin.Bag.Title"),
        description = _L("Skin.Bag.Description"),
        category = "clothes",
        inputs = { "bags_1", "bags_2" }
    },
    {
        name = "blemishes",
        label = _L("Skin.Blemishes.Title"),
        description = _L("Skin.Blemishes.Description"),
        category = "details",
        inputs = { "blemishes_1", "blemishes_2" }
    },
    {
        name = "complexion",
        label = _L("Skin.Complexion.Title"),
        description = _L("Skin.Complexion.Description"),
        category = "details",
        inputs = { "complexion_1", "complexion_2" }
    },
    {
        name = "sun",
        label = _L("Skin.Sun.Title"),
        description = _L("Skin.Sun.Description"),
        category = "details",
        inputs = { "sun_1", "sun_2" }
    },
    {
        name = "chest",
        label = _L("Skin.Chest.Title"),
        description = _L("Skin.Chest.Description"),
        category = "details",
        inputs = { "chest_1", "chest_2", "chest_3" }
    },
    {
        name = "bodyb",
        label = _L("Skin.Bodyb.Title"),
        description = _L("Skin.Bodyb.Description"),
        category = "details",
        inputs = { "bodyb_1", "bodyb_2" }
    },
    {
        name = "decals",
        label = _L("Skin.Decals.Title"),
        description = _L("Skin.Decals.Description"),
        category = "details",
        inputs = { "decals_1", "decals_2" }
    },
    {
        name = "eyes",
        label = _L("Skin.Eyes.Title"),
        description = _L("Skin.Eyes.Description"),
        category = "dna",
        inputs = { "eye_squint", "eye_color" }
    },
    {
        name = "tattoos_head",
        label = _L("Skin.Tattoos.Head.Title"),
        description = _L("Skin.Tattoos.Head.Description"),
        category = "details",
        inputs = { "ZONE_HEAD", "ZONE_HEAD_SAVE"},
    },

    {
        name = "tattoos_torso",
        label = _L("Skin.Tattoos.Torso.Title"),
        description = _L("Skin.Tattoos.Torso.Description"),
        category = "details",
        inputs = { "ZONE_TORSO", "ZONE_TORSO_SAVE"},
    },

    {
        name = "tattoos_right_arm",
        label = _L("Skin.Tattoos.RightArm.Title"),
        description = _L("Skin.Tattoos.RightArm.Description"),
        category = "details",
        inputs = { "ZONE_RIGHT_ARM", "ZONE_RIGHT_ARM_SAVE"},
    },

    {
        name = "tattoos_left_arm",
        label = _L("Skin.Tattoos.LeftArm.Title"),
        description = _L("Skin.Tattoos.LeftArm.Description"),
        category = "details",
        inputs = { "ZONE_LEFT_ARM", "ZONE_LEFT_ARM_SAVE"},
    },

    {
        name = "tattoos_right_leg",
        label = _L("Skin.Tattoos.RightLeg.Title"),
        description = _L("Skin.Tattoos.RightLeg.Description"),
        category = "details",
        inputs = { "ZONE_RIGHT_LEG", "ZONE_RIGHT_LEG_SAVE"},
    },

    {
        name = "tattoos_left_leg",
        label = _L("Skin.Tattoos.LeftLeg.Title"),
        description = _L("Skin.Tattoos.LeftLeg.Description"),
        category = "details",
        inputs = { "ZONE_LEFT_LEG", "ZONE_LEFT_LEG_SAVE"},
    },
}

Skin.InputsData = { -- This is all inputs with their mapping to natives
    ["sex"] = {
        mapping = "model",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Sex"),
    },
    ["mom"] = {
        mapping = "momFace",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Mom"),
    },
    ["dad"] = {
        mapping = "dadFace",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Dad"),
    },

    ["skinMom"] = {
        mapping = "skinMom",
        value = 0,
        type = "number",
        label = _L("Skin.Input.SkinMom"),
    },

    ["skinDad"] = {
        mapping = "skinDad",
        value = 0,
        type = "number",
        label = _L("Skin.Input.SkinDad"),
    },

    ["skinMix"] = {
        mapping = "skinMix",
        value = 0.5,
        type = "range",
        label = _L("Skin.Input.SkinMix"),
        labelMin = _L("Skin.Input.SkinMixMin"),
        labelMax = _L("Skin.Input.SkinMixMax"),
    },
    ["faceMix"] = {
        mapping = "faceMix",
        value = 0.5,
        type = "range",
        label = _L("Skin.Input.FaceMix"),
        labelMin = _L("Skin.Input.FaceMixMin"),
        labelMax = _L("Skin.Input.FaceMixMax"),
    },
    ["arms"] = {
        mapping = "components[3].drawable", -- 5 is a value of any index here. Script will find index automatically.
        value = 0,
        type = "number",
        label = _L("Skin.Input.Arms"),
    },
    ["arms_2"] = {
        mapping = "components[3].variation", -- 5 is a value of any index here. Script will find index automatically.
        value = 0,
        type = "number",
        label = _L("Skin.Input.Arms_2"),
    },
    ["hair_1"] = {
        mapping = "components[2].drawable",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Hair_1"),
    },
    ["hair_2"] = {
        mapping = "components[2].style",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Hair_2"),
    },
    ["hair_3"] = {
        mapping = "hairColor.color",
        value = 0,
        type = "color",
        label = _L("Skin.Input.Hair_3"),
    },
    ["hair_4"] = {
        mapping = "hairColor.highlight",
        value = 0,
        type = "color",
        label = _L("Skin.Input.Hair_4"),
    },
    ["lipstick_1"] = {
        mapping = "faceData[8].overlayValue",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Lipstick_1"),
    },
    ["lipstick_2"] = {
        mapping = "faceData[8].opacity",
        value = 0.5,
        type = "range",
        label = _L("Skin.Input.Lipstick_2"),
        labelMin = _L("Skin.Input.Lipstick_2Min"),
        labelMax = _L("Skin.Input.Lipstick_2Max"),
    },
    ["lipstick_3"] = {
        mapping = "faceData[8].color",
        value = 0,
        type = "color",
        label = _L("Skin.Input.Lipstick_3"),
    },
    ["lipstick_4"] = {
        mapping = "faceData[8].highlight",
        value = 0,
        type = "color",
        label = _L("Skin.Input.Lipstick_4"),
    },
    ["decals_1"] = {
        mapping = "components[10].drawable",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Decals_1"),
    },
    ["decals_2"] = {
        mapping = "components[10].variation",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Decals_2"),
    },
    ["shoes_1"] = {
        mapping = "components[6].drawable",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Shoes_1"),
    },
    ["shoes_2"] = {
        mapping = "components[6].variation",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Shoes_2"),
    },
    ["jaw_1"] = {
        mapping = "faceFeatures[13].value",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Jaw_1"),
        labelMin = _L("Skin.Input.Jaw_1Min"),
        labelMax = _L("Skin.Input.Jaw_1Max"),
    },
    ["jaw_2"] = {
        mapping = "faceFeatures[14].value",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Jaw_2"),
        labelMin = _L("Skin.Input.Jaw_2Min"),
        labelMax = _L("Skin.Input.Jaw_2Max"),
    },
    ["bproof_1"] = {
        mapping = "components[9].drawable",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Bproof_1"),
    },
    ["bproof_2"] = {
        mapping = "components[9].variation",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Bproof_2"),
    },
    ["tshirt_1"] = {
        mapping = "components[8].drawable",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Tshirt_1"),
    },
    ["tshirt_2"] = {
        mapping = "components[8].variation",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Tshirt_2"),
    },
    ["eyebrows_1"] = {
        mapping = "faceData[2].overlayValue",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Eyebrows_1"),
    },
    ["eyebrows_2"] = {
        mapping = "faceData[2].opacity",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Eyebrows_2"),
        labelMin = _L("Skin.Input.Eyebrows_2Min"),
        labelMax = _L("Skin.Input.Eyebrows_2Max"),
    },
    ["eyebrows_3"] = {
        mapping = "faceData[2].color",
        value = 0,
        type = "color",
        label = _L("Skin.Input.Eyebrows_3"),
    },
    ["eyebrows_4"] = {
        mapping = "faceData[2].highlight",
        value = 0,
        type = "color",
        label = _L("Skin.Input.Eyebrows_4"),
    },
    ["eyebrows_5"] = {
        mapping = "faceFeatures[6].value",
        value = 0.5,
        type = "range",
        label = _L("Skin.Input.Eyebrows_5"),
        labelMin = _L("Skin.Input.Eyebrows_5Min"),
        labelMax = _L("Skin.Input.Eyebrows_5Max"),
    },
    ["eyebrows_6"] = {
        mapping = "faceFeatures[7].value",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Eyebrows_6"),
        labelMin = _L("Skin.Input.Eyebrows_6Min"),
        labelMax = _L("Skin.Input.Eyebrows_6Max"),
    },
    ["nose_1"] = {
        mapping = "faceFeatures[0].value",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Nose_1"),
        labelMin = _L("Skin.Input.Nose_1Min"),
        labelMax = _L("Skin.Input.Nose_1Max"),
    },
    ["nose_2"] = {
        mapping = "faceFeatures[1].value",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Nose_2"),
        labelMin = _L("Skin.Input.Nose_2Max"),
        labelMax = _L("Skin.Input.Nose_2Min"),
    },
    ["nose_3"] = {
        mapping = "faceFeatures[2].value",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Nose_3"),
        labelMin = _L("Skin.Input.Nose_3Max"),
        labelMax = _L("Skin.Input.Nose_3Min"),
    },
    ["nose_4"] = {
        mapping = "faceFeatures[3].value",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Nose_4"),
        labelMin = _L("Skin.Input.Nose_4Min"),
        labelMax = _L("Skin.Input.Nose_4Max"),
    },
    ["nose_5"] = {
        mapping = "faceFeatures[4].value",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Nose_5"),
        labelMin = _L("Skin.Input.Nose_5Max"),
        labelMax = _L("Skin.Input.Nose_5Min"),
    },
    ["nose_6"] = {
        mapping = "faceFeatures[5].value",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Nose_6"),
        labelMin = _L("Skin.Input.Nose_6Min"),
        labelMax = _L("Skin.Input.Nose_6Max"),
    },
    ["blush_1"] = {
        mapping = "faceData[5].overlayValue",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Blush_1"),
    },
    ["blush_2"] = {
        mapping = "faceData[5].opacity",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Blush_2"),
        labelMin = _L("Skin.Input.Blush_2Min"),
        labelMax = _L("Skin.Input.Blush_2Max"),
    },
    ["blush_3"] = {
        mapping = "faceData[5].color",
        value = 0,
        type = "color",
        label = _L("Skin.Input.Blush_3"),
    },
    ["makeup_1"] = {
        mapping = "faceData[4].overlayValue",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Makeup_1"),
    },
    ["makeup_2"] = {
        mapping = "faceData[4].opacity",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Makeup_2"),
        labelMin = _L("Skin.Input.Makeup_2Min"),
        labelMax = _L("Skin.Input.Makeup_2Max"),
    },
    ["makeup_3"] = {
        mapping = "faceData[4].color",
        value = 0,
        type = "color",
        label = _L("Skin.Input.Makeup_3"),
    },
    ["makeup_4"] = {
        mapping = "faceData[4].highlight",
        value = 0,
        type = "color",
        label = _L("Skin.Input.Makeup_4"),
    },
    ["helmet_1"] = {
        mapping = "props[0].drawable",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Helmet_1"),
    },
    ["helmet_2"] = {
        mapping = "props[0].variation",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Helmet_2"),
    },
    ["mask_1"] = {
        mapping = "components[1].drawable",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Mask_1"),
    },
    ["mask_2"] = {
        mapping = "components[1].variation",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Mask_2"),
    },
    ["watches_1"] = {
        mapping = "props[6].drawable",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Watches_1"),
    },
    ["watches_2"] = {
        mapping = "props[6].variation",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Watches_2"),
    },
    ["age_1"] = {
        mapping = "faceData[3].overlayValue",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Age_1"),
    },
    ["age_2"] = {
        mapping = "faceData[3].opacity",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Age_2"),
        labelMin = _L("Skin.Input.Age_2Min"),
        labelMax = _L("Skin.Input.Age_2Max"),
    },
    ["chin_1"] = {
        mapping = "faceFeatures[15].value",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Chin_1"),
        labelMin = _L("Skin.Input.Chin_1Min"),
        labelMax = _L("Skin.Input.Chin_1Max"),
    },
    ["chin_2"] = {
        mapping = "faceFeatures[16].value",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Chin_2"),
        labelMin = _L("Skin.Input.Chin_2Min"),
        labelMax = _L("Skin.Input.Chin_2Max"),
    },
    ["chin_3"] = {
        mapping = "faceFeatures[17].value",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Chin_3"),
        labelMin = _L("Skin.Input.Chin_3Min"),
        labelMax = _L("Skin.Input.Chin_3Max"),
    },
    ["chin_4"] = {
        mapping = "faceFeatures[18].value",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Chin_4"),
        labelMin = _L("Skin.Input.Chin_4Min"),
        labelMax = _L("Skin.Input.Chin_4Max"),
    },
    ["beard_1"] = {
        mapping = "faceData[1].overlayValue",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Beard_1"),
    },
    ["beard_2"] = {
        mapping = "faceData[1].opacity",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Beard_2"),
        labelMin = _L("Skin.Input.Beard_2Min"),
        labelMax = _L("Skin.Input.Beard_2Max"),
    },
    ["beard_3"] = {
        mapping = "faceData[1].color",
        value = 0,
        type = "color",
        label = _L("Skin.Input.Beard_3"),
    },
    ["beard_4"] = {
        mapping = "faceData[1].highlight",
        value = 0,
        type = "color",
        label = _L("Skin.Input.Beard_4"),
    },
    ["ears_1"] = {
        mapping = "props[2].drawable",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Ears_1"),
    },
    ["ears_2"] = {
        mapping = "props[2].variation",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Ears_2"),
    },
    ["chain_1"] = {
        mapping = "components[7].drawable",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Chain_1"),
    },
    ["chain_2"] = {
        mapping = "components[7].variation",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Chain_2"),
    },
    ["glasses_1"] = {
        mapping = "props[1].drawable",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Glasses_1"),
    },
    ["glasses_2"] = {
        mapping = "props[1].variation",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Glasses_2"),
    },
    ["pants_1"] = {
        mapping = "components[4].drawable",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Pants_1"),
    },
    ["pants_2"] = {
        mapping = "components[4].variation",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Pants_2"),
    },
    ["moles_1"] = {
        mapping = "faceData[9].overlayValue",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Moles_1"),
    },
    ["moles_2"] = {
        mapping = "faceData[9].opacity",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Moles_2"),
        labelMin = _L("Skin.Input.Moles_2Min"),
        labelMax = _L("Skin.Input.Moles_2Max"),
    },
    ["cheeks_1"] = {
        mapping = "faceFeatures[8].value",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Cheeks_1"),
        labelMin = _L("Skin.Input.Cheeks_1Min"),
        labelMax = _L("Skin.Input.Cheeks_1Max"),
    },
    ["cheeks_2"] = {
        mapping = "faceFeatures[9].value",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Cheeks_2"),
        labelMin = _L("Skin.Input.Cheeks_2Min"),
        labelMax = _L("Skin.Input.Cheeks_2Max"),
    },
    ["cheeks_3"] = {
        mapping = "faceFeatures[10].value",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Cheeks_3"),
        labelMin = _L("Skin.Input.Cheeks_3Min"),
        labelMax = _L("Skin.Input.Cheeks_3Max"),
    },
    ["bracelets_1"] = {
        mapping = "props[7].drawable",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Bracelets_1"),
    },
    ["bracelets_2"] = {
        mapping = "props[7].variation",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Bracelets_2"),
    },
    ["torso_1"] = {
        mapping = "components[11].drawable",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Torso_1"),
    },
    ["torso_2"] = {
        mapping = "components[11].variation",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Torso_2"),
    },
    ["bags_1"] = {
        mapping = "components[5].drawable",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Bags_1"),
    },
    ["bags_2"] = {
        mapping = "components[5].variation",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Bags_2"),
    },
    ["blemishes_1"] = {
        mapping = "faceData[0].overlayValue",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Blemishes_1"),
    },
    ["blemishes_2"] = {
        mapping = "faceData[0].opacity",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Blemishes_2"),
        labelMin = _L("Skin.Input.Blemishes_2Min"),
        labelMax = _L("Skin.Input.Blemishes_2Max"),
    },
    ["complexion_1"] = {
        mapping = "faceData[6].overlayValue",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Complexion_1"),
    },
    ["complexion_2"] = {
        mapping = "faceData[6].opacity",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Complexion_2"),
        labelMin = _L("Skin.Input.Complexion_2Min"),
        labelMax = _L("Skin.Input.Complexion_2Max"),
    },
    ["sun_1"] = {
        mapping = "faceData[7].overlayValue",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Sun_1"),
    },
    ["sun_2"] = {
        mapping = "faceData[7].opacity",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Sun_2"),
        labelMin = _L("Skin.Input.Sun_2Min"),
        labelMax = _L("Skin.Input.Sun_2Max"),
    },
    ["chest_1"] = {
        mapping = "faceData[10].overlayValue",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Chest_1"),
    },
    ["chest_2"] = {
        mapping = "faceData[10].opacity",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Chest_2"),
        labelMin = _L("Skin.Input.Chest_2Min"),
        labelMax = _L("Skin.Input.Chest_2Max"),
    },
    ["chest_3"] = {
        mapping = "faceData[10].color",
        value = 0,
        type = "color",
        label = _L("Skin.Input.Chest_3"),
    },
    ["bodyb_1"] = {
        mapping = "faceData[11].overlayValue",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Bodyb_1"),
    },
    ["bodyb_2"] = {
        mapping = "faceData[11].opacity",
        value = 0,
        type = "range",
        label = _L("Skin.Input.Bodyb_2"),
        labelMin = _L("Skin.Input.Bodyb_2Min"),
        labelMax = _L("Skin.Input.Bodyb_2Max"),
    },
    ["bodyb_3"] = {
        mapping = "faceData[11].color",
        value = 0,
        type = "color",
        label = _L("Skin.Input.Bodyb_3"),
    },
    ["bodyb_4"] = {
        mapping = "faceData[11].highlight",
        value = 0,
        type = "color",
        label = _L("Skin.Input.Bodyb_4"),
    },
    ["lip_thickness"] = {
        mapping = "faceFeatures[12].value",
        value = 0.5,
        type = "range",
        label = _L("Skin.Input.Lip_thickness"),
        labelMin = _L("Skin.Input.Lip_thicknessMax"),
        labelMax = _L("Skin.Input.Lip_thicknessMin"),
    },
    ["neck_thickness"] = {
        mapping = "faceFeatures[19].value",
        value = 0.5,
        type = "range",
        label = _L("Skin.Input.Neck_thickness"),
        labelMin = _L("Skin.Input.Neck_thicknessMin"),
        labelMax = _L("Skin.Input.Neck_thicknessMax"),
    },
    ["eye_squint"] = {
        mapping = "faceFeatures[11].value",
        value = 0.5,
        type = "range",
        label = _L("Skin.Input.Eye_squint"),
        labelMin = _L("Skin.Input.Eye_squintMax"),
        labelMax = _L("Skin.Input.Eye_squintMin"),
    },
    ["eye_color"] = {
        mapping = "eyeColor",
        value = 0,
        type = "number",
        label = _L("Skin.Input.Eye_color"),
    },

    ["ZONE_HEAD"] = {
        mapping = "tattoos[1].hash",
        value = 0,
        type = "number",
        label = _L("Skin.Tattoo"),
    },

    ["ZONE_HEAD_SAVE"] = {
        type = "button",
        mapping = "tattoos[1].owned",
    },

    ["ZONE_TORSO"] = {
        mapping = "tattoos[2].hash",
        value = 0,
        type = "number",
        label = _L("Skin.Tattoo"),
    },

    ["ZONE_TORSO_SAVE"] = {
        type = "button",
        mapping = "tattoos[2].owned",
    },

    ["ZONE_RIGHT_ARM"] = {
        mapping = "tattoos[3].hash",
        value = 0,
        type = "number",
        label = _L("Skin.Tattoo"),
    },

    ["ZONE_RIGHT_ARM_SAVE"] = {
        type = "button",
        mapping = "tattoos[3].owned",
    },

    ["ZONE_LEFT_ARM"] = {
        mapping = "tattoos[4].hash",
        value = 0,
        type = "number",
        label = _L("Skin.Tattoo"),
    },

    ["ZONE_LEFT_ARM_SAVE"] = {
        type = "button",
        mapping = "tattoos[4].owned",
    },

    ["ZONE_RIGHT_LEG"] = {
        mapping = "tattoos[5].hash",
        value = 0,
        type = "number",
        label = _L("Skin.Tattoo"),
    },

    ["ZONE_RIGHT_LEG_SAVE"] = {
        type = "button",
        mapping = "tattoos[5].owned",
    },

    ["ZONE_LEFT_LEG"] = {
        mapping = "tattoos[6].hash",
        value = 0,
        type = "number",
        label = _L("Skin.Tattoo"),
    },

    ["ZONE_LEFT_LEG_SAVE"] = {
        type = "button",
        mapping = "tattoos[6].owned",
    },
}

Skin.WomanPlayerModels = { -- List of woman peds
    "mp_f_freemode_01",
    "a_f_m_beach_01",
    "a_f_m_bevhills_01",
    "a_f_m_bevhills_02",
    "a_f_m_bodybuild_01",
    "a_f_m_business_02",
    "a_f_m_downtown_01",
    "a_f_m_eastsa_01",
    "a_f_m_eastsa_02",
    "a_f_m_fatbla_01",
    "a_f_m_fatcult_01",
    "a_f_m_fatwhite_01",
    "a_f_m_ktown_01",
    "a_f_m_ktown_02",
    "a_f_m_prolhost_01",
    "a_f_m_salton_01",
    "a_f_m_skidrow_01",
    "a_f_m_soucent_01",
    "a_f_m_soucent_02",
    "a_f_m_soucentmc_01",
    "a_f_m_tourist_01",
    "a_f_m_tramp_01",
    "a_f_m_trampbeac_01",
    "a_f_o_genstreet_01",
    "a_f_o_indian_01",
    "a_f_o_ktown_01",
    "a_f_o_salton_01",
    "a_f_o_soucent_01",
    "a_f_o_soucent_02",
    "a_f_y_beach_01",
    "a_f_y_bevhills_01",
    "a_f_y_bevhills_02",
    "a_f_y_bevhills_03",
    "a_f_y_bevhills_04",
    "a_f_y_business_01",
    "a_f_y_business_02",
    "a_f_y_business_03",
    "a_f_y_business_04",
    "a_f_y_eastsa_01",
    "a_f_y_eastsa_02",
    "a_f_y_eastsa_03",
    "a_f_y_epsilon_01",
    "a_f_y_femaleagent",
    "a_f_y_fitness_01",
    "a_f_y_fitness_02",
    "a_f_y_genhot_01",
    "a_f_y_golfer_01",
    "a_f_y_hiker_01",
    "a_f_y_hippie_01",
    "a_f_y_hipster_01",
    "a_f_y_hipster_02",
    "a_f_y_hipster_03",
    "a_f_y_hipster_04",
    "a_f_y_indian_01",
    "a_f_y_juggalo_01",
    "a_f_y_runner_01",
    "a_f_y_rurmeth_01",
    "a_f_y_scdressy_01",
    "a_f_y_skater_01",
    "a_f_y_soucent_01",
    "a_f_y_soucent_02",
    "a_f_y_soucent_03",
    "a_f_y_tennis_01",
    "a_f_y_tourist_01",
    "a_f_y_tourist_02",
    "a_f_y_vinewood_01",
    "a_f_y_vinewood_02",
    "a_f_y_vinewood_03",
    "a_f_y_vinewood_04",
    "a_f_y_yoga_01",
    "g_f_y_ballas_01",
    "g_f_y_families_01",
    "g_f_y_lost_01",
    "g_f_y_vagos_01",
    "ig_amandatownley",
    "ig_andreas",
    "ig_ashley",
    "ig_ballasog",
    "ig_janet",
    "ig_jewelass",
    "ig_kerrymcintosh",
    "ig_magenta",
    "ig_marnie",
    "ig_maude",
    "ig_michelle",
    "ig_molly",
    "ig_mrs_thornhill",
    "ig_mrsphillips",
    "ig_natalia",
    "ig_paige",
    "ig_patricia",
    "ig_screen_writer",
    "ig_talina",
    "ig_tanisha",
    "ig_tonya",
    "ig_tracydisanto",
    "mp_f_deadhooker",
    "mp_f_misty_01",
    "mp_s_m_armoured_01",
    "s_f_m_fembarber",
    "s_f_m_maid_01",
    "s_f_m_shop_high",
    "s_f_m_sweatshop_01",
    "s_f_y_airhostess_01",
    "s_f_y_bartender_01",
    "s_f_y_baywatch_01",
    "s_f_y_cop_01",
    "s_f_y_factory_01",
    "s_f_y_hooker_01",
    "s_f_y_hooker_02",
    "s_f_y_hooker_03",
    "s_f_y_migrant_01",
    "s_f_y_movprem_01",
    "s_f_y_scrubs_01",
    "s_f_y_sheriff_01",
    "s_f_y_shop_low",
    "s_f_y_shop_mid",
    "s_f_y_stripper_01",
    "s_f_y_stripper_02",
    "s_f_y_stripperlite",
    "s_f_y_sweatshop_01",
    "u_f_m_corpse_01",
    "u_f_m_miranda",
    "u_f_m_promourn_01",
    "u_f_o_moviestar",
    "u_f_o_prolhost_01",
    "u_f_y_bikerchic",
    "u_f_y_comjane",
    "u_f_y_corpse_01",
    "u_f_y_corpse_02",
    "u_f_y_hotposh_01",
    "u_f_y_jewelass_01",
    "u_f_y_mistress",
    "u_f_y_poppymich",
    "u_f_y_princess",
    "u_f_y_spyactress",
}

Skin.ManPlayerModels = { -- List of men peds
    "mp_m_freemode_01",
    "a_m_m_afriamer_01",
    "a_m_m_beach_01",
    "a_m_m_beach_02",
    "a_m_m_bevhills_01",
    "a_m_m_bevhills_02",
    "a_m_m_business_01",
    "a_m_m_eastsa_01",
    "a_m_m_eastsa_02",
    "a_m_m_farmer_01",
    "a_m_m_fatlatin_01",
    "a_m_m_genfat_01",
    "a_m_m_genfat_02",
    "a_m_m_golfer_01",
    "a_m_m_hasjew_01",
    "a_m_m_hillbilly_01",
    "a_m_m_hillbilly_02",
    "a_m_m_indian_01",
    "a_m_m_ktown_01",
    "a_m_m_malibu_01",
    "a_m_m_mexcntry_01",
    "a_m_m_mexlabor_01",
    "a_m_m_og_boss_01",
    "a_m_m_paparazzi_01",
    "a_m_m_polynesian_01",
    "a_m_m_prolhost_01",
    "a_m_m_rurmeth_01",
    "a_m_m_salton_01",
    "a_m_m_salton_02",
    "a_m_m_salton_03",
    "a_m_m_salton_04",
    "a_m_m_skater_01",
    "a_m_m_skidrow_01",
    "a_m_m_socenlat_01",
    "a_m_m_soucent_01",
    "a_m_m_soucent_02",
    "a_m_m_soucent_03",
    "a_m_m_soucent_04",
    "a_m_m_stlat_02",
    "a_m_m_tennis_01",
    "a_m_m_tourist_01",
    "a_m_m_tramp_01",
    "a_m_m_trampbeac_01",
    "a_m_o_acult_01",
    "a_m_o_beach_01",
    "a_m_o_genstreet_01",
    "a_m_o_ktown_01",
    "a_m_o_salton_01",
    "a_m_o_soucent_01",
    "a_m_o_soucent_02",
    "a_m_o_soucent_03",
    "a_m_o_tramp_01",
    "a_m_y_beach_01",
    "a_m_y_beach_02",
    "a_m_y_beach_03",
    "a_m_y_beachvesp_01",
    "a_m_y_beachvesp_02",
    "a_m_y_bevhills_01",
    "a_m_y_bevhills_02",
    "a_m_y_breakdance_01",
    "a_m_y_busicas_01",
    "a_m_y_business_01",
    "a_m_y_business_02",
    "a_m_y_business_03",
    "a_m_y_cyclist_01",
    "a_m_y_dhill_01",
    "a_m_y_downtown_01",
    "a_m_y_eastsa_01",
    "a_m_y_eastsa_02",
    "a_m_y_epsilon_01",
    "a_m_y_epsilon_02",
    "a_m_y_genstreet_01",
    "a_m_y_genstreet_02",
    "a_m_y_golfer_01",
    "a_m_y_hasjew_01",
    "a_m_y_hiker_01",
    "a_m_y_hippy_01",
    "a_m_y_hipster_01",
    "a_m_y_hipster_02",
    "a_m_y_hipster_03",
    "a_m_y_indian_01",
    "a_m_y_jetski_01",
    "a_m_y_juggalo_01",
    "a_m_y_ktown_01",
    "a_m_y_ktown_02",
    "a_m_y_latino_01",
    "a_m_y_methhead_01",
    "a_m_y_mexthug_01",
    "a_m_y_motox_01",
    "a_m_y_motox_02",
    "a_m_y_musclbeac_01",
    "a_m_y_musclbeac_02",
    "a_m_y_polynesian_01",
    "a_m_y_roadcyc_01",
    "a_m_y_runner_01",
    "a_m_y_runner_02",
    "a_m_y_salton_01",
    "a_m_y_skater_01",
    "a_m_y_skater_02",
    "a_m_y_soucent_01",
    "a_m_y_soucent_02",
    "a_m_y_soucent_03",
    "a_m_y_soucent_04",
    "a_m_y_stlat_01",
    "a_m_y_stwhi_01",
    "a_m_y_stwhi_02",
    "a_m_y_sunbathe_01",
    "a_m_y_surfer_01",
    "a_m_y_vindouche_01",
    "a_m_y_vinewood_01",
    "a_m_y_vinewood_02",
    "a_m_y_vinewood_03",
    "a_m_y_vinewood_04",
    "a_m_y_yoga_01",
    "csb_prolsec",
    "g_m_m_armboss_01",
    "g_m_m_armgoon_01",
    "g_m_m_armlieut_01",
    "g_m_m_chemwork_01",
    "g_m_m_chiboss_01",
    "g_m_m_chicold_01",
    "g_m_m_chigoon_01",
    "g_m_m_chigoon_02",
    "g_m_m_korboss_01",
    "g_m_m_mexboss_01",
    "g_m_m_mexboss_02",
    "g_m_y_armgoon_02",
    "g_m_y_azteca_01",
    "g_m_y_ballaeast_01",
    "g_m_y_ballaorig_01",
    "g_m_y_ballasout_01",
    "g_m_y_famca_01",
    "g_m_y_famdnf_01",
    "g_m_y_famfor_01",
    "g_m_y_korean_01",
    "g_m_y_korean_02",
    "g_m_y_korlieut_01",
    "g_m_y_lost_01",
    "g_m_y_lost_02",
    "g_m_y_lost_03",
    "g_m_y_mexgang_01",
    "g_m_y_mexgoon_01",
    "g_m_y_mexgoon_02",
    "g_m_y_mexgoon_03",
    "g_m_y_pologoon_01",
    "g_m_y_pologoon_02",
    "g_m_y_salvaboss_01",
    "g_m_y_salvagoon_01",
    "g_m_y_salvagoon_02",
    "g_m_y_salvagoon_03",
    "g_m_y_strpunk_01",
    "g_m_y_strpunk_02",
    "ig_bankman",
    "ig_barry",
    "ig_bestmen",
    "ig_beverly",
    "ig_car3guy1",
    "ig_car3guy2",
    "ig_casey",
    "ig_chef",
    "ig_chengsr",
    "ig_chrisformage",
    "ig_clay",
    "ig_claypain",
    "ig_cletus",
    "ig_dale",
    "ig_dreyfuss",
    "ig_fbisuit_01",
    "ig_groom",
    "ig_hao",
    "ig_hunter",
    "ig_joeminuteman",
    "ig_josef",
    "ig_josh",
    "ig_lifeinvad_01",
    "ig_lifeinvad_02",
    "ig_manuel",
    "ig_nigel",
    "ig_old_man1a",
    "ig_old_man2",
    "ig_oneil",
    "ig_ortega",
    "ig_paper",
    "ig_priest",
    "ig_prolsec_02",
    "ig_ramp_gang",
    "ig_ramp_hic",
    "ig_ramp_hipster",
    "ig_ramp_mex",
    "ig_roccopelosi",
    "ig_russiandrunk",
    "ig_terry",
    "ig_tomepsilon",
    "ig_trafficwarden",
    "ig_tylerdix",
    "ig_zimbor",
    "mp_m_exarmy_01",
    "s_m_m_ammucountry",
    "s_m_m_autoshop_01",
    "s_m_m_autoshop_02",
    "s_m_m_bouncer_01",
    "s_m_m_chemsec_01",
    "s_m_m_cntrybar_01",
    "s_m_m_dockwork_01",
    "s_m_m_doctor_01",
    "s_m_m_fiboffice_01",
    "s_m_m_fiboffice_02",
    "s_m_m_gaffer_01",
    "s_m_m_gardener_01",
    "s_m_m_gentransport",
    "s_m_m_hairdress_01",
    "s_m_m_highsec_01",
    "s_m_m_highsec_02",
    "s_m_m_janitor",
    "s_m_m_lathandy_01",
    "s_m_m_lifeinvad_01",
    "s_m_m_linecook",
    "s_m_m_lsmetro_01",
    "s_m_m_mariachi_01",
    "s_m_m_marine_01",
    "s_m_m_marine_02",
    "s_m_m_migrant_01",
    "s_m_m_movalien_01",
    "s_m_m_movprem_01",
    "s_m_m_movspace_01",
    "s_m_m_paramedic_01",
    "s_m_m_pilot_01",
    "s_m_m_pilot_02",
    "s_m_m_postal_01",
    "s_m_m_postal_02",
    "s_m_m_scientist_01",
    "s_m_m_security_01",
    "s_m_m_strperf_01",
    "s_m_m_strpreach_01",
    "s_m_m_strvend_01",
    "s_m_m_trucker_01",
    "s_m_m_ups_01",
    "s_m_m_ups_02",
    "s_m_o_busker_01",
    "s_m_y_airworker",
    "s_m_y_ammucity_01",
    "s_m_y_armymech_01",
    "s_m_y_autopsy_01",
    "s_m_y_barman_01",
    "s_m_y_baywatch_01",
    "s_m_y_blackops_01",
    "s_m_y_blackops_02",
    "s_m_y_busboy_01",
    "s_m_y_chef_01",
    "s_m_y_clown_01",
    "s_m_y_construct_01",
    "s_m_y_construct_02",
    "s_m_y_cop_01",
    "s_m_y_dealer_01",
    "s_m_y_devinsec_01",
    "s_m_y_dockwork_01",
    "s_m_y_doorman_01",
    "s_m_y_dwservice_01",
    "s_m_y_dwservice_02",
    "s_m_y_factory_01",
    "s_m_y_garbage",
    "s_m_y_grip_01",
    "s_m_y_marine_01",
    "s_m_y_marine_02",
    "s_m_y_marine_03",
    "s_m_y_mime",
    "s_m_y_pestcont_01",
    "s_m_y_pilot_01",
    "s_m_y_prismuscl_01",
    "s_m_y_prisoner_01",
    "s_m_y_robber_01",
    "s_m_y_shop_mask",
    "s_m_y_strvend_01",
    "s_m_y_uscg_01",
    "s_m_y_valet_01",
    "s_m_y_waiter_01",
    "s_m_y_winclean_01",
    "s_m_y_xmech_01",
    "s_m_y_xmech_02",
    "u_m_m_aldinapoli",
    "u_m_m_bankman",
    "u_m_m_bikehire_01",
    "u_m_m_fibarchitect",
    "u_m_m_filmdirector",
    "u_m_m_glenstank_01",
    "u_m_m_griff_01",
    "u_m_m_jesus_01",
    "u_m_m_jewelsec_01",
    "u_m_m_jewelthief",
    "u_m_m_markfost",
    "u_m_m_partytarget",
    "u_m_m_prolsec_01",
    "u_m_m_promourn_01",
    "u_m_m_rivalpap",
    "u_m_m_spyactor",
    "u_m_m_willyfist",
    "u_m_o_finguru_01",
    "u_m_o_taphillbilly",
    "u_m_o_tramp_01",
    "u_m_y_abner",
    "u_m_y_antonb",
    "u_m_y_babyd",
    "u_m_y_baygor",
    "u_m_y_burgerdrug_01",
    "u_m_y_chip",
    "u_m_y_cyclist_01",
    "u_m_y_fibmugger_01",
    "u_m_y_guido_01",
    "u_m_y_gunvend_01",
    "u_m_y_hippie_01",
    "u_m_y_imporage",
    "u_m_y_mani",
    "u_m_y_militarybum",
    "u_m_y_paparazzi",
    "u_m_y_party_01",
    "u_m_y_pogo_01",
    "u_m_y_prisoner_01",
    "u_m_y_proldriver_01",
    "u_m_y_rsranger_01",
    "u_m_y_sbike",
    "u_m_y_staggrm_01",
    "u_m_y_tattoo_01",
    "u_m_y_zombie_01",
}

Skin.MaxEyeColorValue = 32
Skin.HairColors = { -- List of hair colors as representation in nui
    "#1c1f21",
    "#272a2c",
    "#312e2c",
    "#35261c",
    "#4b321f",
    "#5c3b24",
    "#6d4c35",
    "#6b503b",
    "#765c45",
    "#7f684e",
    "#99815d",
    "#a79369",
    "#af9c70",
    "#bba063",
    "#d6b97b",
    "#dac38e",
    "#9f7f59",
    "#845039",
    "#682b1f",
    "#61120c",
    "#640f0a",
    "#7c140f",
    "#a02e19",
    "#b64b28",
    "#a2502f",
    "#aa4e2b",
    "#626262",
    "#808080",
    "#aaaaaa",
    "#c5c5c5",
    "#463955",
    "#5a3f6b",
    "#763c76",
    "#ed74e3",
    "#eb4b93",
    "#f299bc",
    "#04959e",
    "#025f86",
    "#023974",
    "#3fa16a",
    "#217c61",
    "#185c55",
    "#b6c034",
    "#70a90b",
    "#439d13",
    "#dcb857",
    "#e5b103",
    "#e69102",
    "#f28831",
    "#fb8057",
    "#e28b58",
    "#d1593c",
    "#ce3120",
    "#ad0903",
    "#880302",
    "#1f1814",
    "#291f19",
    "#2e221b",
    "#37291e",
    "#2e2218",
    "#231b15",
    "#020202",
    "#706c66",
    "#9d7a50",
}

Skin.FemaleFaceTranslation = {
    [0] = 21,
    [1] = 22,
    [2] = 23,
    [3] = 24,
    [4] = 25,
    [5] = 26,
    [6] = 27,
    [7] = 28,
    [8] = 29,
    [9] = 30,
    [10] = 31,
    [11] = 32,
    [12] = 33,
    [13] = 34,
    [14] = 35,
    [15] = 36,
    [16] = 37,
    [17] = 38,
    [18] = 39,
    [19] = 40,
    [20] = 41,
    [21] = 45,
}

Skin.MaleFaceTranslation = {
    [0] = 0,
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
    [14] = 14,
    [15] = 15,
    [16] = 16,
    [17] = 17,
    [18] = 18,
    [19] = 19,
    [20] = 20,
    [21] = 42,
    [22] = 43,
    [23] = 44,
}

if Skin.EnableONXCustomFaces then
    Skin.MaleFaceTranslation[24] = 46
    Skin.MaleFaceTranslation[25] = 47
    Skin.MaleFaceTranslation[26] = 48
    Skin.MaleFaceTranslation[27] = 49
    Skin.MaleFaceTranslation[28] = 50
    Skin.MaleFaceTranslation[29] = 51
    Skin.MaleFaceTranslation[30] = 52
    Skin.MaleFaceTranslation[31] = 53
    Skin.MaleFaceTranslation[32] = 54
    Skin.MaleFaceTranslation[33] = 55
    Skin.MaleFaceTranslation[34] = 56
    Skin.MaleFaceTranslation[35] = 57
    Skin.MaleFaceTranslation[36] = 58
    Skin.MaleFaceTranslation[37] = 59
    Skin.MaleFaceTranslation[38] = 60
    Skin.MaleFaceTranslation[39] = 61
    Skin.MaleFaceTranslation[40] = 62
    Skin.MaleFaceTranslation[41] = 63
    Skin.MaleFaceTranslation[42] = 64
    Skin.MaleFaceTranslation[43] = 65
    Skin.MaleFaceTranslation[44] = 66
    Skin.MaleFaceTranslation[45] = 67
    Skin.MaleFaceTranslation[46] = 68
    Skin.MaleFaceTranslation[47] = 91

    Skin.FemaleFaceTranslation[22] = 69
    Skin.FemaleFaceTranslation[23] = 70
    Skin.FemaleFaceTranslation[24] = 71
    Skin.FemaleFaceTranslation[25] = 72
    Skin.FemaleFaceTranslation[26] = 73
    Skin.FemaleFaceTranslation[27] = 74
    Skin.FemaleFaceTranslation[28] = 75
    Skin.FemaleFaceTranslation[29] = 76
    Skin.FemaleFaceTranslation[30] = 77
    Skin.FemaleFaceTranslation[31] = 78
    Skin.FemaleFaceTranslation[32] = 79
    Skin.FemaleFaceTranslation[33] = 80
    Skin.FemaleFaceTranslation[34] = 81
    Skin.FemaleFaceTranslation[35] = 82
    Skin.FemaleFaceTranslation[36] = 83
    Skin.FemaleFaceTranslation[37] = 84
    Skin.FemaleFaceTranslation[38] = 85
    Skin.FemaleFaceTranslation[39] = 86
    Skin.FemaleFaceTranslation[40] = 87
    Skin.FemaleFaceTranslation[41] = 88
    Skin.FemaleFaceTranslation[42] = 89
    Skin.FemaleFaceTranslation[43] = 90
end

Skin.InputsToShift = {
    ["helmet_1"] = true,
    ["watches_1"] = true,
    ["bracelets_1"] = true,
    ["glasses_1"] = true,
    ["ears_1"] = true,

    -- ["ZONE_HEAD"] = true,
    -- ["ZONE_TORSO"] = true,
    -- ["ZONE_RIGHT_ARM"] = true,
    -- ["ZONE_LEFT_ARM"] = true,
    -- ["ZONE_LEFT_LEG"] = true,
    -- ["ZONE_RIGHT_LEG"] = true,
}

Skin.InputsDependency = {
    [`mp_m_freemode_01`] = {
        ["hair_1"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["hair_2"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["hair_3"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["hair_4"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["beard_1"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["beard_2"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["beard_3"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["beard_4"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["eyebrows_1"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["eyebrows_2"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["eyebrows_3"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["eyebrows_4"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["eyebrows_5"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["eyebrows_6"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["chest_1"] = {
            -- While changing chest hair, torso should be taken off
            { componentId = 11, value = 15 },
            { componentId = 8,  value = 15 },
            { componentId = 3,  value = 15 },
        },

        ["chest_2"] = {
            { componentId = 11, value = 15 },
            { componentId = 8,  value = 15 },
            { componentId = 3,  value = 15 },
        },

        ["chest_3"] = {
            { componentId = 11, value = 15 },
            { componentId = 8,  value = 15 },
            { componentId = 3,  value = 15 },
        },

        ["ZONE_HEAD"] = {
            -- While changing chest hair, torso should be taken off
            { componentId = 11, value = 15 },
            { componentId = 8,  value = 15 },
            { componentId = 3,  value = 15 },
        },

        ["ZONE_TORSO"] = {
            -- While changing chest hair, torso should be taken off
            { componentId = 11, value = 15 },
            { componentId = 8,  value = 15 },
            { componentId = 3,  value = 15 },
        },

        ["ZONE_RIGHT_ARM"] = {
            -- While changing chest hair, torso should be taken off
            { componentId = 11, value = 15 },
            { componentId = 8,  value = 15 },
            { componentId = 3,  value = 15 },
        },

        ["ZONE_LEFT_ARM"] = {
            -- While changing chest hair, torso should be taken off
            { componentId = 11, value = 15 },
            { componentId = 8,  value = 15 },
            { componentId = 3,  value = 15 },
        },

        ["ZONE_RIGHT_LEG"] = {
            -- While changing chest hair, torso should be taken off
            { componentId = 4, value = 21 },
            { componentId = 6,  value = 34 },
        },

        ["ZONE_LEFT_LEG"] = {
            -- While changing chest hair, torso should be taken off
            { componentId = 4, value = 21 },
            { componentId = 6,  value = 34 },
        },
    },

    [`mp_f_freemode_01`] = {
        ["hair_1"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["hair_2"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["hair_3"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["hair_4"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["beard_1"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["beard_2"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["beard_3"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["beard_4"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["eyebrows_1"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["eyebrows_2"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["eyebrows_3"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["eyebrows_4"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["eyebrows_5"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["eyebrows_6"] = {
            { componentId = 1, value = 0},
            { propId = 0, value = -1},
        },

        ["chest_1"] = {
            -- While changing chest hair, torso should be taken off
            { componentId = 11, value = 15 },
            { componentId = 8,  value = 15 },
            { componentId = 3,  value = 15 },
        },

        ["chest_2"] = {
            { componentId = 11, value = 15 },
            { componentId = 8,  value = 15 },
            { componentId = 3,  value = 15 },
        },

        ["chest_3"] = {
            { componentId = 11, value = 15 },
            { componentId = 8,  value = 15 },
            { componentId = 3,  value = 15 },
        },

        ["ZONE_HEAD"] = {
            -- While changing chest hair, torso should be taken off
            { componentId = 11, value = 15 },
            { componentId = 8,  value = 15 },
            { componentId = 3,  value = 15 },
        },

        ["ZONE_TORSO"] = {
            -- While changing chest hair, torso should be taken off
            { componentId = 11, value = 15 },
            { componentId = 8,  value = 15 },
            { componentId = 3,  value = 15 },
        },

        ["ZONE_RIGHT_ARM"] = {
            -- While changing chest hair, torso should be taken off
            { componentId = 11, value = 15 },
            { componentId = 8,  value = 15 },
            { componentId = 3,  value = 15 },
        },

        ["ZONE_LEFT_ARM"] = {
            -- While changing chest hair, torso should be taken off
            { componentId = 11, value = 15 },
            { componentId = 8,  value = 15 },
            { componentId = 3,  value = 15 },
        },

        ["ZONE_RIGHT_LEG"] = {
            -- While changing chest hair, torso should be taken off
            { componentId = 4, value = 15 },
            { componentId = 6,  value = 35 },
        },

        ["ZONE_LEFT_LEG"] = {
            -- While changing chest hair, torso should be taken off
            { componentId = 4, value = 15 },
            { componentId = 6,  value = 35 },
        },
    }
}

Skin.DefaultSkin = {
    faceData = {
        [0] = {enabled = true, from = 0, to = 23},
        [2] = {enabled = true, from = 0, to = 33, color = 0, highlight = 0},
        [3] = {enabled = true, from = 0, to = 14},
        [6] = {enabled = true, from = 0, to = 11},
        [7] = {enabled = true, from = 0, to = 10},
        [9] = {enabled = true, from = 0, to = 17},
    },

    faceFeatures = {
        [1] = {enabled = true, from = -50, to = 50},
        [2] = {enabled = true, from = -50, to = 50},
        [3] = {enabled = true, from = -50, to = 50},
        [4] = {enabled = true, from = -50, to = 50},
        [5] = {enabled = true, from = -50, to = 50},
        [6] = {enabled = true, from = -50, to = 50},
        [7] = {enabled = true, from = -50, to = 50},
        [8] = {enabled = true, from = -50, to = 50},
        [9] = {enabled = true, from = -50, to = 50},
        [10] = {enabled = true, from = -50, to = 50},
        [11] = {enabled = true, from = -50, to = 50},
        [12] = {enabled = true, from = -50, to = 50},
        [13] = {enabled = true, from = -50, to = 50},
        [14] = {enabled = true, from = -50, to = 50},
        [15] = {enabled = true, from = -50, to = 50},
        [16] = {enabled = true, from = -50, to = 50},
        [17] = {enabled = true, from = -50, to = 50},
        [18] = {enabled = true, from = -50, to = 50},
        [19] = {enabled = true, from = -50, to = 50},
    },
    ["male"] = {
        [0] = { type = "fixedVal", number = 0 },
        [1] = { type = "fixedVal", number = 0 },
        [2] = { type = "randomMath", from = 0, to = 74 },
        -- 3 IS MISSING BECAUSE ARMS ARE BEING SET TO MATCH JBIB (TORSO)
        [4] = { type = "randomArr", options = { 4, 5, 6, 12, 15, 17, 24, 28, 42, 52, 64, 69, 76, 105 } },
        [5] = { type = "fixedVal", number = 0 },
        [6] = { type = "randomArr", options = { 1, 7, 10, 22, 25, 32, 42, 54, 61 } },
        [7] = { type = "fixedVal", number = 0 },
        [8] = { type = "fixedVal", number = 15 },
        [9] = { type = "fixedVal", number = 0 },
        [10] = { type = "fixedVal", number = 0 },
        [11] = {
            type = "torso",
            optionsWithArms = {
                { torso = 5,   arms = 5 },
                { torso = 8,   arms = 8 },
                { torso = 9,   arms = 0 },
                { torso = 14,  arms = 1 },
                { torso = 16,  arms = 0 },
                { torso = 41,  arms = 6 },
                { torso = 50,  arms = 0 },
                { torso = 63,  arms = 0 },
                { torso = 80,  arms = 0 },
                { torso = 81,  arms = 0 },
                { torso = 82,  arms = 0 },
                { torso = 84,  arms = 1 },
                { torso = 86,  arms = 1 },
                { torso = 87,  arms = 1 },
                { torso = 89,  arms = 1 },
                { torso = 93,  arms = 0 },
                { torso = 96,  arms = 1 },
                { torso = 105, arms = 0 },
                { torso = 111, arms = 4 },
                { torso = 135, arms = 0 },
                { torso = 164, arms = 0 },
                { torso = 171, arms = 1 },
                { torso = 193, arms = 0 },
                { torso = 225, arms = 8 },
                { torso = 226, arms = 0 },
                { torso = 235, arms = 0 },
                { torso = 241, arms = 0 },
                { torso = 262, arms = 1 },
            }
        },
    },

    ["female"] = {
        [0] = { type = "fixedVal", number = 0 },
        [1] = { type = "fixedVal", number = 0 },
        [2] = { type = "randomMath", from = 0, to = 78 },
        -- 3 IS MISSING BECAUSE ARMS ARE BEING SET TO MATCH JBIB (TORSO)
        [4] = { type = "randomArr", options = { 0, 1, 3, 7, 8, 10, 12, 14, 18, 23, 25, 26, 27, 28, 30, 31, 36, 43, 44, 58, 71, 87, 106, } },
        [5] = { type = "fixedVal", number = 0 },
        [6] = { type = "randomArr", options = { 1, 3, 4, 6, 8, 11, 13, 23, 27, 32, 37, 42, 49, 80, } },
        [7] = { type = "fixedVal", number = 0 },
        [8] = { type = "fixedVal", number = 15 },
        [9] = { type = "fixedVal", number = 0 },
        [10] = { type = "fixedVal", number = 0 },
        [11] = {
            type = "torso",
            optionsWithArms = {
                { torso = 5,  arms = 4 },
                { torso = 9,  arms = 9 },
                { torso = 10, arms = 7 },
                { torso = 14, arms = 14 },
                { torso = 15, arms = 15 },
                { torso = 17, arms = 14 },
                { torso = 43, arms = 3 },
                { torso = 45, arms = 3 },
                { torso = 46, arms = 0 },
                { torso = 71, arms = 1 },
                { torso = 73, arms = 14 },
                { torso = 75, arms = 14 },
                { torso = 76, arms = 14 },
                { torso = 78, arms = 1 },
                { torso = 79, arms = 1 },
                { torso = 83, arms = 1 },
                { torso = 0,  arms = 0 },
                { torso = 0,  arms = 0 },
                { torso = 0,  arms = 0 },
                { torso = 0,  arms = 0 },
                { torso = 0,  arms = 0 },
                { torso = 0,  arms = 0 },
                { torso = 0,  arms = 0 },
            }
        },
    }
}

-- Taken from illenium-appearance
Skin.EnableHairFades = true
Skin.DefaultFade = {'mpbeach_overlays', "FM_hair_fuzz"}
Skin.HairFades = {
    [`mp_m_freemode_01`] = {
        [0] = { `mpbeach_overlays`, `FM_Hair_Fuzz` },
        [1] = { `multiplayer_overlays`, `NG_M_Hair_001` },
        [2] = { `multiplayer_overlays`, `NG_M_Hair_002` },
        [3] = { `multiplayer_overlays`, `NG_M_Hair_003` },
        [4] = { `multiplayer_overlays`, `NG_M_Hair_004` },
        [5] = { `multiplayer_overlays`, `NG_M_Hair_005` },
        [6] = { `multiplayer_overlays`, `NG_M_Hair_006` },
        [7] = { `multiplayer_overlays`, `NG_M_Hair_007` },
        [8] = { `multiplayer_overlays`, `NG_M_Hair_008` },
        [9] = { `multiplayer_overlays`, `NG_M_Hair_009` },
        [10] = { `multiplayer_overlays`, `NG_M_Hair_013` },
        [11] = { `multiplayer_overlays`, `NG_M_Hair_002` },
        [12] = { `multiplayer_overlays`, `NG_M_Hair_011` },
        [13] = { `multiplayer_overlays`, `NG_M_Hair_012` },
        [14] = { `multiplayer_overlays`, `NG_M_Hair_014` },
        [15] = { `multiplayer_overlays`, `NG_M_Hair_015` },
        [16] = { `multiplayer_overlays`, `NGBea_M_Hair_000` },
        [17] = { `multiplayer_overlays`, `NGBea_M_Hair_001` },
        [18] = { `multiplayer_overlays`, `NGBus_M_Hair_000` },
        [19] = { `multiplayer_overlays`, `NGBus_M_Hair_001` },
        [20] = { `multiplayer_overlays`, `NGHip_M_Hair_000` },
        [21] = { `multiplayer_overlays`, `NGHip_M_Hair_001` },
        [22] = { `multiplayer_overlays`, `NGInd_M_Hair_000` },
        [24] = { `mplowrider_overlays`, `LR_M_Hair_000` },
        [25] = { `mplowrider_overlays`, `LR_M_Hair_001` },
        [26] = { `mplowrider_overlays`, `LR_M_Hair_002` },
        [27] = { `mplowrider_overlays`, `LR_M_Hair_003` },
        [28] = { `mplowrider2_overlays`, `LR_M_Hair_004` },
        [29] = { `mplowrider2_overlays`, `LR_M_Hair_005` },
        [30] = { `mplowrider2_overlays`, `LR_M_Hair_006` },
        [31] = { `mpbiker_overlays`, `MP_Biker_Hair_000_M` },
        [32] = { `mpbiker_overlays`, `MP_Biker_Hair_001_M` },
        [33] = { `mpbiker_overlays`, `MP_Biker_Hair_002_M` },
        [34] = { `mpbiker_overlays`, `MP_Biker_Hair_003_M` },
        [35] = { `mpbiker_overlays`, `MP_Biker_Hair_004_M` },
        [36] = { `mpbiker_overlays`, `MP_Biker_Hair_005_M` },
        [37] = { `multiplayer_overlays`, `NG_M_Hair_001` },
        [38] = { `multiplayer_overlays`, `NG_M_Hair_002` },
        [39] = { `multiplayer_overlays`, `NG_M_Hair_003` },
        [40] = { `multiplayer_overlays`, `NG_M_Hair_004` },
        [41] = { `multiplayer_overlays`, `NG_M_Hair_005` },
        [42] = { `multiplayer_overlays`, `NG_M_Hair_006` },
        [43] = { `multiplayer_overlays`, `NG_M_Hair_007` },
        [44] = { `multiplayer_overlays`, `NG_M_Hair_008` },
        [45] = { `multiplayer_overlays`, `NG_M_Hair_009` },
        [46] = { `multiplayer_overlays`, `NG_M_Hair_013` },
        [47] = { `multiplayer_overlays`, `NG_M_Hair_002` },
        [48] = { `multiplayer_overlays`, `NG_M_Hair_011` },
        [49] = { `multiplayer_overlays`, `NG_M_Hair_012` },
        [50] = { `multiplayer_overlays`, `NG_M_Hair_014` },
        [51] = { `multiplayer_overlays`, `NG_M_Hair_015` },
        [52] = { `multiplayer_overlays`, `NGBea_M_Hair_000` },
        [53] = { `multiplayer_overlays`, `NGBea_M_Hair_001` },
        [54] = { `multiplayer_overlays`, `NGBus_M_Hair_000` },
        [55] = { `multiplayer_overlays`, `NGBus_M_Hair_001` },
        [56] = { `multiplayer_overlays`, `NGHip_M_Hair_000` },
        [57] = { `multiplayer_overlays`, `NGHip_M_Hair_001` },
        [58] = { `multiplayer_overlays`, `NGInd_M_Hair_000` },
        [59] = { `mplowrider_overlays`, `LR_M_Hair_000` },
        [60] = { `mplowrider_overlays`, `LR_M_Hair_001` },
        [61] = { `mplowrider_overlays`, `LR_M_Hair_002` },
        [62] = { `mplowrider_overlays`, `LR_M_Hair_003` },
        [63] = { `mplowrider2_overlays`, `LR_M_Hair_004` },
        [64] = { `mplowrider2_overlays`, `LR_M_Hair_005` },
        [65] = { `mplowrider2_overlays`, `LR_M_Hair_006` },
        [66] = { `mpbiker_overlays`, `MP_Biker_Hair_000_M` },
        [67] = { `mpbiker_overlays`, `MP_Biker_Hair_001_M` },
        [68] = { `mpbiker_overlays`, `MP_Biker_Hair_002_M` },
        [69] = { `mpbiker_overlays`, `MP_Biker_Hair_003_M` },
        [70] = { `mpbiker_overlays`, `MP_Biker_Hair_004_M` },
        [71] = { `mpbiker_overlays`, `MP_Biker_Hair_005_M` },
        [72] = { `mpgunrunning_overlays`, `MP_Gunrunning_Hair_M_000_M` },
        [73] = { `mpgunrunning_overlays`, `MP_Gunrunning_Hair_M_001_M` },
        [74] = { `mpVinewood_overlays`, `MP_Vinewood_Hair_M_000_M` },
        [75] = { `mptuner_overlays`, `MP_Tuner_Hair_001_M` },
        [76] = { `mpsecurity_overlays`, `MP_Security_Hair_001_M` },
    },
    [`mp_f_freemode_01`] = {
        [0] = { `mpbeach_overlays`, `FM_Hair_Fuzz` },
        [1] = { `multiplayer_overlays`, `NG_F_Hair_001` },
        [2] = { `multiplayer_overlays`, `NG_F_Hair_002` },
        [3] = { `multiplayer_overlays`, `NG_F_Hair_003` },
        [4] = { `multiplayer_overlays`, `NG_F_Hair_004` },
        [5] = { `multiplayer_overlays`, `NG_F_Hair_005` },
        [6] = { `multiplayer_overlays`, `NG_F_Hair_006` },
        [7] = { `multiplayer_overlays`, `NG_F_Hair_007` },
        [8] = { `multiplayer_overlays`, `NG_F_Hair_008` },
        [9] = { `multiplayer_overlays`, `NG_F_Hair_009` },
        [10] = { `multiplayer_overlays`, `NG_F_Hair_010` },
        [11] = { `multiplayer_overlays`, `NG_F_Hair_011` },
        [12] = { `multiplayer_overlays`, `NG_F_Hair_012` },
        [13] = { `multiplayer_overlays`, `NG_F_Hair_013` },
        [14] = { `multiplayer_overlays`, `NG_M_Hair_014` },
        [15] = { `multiplayer_overlays`, `NG_M_Hair_015` },
        [16] = { `multiplayer_overlays`, `NGBea_F_Hair_000` },
        [17] = { `multiplayer_overlays`, `NGBea_F_Hair_001` },
        [18] = { `multiplayer_overlays`, `NG_F_Hair_007` },
        [19] = { `multiplayer_overlays`, `NGBus_F_Hair_000` },
        [20] = { `multiplayer_overlays`, `NGBus_F_Hair_001` },
        [21] = { `multiplayer_overlays`, `NGBea_F_Hair_001` },
        [22] = { `multiplayer_overlays`, `NGHip_F_Hair_000` },
        [23] = { `multiplayer_overlays`, `NGInd_F_Hair_000` },
        [25] = { `mplowrider_overlays`, `LR_F_Hair_000` },
        [26] = { `mplowrider_overlays`, `LR_F_Hair_001` },
        [27] = { `mplowrider_overlays`, `LR_F_Hair_002` },
        [28] = { `mplowrider2_overlays`, `LR_F_Hair_003` },
        [29] = { `mplowrider2_overlays`, `LR_F_Hair_003` },
        [30] = { `mplowrider2_overlays`, `LR_F_Hair_004` },
        [31] = { `mplowrider2_overlays`, `LR_F_Hair_006` },
        [32] = { `mpbiker_overlays`, `MP_Biker_Hair_000_F` },
        [33] = { `mpbiker_overlays`, `MP_Biker_Hair_001_F` },
        [34] = { `mpbiker_overlays`, `MP_Biker_Hair_002_F` },
        [35] = { `mpbiker_overlays`, `MP_Biker_Hair_003_F` },
        [36] = { `multiplayer_overlays`, `NG_F_Hair_003` },
        [37] = { `mpbiker_overlays`, `MP_Biker_Hair_006_F` },
        [38] = { `mpbiker_overlays`, `MP_Biker_Hair_004_F` },
        [39] = { `multiplayer_overlays`, `NG_F_Hair_001` },
        [40] = { `multiplayer_overlays`, `NG_F_Hair_002` },
        [41] = { `multiplayer_overlays`, `NG_F_Hair_003` },
        [42] = { `multiplayer_overlays`, `NG_F_Hair_004` },
        [43] = { `multiplayer_overlays`, `NG_F_Hair_005` },
        [44] = { `multiplayer_overlays`, `NG_F_Hair_006` },
        [45] = { `multiplayer_overlays`, `NG_F_Hair_007` },
        [46] = { `multiplayer_overlays`, `NG_F_Hair_008` },
        [47] = { `multiplayer_overlays`, `NG_F_Hair_009` },
        [48] = { `multiplayer_overlays`, `NG_F_Hair_010` },
        [49] = { `multiplayer_overlays`, `NG_F_Hair_011` },
        [50] = { `multiplayer_overlays`, `NG_F_Hair_012` },
        [51] = { `multiplayer_overlays`, `NG_F_Hair_013` },
        [52] = { `multiplayer_overlays`, `NG_M_Hair_014` },
        [53] = { `multiplayer_overlays`, `NG_M_Hair_015` },
        [54] = { `multiplayer_overlays`, `NGBea_F_Hair_000` },
        [55] = { `multiplayer_overlays`, `NGBea_F_Hair_001` },
        [56] = { `multiplayer_overlays`, `NG_F_Hair_007` },
        [57] = { `multiplayer_overlays`, `NGBus_F_Hair_000` },
        [58] = { `multiplayer_overlays`, `NGBus_F_Hair_001` },
        [59] = { `multiplayer_overlays`, `NGBea_F_Hair_001` },
        [60] = { `multiplayer_overlays`, `NGHip_F_Hair_000` },
        [61] = { `multiplayer_overlays`, `NGInd_F_Hair_000` },
        [62] = { `mplowrider_overlays`, `LR_F_Hair_000` },
        [63] = { `mplowrider_overlays`, `LR_F_Hair_001` },
        [64] = { `mplowrider_overlays`, `LR_F_Hair_002` },
        [65] = { `mplowrider2_overlays`, `LR_F_Hair_003` },
        [66] = { `mplowrider2_overlays`, `LR_F_Hair_003` },
        [67] = { `mplowrider2_overlays`, `LR_F_Hair_004` },
        [68] = { `mplowrider2_overlays`, `LR_F_Hair_006` },
        [69] = { `mpbiker_overlays`, `MP_Biker_Hair_000_F` },
        [70] = { `mpbiker_overlays`, `MP_Biker_Hair_001_F` },
        [71] = { `mpbiker_overlays`, `MP_Biker_Hair_002_F` },
        [72] = { `mpbiker_overlays`, `MP_Biker_Hair_003_F` },
        [73] = { `multiplayer_overlays`, `NG_F_Hair_003` },
        [74] = { `mpbiker_overlays`, `MP_Biker_Hair_006_F` },
        [75] = { `mpbiker_overlays`, `MP_Biker_Hair_004_F` },
        [76] = { `mpgunrunning_overlays`, `MP_Gunrunning_Hair_F_000_F` },
        [77] = { `mpgunrunning_overlays`, `MP_Gunrunning_Hair_F_001_F` },
        [78] = { `mpVinewood_overlays`, `MP_Vinewood_Hair_F_000_F` },
        [79] = { `mptuner_overlays`, `MP_Tuner_Hair_000_F` },
        [80] = { `mpsecurity_overlays`, `MP_Security_Hair_000_F` },
    },
}

-- Taken from illenium-appearance (https://github.com/iLLeniumStudios/illenium-appearance/blob/main/shared/tattoos.lua)
Skin.Tattoos = {
    ZONE_TORSO = {
        {
            name = "TAT_AR_000",
            label = "Turbulence",
            hashMale = "MP_Airraces_Tattoo_000_M",
            hashFemale = "MP_Airraces_Tattoo_000_F",
            zone = "ZONE_TORSO",
            collection = "mpairraces_overlays"
        },
        {
            name = "TAT_AR_001",
            label = "Pilot Skull",
            hashMale = "MP_Airraces_Tattoo_001_M",
            hashFemale = "MP_Airraces_Tattoo_001_F",
            zone = "ZONE_TORSO",
            collection = "mpairraces_overlays"
        },
        {
            name = "TAT_AR_002",
            label = "Winged Bombshell",
            hashMale = "MP_Airraces_Tattoo_002_M",
            hashFemale = "MP_Airraces_Tattoo_002_F",
            zone = "ZONE_TORSO",
            collection = "mpairraces_overlays"
        },
        {
            name = "TAT_AR_004",
            label = "Balloon Pioneer",
            hashMale = "MP_Airraces_Tattoo_004_M",
            hashFemale = "MP_Airraces_Tattoo_004_F",
            zone = "ZONE_TORSO",
            collection = "mpairraces_overlays"
        },
        {
            name = "TAT_AR_005",
            label = "Parachute Belle",
            hashMale = "MP_Airraces_Tattoo_005_M",
            hashFemale = "MP_Airraces_Tattoo_005_F",
            zone = "ZONE_TORSO",
            collection = "mpairraces_overlays"
        },
        {
            name = "TAT_AR_006",
            label = "Bombs Away",
            hashMale = "MP_Airraces_Tattoo_006_M",
            hashFemale = "MP_Airraces_Tattoo_006_F",
            zone = "ZONE_TORSO",
            collection = "mpairraces_overlays"
        },
        {
            name = "TAT_AR_007",
            label = "Eagle Eyes",
            hashMale = "MP_Airraces_Tattoo_007_M",
            hashFemale = "MP_Airraces_Tattoo_007_F",
            zone = "ZONE_TORSO",
            collection = "mpairraces_overlays"
        },
        {
            name = "TAT_BB_018",
            label = "Ship Arms",
            hashMale = "MP_Bea_M_Back_000",
            hashFemale = "",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_019",
            label = "Tribal Hammerhead",
            hashMale = "MP_Bea_M_Chest_000",
            hashFemale = "",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_020",
            label = "Tribal Shark",
            hashMale = "MP_Bea_M_Chest_001",
            hashFemale = "",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_023",
            label = "Swordfish",
            hashMale = "MP_Bea_M_Stom_000",
            hashFemale = "",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_032",
            label = "Wheel",
            hashMale = "MP_Bea_M_Stom_001",
            hashFemale = "",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_003",
            label = "Rock Solid",
            hashMale = "",
            hashFemale = "MP_Bea_F_Back_000",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_001",
            label = "Hibiscus Flower Duo",
            hashMale = "",
            hashFemale = "MP_Bea_F_Back_001",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_005",
            label = "Shrimp",
            hashMale = "",
            hashFemale = "MP_Bea_F_Back_002",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_012",
            label = "Anchor",
            hashMale = "",
            hashFemale = "MP_Bea_F_Chest_000",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_013",
            label = "Anchor",
            hashMale = "",
            hashFemale = "MP_Bea_F_Chest_001",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_000",
            label = "Los Santos Wreath",
            hashMale = "",
            hashFemale = "MP_Bea_F_Chest_002",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_006",
            label = "Love Dagger",
            hashMale = "",
            hashFemale = "MP_Bea_F_RSide_000",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_011",
            label = "Sea Horses",
            hashMale = "",
            hashFemale = "MP_Bea_F_Should_000",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_004",
            label = "Catfish",
            hashMale = "",
            hashFemale = "MP_Bea_F_Should_001",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_014",
            label = "Swallow",
            hashMale = "",
            hashFemale = "MP_Bea_F_Stom_000",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_009",
            label = "Hibiscus Flower",
            hashMale = "",
            hashFemale = "MP_Bea_F_Stom_001",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_010",
            label = "Dolphin",
            hashMale = "",
            hashFemale = "MP_Bea_F_Stom_002",
            zone = "ZONE_TORSO",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BI_000",
            label = "Demon Rider",
            hashMale = "MP_MP_Biker_Tat_000_M",
            hashFemale = "MP_MP_Biker_Tat_000_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_001",
            label = "Both Barrels",
            hashMale = "MP_MP_Biker_Tat_001_M",
            hashFemale = "MP_MP_Biker_Tat_001_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_003",
            label = "Web Rider",
            hashMale = "MP_MP_Biker_Tat_003_M",
            hashFemale = "MP_MP_Biker_Tat_003_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_005",
            label = "Made In America",
            hashMale = "MP_MP_Biker_Tat_005_M",
            hashFemale = "MP_MP_Biker_Tat_005_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_006",
            label = "Chopper Freedom",
            hashMale = "MP_MP_Biker_Tat_006_M",
            hashFemale = "MP_MP_Biker_Tat_006_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_008",
            label = "Freedom Wheels",
            hashMale = "MP_MP_Biker_Tat_008_M",
            hashFemale = "MP_MP_Biker_Tat_008_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_010",
            label = "Skull Of Taurus",
            hashMale = "MP_MP_Biker_Tat_010_M",
            hashFemale = "MP_MP_Biker_Tat_010_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_011",
            label = "R.I.P. My Brothers",
            hashMale = "MP_MP_Biker_Tat_011_M",
            hashFemale = "MP_MP_Biker_Tat_011_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_013",
            label = "Demon Crossbones",
            hashMale = "MP_MP_Biker_Tat_013_M",
            hashFemale = "MP_MP_Biker_Tat_013_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_017",
            label = "Clawed Beast",
            hashMale = "MP_MP_Biker_Tat_017_M",
            hashFemale = "MP_MP_Biker_Tat_017_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_018",
            label = "Skeletal Chopper",
            hashMale = "MP_MP_Biker_Tat_018_M",
            hashFemale = "MP_MP_Biker_Tat_018_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_019",
            label = "Gruesome Talons",
            hashMale = "MP_MP_Biker_Tat_019_M",
            hashFemale = "MP_MP_Biker_Tat_019_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_021",
            label = "Flaming Reaper",
            hashMale = "MP_MP_Biker_Tat_021_M",
            hashFemale = "MP_MP_Biker_Tat_021_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_023",
            label = "Western MC",
            hashMale = "MP_MP_Biker_Tat_023_M",
            hashFemale = "MP_MP_Biker_Tat_023_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_026",
            label = "American Dream",
            hashMale = "MP_MP_Biker_Tat_026_M",
            hashFemale = "MP_MP_Biker_Tat_026_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_029",
            label = "Bone Wrench",
            hashMale = "MP_MP_Biker_Tat_029_M",
            hashFemale = "MP_MP_Biker_Tat_029_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_030",
            label = "Brothers For Life",
            hashMale = "MP_MP_Biker_Tat_030_M",
            hashFemale = "MP_MP_Biker_Tat_030_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_031",
            label = "Gear Head",
            hashMale = "MP_MP_Biker_Tat_031_M",
            hashFemale = "MP_MP_Biker_Tat_031_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_032",
            label = "Western Eagle",
            hashMale = "MP_MP_Biker_Tat_032_M",
            hashFemale = "MP_MP_Biker_Tat_032_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_034",
            label = "Brotherhood of Bikes",
            hashMale = "MP_MP_Biker_Tat_034_M",
            hashFemale = "MP_MP_Biker_Tat_034_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_039",
            label = "Gas Guzzler",
            hashMale = "MP_MP_Biker_Tat_039_M",
            hashFemale = "MP_MP_Biker_Tat_039_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_041",
            label = "No Regrets",
            hashMale = "MP_MP_Biker_Tat_041_M",
            hashFemale = "MP_MP_Biker_Tat_041_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_043",
            label = "Ride Forever",
            hashMale = "MP_MP_Biker_Tat_043_M",
            hashFemale = "MP_MP_Biker_Tat_043_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_050",
            label = "Unforgiven",
            hashMale = "MP_MP_Biker_Tat_050_M",
            hashFemale = "MP_MP_Biker_Tat_050_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_052",
            label = "Biker Mount",
            hashMale = "MP_MP_Biker_Tat_052_M",
            hashFemale = "MP_MP_Biker_Tat_052_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_058",
            label = "Reaper Vulture",
            hashMale = "MP_MP_Biker_Tat_058_M",
            hashFemale = "MP_MP_Biker_Tat_058_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_059",
            label = "Faggio",
            hashMale = "MP_MP_Biker_Tat_059_M",
            hashFemale = "MP_MP_Biker_Tat_059_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_060",
            label = "We Are The Mods!",
            hashMale = "MP_MP_Biker_Tat_060_M",
            hashFemale = "MP_MP_Biker_Tat_060_F",
            zone = "ZONE_TORSO",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BUS_011",
            label = "Refined Hustler",
            hashMale = "MP_Buis_M_Stomach_000",
            hashFemale = "",
            zone = "ZONE_TORSO",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_001",
            label = "Rich",
            hashMale = "MP_Buis_M_Chest_000",
            hashFemale = "",
            zone = "ZONE_TORSO",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_002",
            label = "$$$",
            hashMale = "MP_Buis_M_Chest_001",
            hashFemale = "",
            zone = "ZONE_TORSO",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_000",
            label = "Makin' Paper",
            hashMale = "MP_Buis_M_Back_000",
            hashFemale = "",
            zone = "ZONE_TORSO",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_F_002",
            label = "High Roller",
            hashMale = "",
            hashFemale = "MP_Buis_F_Chest_000",
            zone = "ZONE_TORSO",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_F_003",
            label = "Makin' Money",
            hashMale = "",
            hashFemale = "MP_Buis_F_Chest_001",
            zone = "ZONE_TORSO",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_F_004",
            label = "Love Money",
            hashMale = "",
            hashFemale = "MP_Buis_F_Chest_002",
            zone = "ZONE_TORSO",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_F_011",
            label = "Diamond Back",
            hashMale = "",
            hashFemale = "MP_Buis_F_Stom_000",
            zone = "ZONE_TORSO",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_F_012",
            label = "Santo Capra Logo",
            hashMale = "",
            hashFemale = "MP_Buis_F_Stom_001",
            zone = "ZONE_TORSO",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_F_013",
            label = "Money Bag",
            hashMale = "",
            hashFemale = "MP_Buis_F_Stom_002",
            zone = "ZONE_TORSO",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_F_000",
            label = "Respect",
            hashMale = "",
            hashFemale = "MP_Buis_F_Back_000",
            zone = "ZONE_TORSO",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_F_001",
            label = "Gold Digger",
            hashMale = "",
            hashFemale = "MP_Buis_F_Back_001",
            zone = "ZONE_TORSO",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_H27_000",
            label = "Thor & Goblin",
            hashMale = "MP_Christmas2017_Tattoo_000_M",
            hashFemale = "MP_Christmas2017_Tattoo_000_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_002",
            label = "Kabuto",
            hashMale = "MP_Christmas2017_Tattoo_002_M",
            hashFemale = "MP_Christmas2017_Tattoo_002_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_003",
            label = "Native Warrior",
            hashMale = "MP_Christmas2017_Tattoo_003_M",
            hashFemale = "MP_Christmas2017_Tattoo_003_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_005",
            label = "Ghost Dragon",
            hashMale = "MP_Christmas2017_Tattoo_005_M",
            hashFemale = "MP_Christmas2017_Tattoo_005_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_008",
            label = "Spartan Warrior",
            hashMale = "MP_Christmas2017_Tattoo_008_M",
            hashFemale = "MP_Christmas2017_Tattoo_008_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_009",
            label = "Norse Rune",
            hashMale = "MP_Christmas2017_Tattoo_009_M",
            hashFemale = "MP_Christmas2017_Tattoo_009_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_010",
            label = "Spartan Shield",
            hashMale = "MP_Christmas2017_Tattoo_010_M",
            hashFemale = "MP_Christmas2017_Tattoo_010_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_011",
            label = "Weathered Skull",
            hashMale = "MP_Christmas2017_Tattoo_011_M",
            hashFemale = "MP_Christmas2017_Tattoo_011_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_015",
            label = "Samurai Combat",
            hashMale = "MP_Christmas2017_Tattoo_015_M",
            hashFemale = "MP_Christmas2017_Tattoo_015_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_016",
            label = "Odin & Raven",
            hashMale = "MP_Christmas2017_Tattoo_016_M",
            hashFemale = "MP_Christmas2017_Tattoo_016_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_019",
            label = "Strike Force",
            hashMale = "MP_Christmas2017_Tattoo_019_M",
            hashFemale = "MP_Christmas2017_Tattoo_019_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_020",
            label = "Medusa's Gaze",
            hashMale = "MP_Christmas2017_Tattoo_020_M",
            hashFemale = "MP_Christmas2017_Tattoo_020_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_021",
            label = "Spartan & Lion",
            hashMale = "MP_Christmas2017_Tattoo_021_M",
            hashFemale = "MP_Christmas2017_Tattoo_021_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_022",
            label = "Spartan & Horse",
            hashMale = "MP_Christmas2017_Tattoo_022_M",
            hashFemale = "MP_Christmas2017_Tattoo_022_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_024",
            label = "Dragon Slayer",
            hashMale = "MP_Christmas2017_Tattoo_024_M",
            hashFemale = "MP_Christmas2017_Tattoo_024_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_026",
            label = "Spartan Skull",
            hashMale = "MP_Christmas2017_Tattoo_026_M",
            hashFemale = "MP_Christmas2017_Tattoo_026_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_027",
            label = "Molon Labe",
            hashMale = "MP_Christmas2017_Tattoo_027_M",
            hashFemale = "MP_Christmas2017_Tattoo_027_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_AW_000",
            label = "???",
            hashMale = "MP_Christmas2018_Tat_000_M",
            hashFemale = "MP_Christmas2018_Tat_000_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2018_overlays"
        },
        {
            name = "TAT_X2_005",
            label = "Carp Outline",
            hashMale = "MP_Xmas2_M_Tat_005",
            hashFemale = "MP_Xmas2_F_Tat_005",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_006",
            label = "Carp Shaded",
            hashMale = "MP_Xmas2_M_Tat_006",
            hashFemale = "MP_Xmas2_F_Tat_006",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_009",
            label = "Time To Die",
            hashMale = "MP_Xmas2_M_Tat_009",
            hashFemale = "MP_Xmas2_F_Tat_009",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_011",
            label = "Roaring Tiger",
            hashMale = "MP_Xmas2_M_Tat_011",
            hashFemale = "MP_Xmas2_F_Tat_011",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_013",
            label = "Lizard",
            hashMale = "MP_Xmas2_M_Tat_013",
            hashFemale = "MP_Xmas2_F_Tat_013",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_015",
            label = "Japanese Warrior",
            hashMale = "MP_Xmas2_M_Tat_015",
            hashFemale = "MP_Xmas2_F_Tat_015",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_016",
            label = "Loose Lips Outline",
            hashMale = "MP_Xmas2_M_Tat_016",
            hashFemale = "MP_Xmas2_F_Tat_016",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_017",
            label = "Loose Lips Color",
            hashMale = "MP_Xmas2_M_Tat_017",
            hashFemale = "MP_Xmas2_F_Tat_017",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_018",
            label = "Royal Dagger Outline",
            hashMale = "MP_Xmas2_M_Tat_018",
            hashFemale = "MP_Xmas2_F_Tat_018",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_019",
            label = "Royal Dagger Color",
            hashMale = "MP_Xmas2_M_Tat_019",
            hashFemale = "MP_Xmas2_F_Tat_019",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_028",
            label = "Executioner",
            hashMale = "MP_Xmas2_M_Tat_028",
            hashFemale = "MP_Xmas2_F_Tat_028",
            zone = "ZONE_TORSO",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_GR_000",
            label = "Bullet Proof",
            hashMale = "MP_Gunrunning_Tattoo_000_M",
            hashFemale = "MP_Gunrunning_Tattoo_000_F",
            zone = "ZONE_TORSO",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_001",
            label = "Crossed Weapons",
            hashMale = "MP_Gunrunning_Tattoo_001_M",
            hashFemale = "MP_Gunrunning_Tattoo_001_F",
            zone = "ZONE_TORSO",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_009",
            label = "Butterfly Knife",
            hashMale = "MP_Gunrunning_Tattoo_009_M",
            hashFemale = "MP_Gunrunning_Tattoo_009_F",
            zone = "ZONE_TORSO",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_010",
            label = "Cash Money",
            hashMale = "MP_Gunrunning_Tattoo_010_M",
            hashFemale = "MP_Gunrunning_Tattoo_010_F",
            zone = "ZONE_TORSO",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_012",
            label = "Dollar Daggers",
            hashMale = "MP_Gunrunning_Tattoo_012_M",
            hashFemale = "MP_Gunrunning_Tattoo_012_F",
            zone = "ZONE_TORSO",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_013",
            label = "Wolf Insignia",
            hashMale = "MP_Gunrunning_Tattoo_013_M",
            hashFemale = "MP_Gunrunning_Tattoo_013_F",
            zone = "ZONE_TORSO",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_014",
            label = "Backstabber",
            hashMale = "MP_Gunrunning_Tattoo_014_M",
            hashFemale = "MP_Gunrunning_Tattoo_014_F",
            zone = "ZONE_TORSO",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_017",
            label = "Dog Tags",
            hashMale = "MP_Gunrunning_Tattoo_017_M",
            hashFemale = "MP_Gunrunning_Tattoo_017_F",
            zone = "ZONE_TORSO",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_018",
            label = "Dual Wield Skull",
            hashMale = "MP_Gunrunning_Tattoo_018_M",
            hashFemale = "MP_Gunrunning_Tattoo_018_F",
            zone = "ZONE_TORSO",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_019",
            label = "Pistol Wings",
            hashMale = "MP_Gunrunning_Tattoo_019_M",
            hashFemale = "MP_Gunrunning_Tattoo_019_F",
            zone = "ZONE_TORSO",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_020",
            label = "Crowned Weapons",
            hashMale = "MP_Gunrunning_Tattoo_020_M",
            hashFemale = "MP_Gunrunning_Tattoo_020_F",
            zone = "ZONE_TORSO",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_022",
            label = "Explosive Heart",
            hashMale = "MP_Gunrunning_Tattoo_022_M",
            hashFemale = "MP_Gunrunning_Tattoo_022_F",
            zone = "ZONE_TORSO",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_028",
            label = "Micro SMG Chain",
            hashMale = "MP_Gunrunning_Tattoo_028_M",
            hashFemale = "MP_Gunrunning_Tattoo_028_F",
            zone = "ZONE_TORSO",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_029",
            label = "Win Some Lose Some",
            hashMale = "MP_Gunrunning_Tattoo_029_M",
            hashFemale = "MP_Gunrunning_Tattoo_029_F",
            zone = "ZONE_TORSO",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_H3_023",
            label = "Bigfoot",
            hashMale = "mpHeist3_Tat_023_M",
            hashFemale = "mpHeist3_Tat_023_F",
            zone = "ZONE_TORSO",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_024",
            label = "Mount Chiliad",
            hashMale = "mpHeist3_Tat_024_M",
            hashFemale = "mpHeist3_Tat_024_F",
            zone = "ZONE_TORSO",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_025",
            label = "Davis",
            hashMale = "mpHeist3_Tat_025_M",
            hashFemale = "mpHeist3_Tat_025_F",
            zone = "ZONE_TORSO",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_026",
            label = "Dignity",
            hashMale = "mpHeist3_Tat_026_M",
            hashFemale = "mpHeist3_Tat_026_F",
            zone = "ZONE_TORSO",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_027",
            label = "Epsilon",
            hashMale = "mpHeist3_Tat_027_M",
            hashFemale = "mpHeist3_Tat_027_F",
            zone = "ZONE_TORSO",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_028",
            label = "Bananas Gone Bad",
            hashMale = "mpHeist3_Tat_028_M",
            hashFemale = "mpHeist3_Tat_028_F",
            zone = "ZONE_TORSO",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_029",
            label = "Fatal Incursion",
            hashMale = "mpHeist3_Tat_029_M",
            hashFemale = "mpHeist3_Tat_029_F",
            zone = "ZONE_TORSO",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_030",
            label = "Howitzer",
            hashMale = "mpHeist3_Tat_030_M",
            hashFemale = "mpHeist3_Tat_030_F",
            zone = "ZONE_TORSO",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_033",
            label = "LS City",
            hashMale = "mpHeist3_Tat_033_M",
            hashFemale = "mpHeist3_Tat_033_F",
            zone = "ZONE_TORSO",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_035",
            label = "LS Panic",
            hashMale = "mpHeist3_Tat_035_M",
            hashFemale = "mpHeist3_Tat_035_F",
            zone = "ZONE_TORSO",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_036",
            label = "LS Shield",
            hashMale = "mpHeist3_Tat_036_M",
            hashFemale = "mpHeist3_Tat_036_F",
            zone = "ZONE_TORSO",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_037",
            label = "Ladybug",
            hashMale = "mpHeist3_Tat_037_M",
            hashFemale = "mpHeist3_Tat_037_F",
            zone = "ZONE_TORSO",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_038",
            label = "Robot Bubblegum",
            hashMale = "mpHeist3_Tat_038_M",
            hashFemale = "mpHeist3_Tat_038_F",
            zone = "ZONE_TORSO",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_039",
            label = "Space Rangers",
            hashMale = "mpHeist3_Tat_039_M",
            hashFemale = "mpHeist3_Tat_039_F",
            zone = "ZONE_TORSO",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H4_004",
            label = "Skeleton Breeze",
            hashMale = "MP_Heist4_Tat_004_M",
            hashFemale = "MP_Heist4_Tat_004_F",
            zone = "ZONE_TORSO",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_013",
            label = "Wild Dancers",
            hashMale = "MP_Heist4_Tat_013_M",
            hashFemale = "MP_Heist4_Tat_013_F",
            zone = "ZONE_TORSO",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_014",
            label = "Paradise Nap",
            hashMale = "MP_Heist4_Tat_014_M",
            hashFemale = "MP_Heist4_Tat_014_F",
            zone = "ZONE_TORSO",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_015",
            label = "Paradise Ukulele",
            hashMale = "MP_Heist4_Tat_015_M",
            hashFemale = "MP_Heist4_Tat_015_F",
            zone = "ZONE_TORSO",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_016",
            label = "Rose Panther",
            hashMale = "MP_Heist4_Tat_016_M",
            hashFemale = "MP_Heist4_Tat_016_F",
            zone = "ZONE_TORSO",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_017",
            label = "Tropical Sorcerer",
            hashMale = "MP_Heist4_Tat_017_M",
            hashFemale = "MP_Heist4_Tat_017_F",
            zone = "ZONE_TORSO",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_018",
            label = "Record Head",
            hashMale = "MP_Heist4_Tat_018_M",
            hashFemale = "MP_Heist4_Tat_018_F",
            zone = "ZONE_TORSO",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_019",
            label = "Record Shot",
            hashMale = "MP_Heist4_Tat_019_M",
            hashFemale = "MP_Heist4_Tat_019_F",
            zone = "ZONE_TORSO",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_020",
            label = "Speaker Tower",
            hashMale = "MP_Heist4_Tat_020_M",
            hashFemale = "MP_Heist4_Tat_020_F",
            zone = "ZONE_TORSO",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_021",
            label = "Skull Surfer",
            hashMale = "MP_Heist4_Tat_021_M",
            hashFemale = "MP_Heist4_Tat_021_F",
            zone = "ZONE_TORSO",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_022",
            label = "Paradise Sirens",
            hashMale = "MP_Heist4_Tat_022_M",
            hashFemale = "MP_Heist4_Tat_022_F",
            zone = "ZONE_TORSO",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_023",
            label = "Techno Glitch",
            hashMale = "MP_Heist4_Tat_023_M",
            hashFemale = "MP_Heist4_Tat_023_F",
            zone = "ZONE_TORSO",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_030",
            label = "Radio Tape",
            hashMale = "MP_Heist4_Tat_030_M",
            hashFemale = "MP_Heist4_Tat_030_F",
            zone = "ZONE_TORSO",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_HP_000",
            label = "Crossed Arrows",
            hashMale = "FM_Hip_M_Tat_000",
            hashFemale = "FM_Hip_F_Tat_000",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_002",
            label = "Chemistry",
            hashMale = "FM_Hip_M_Tat_002",
            hashFemale = "FM_Hip_F_Tat_002",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_006",
            label = "Feather Birds",
            hashMale = "FM_Hip_M_Tat_006",
            hashFemale = "FM_Hip_F_Tat_006",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_011",
            label = "Infinity",
            hashMale = "FM_Hip_M_Tat_011",
            hashFemale = "FM_Hip_F_Tat_011",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_012",
            label = "Antlers",
            hashMale = "FM_Hip_M_Tat_012",
            hashFemale = "FM_Hip_F_Tat_012",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_013",
            label = "Boombox",
            hashMale = "FM_Hip_M_Tat_013",
            hashFemale = "FM_Hip_F_Tat_013",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_024",
            label = "Pyramid",
            hashMale = "FM_Hip_M_Tat_024",
            hashFemale = "FM_Hip_F_Tat_024",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_025",
            label = "Watch Your Step",
            hashMale = "FM_Hip_M_Tat_025",
            hashFemale = "FM_Hip_F_Tat_025",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_029",
            label = "Sad",
            hashMale = "FM_Hip_M_Tat_029",
            hashFemale = "FM_Hip_F_Tat_029",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_030",
            label = "Shark Fin",
            hashMale = "FM_Hip_M_Tat_030",
            hashFemale = "FM_Hip_F_Tat_030",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_031",
            label = "Skateboard",
            hashMale = "FM_Hip_M_Tat_031",
            hashFemale = "FM_Hip_F_Tat_031",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_032",
            label = "Paper Plane",
            hashMale = "FM_Hip_M_Tat_032",
            hashFemale = "FM_Hip_F_Tat_032",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_033",
            label = "Stag",
            hashMale = "FM_Hip_M_Tat_033",
            hashFemale = "FM_Hip_F_Tat_033",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_035",
            label = "Sewn Heart",
            hashMale = "FM_Hip_M_Tat_035",
            hashFemale = "FM_Hip_F_Tat_035",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_041",
            label = "Tooth",
            hashMale = "FM_Hip_M_Tat_041",
            hashFemale = "FM_Hip_F_Tat_041",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_046",
            label = "Triangles",
            hashMale = "FM_Hip_M_Tat_046",
            hashFemale = "FM_Hip_F_Tat_046",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_047",
            label = "Cassette",
            hashMale = "FM_Hip_M_Tat_047",
            hashFemale = "FM_Hip_F_Tat_047",
            zone = "ZONE_TORSO",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_IE_000",
            label = "Block Back",
            hashMale = "MP_MP_ImportExport_Tat_000_M",
            hashFemale = "MP_MP_ImportExport_Tat_000_F",
            zone = "ZONE_TORSO",
            collection = "mpimportexport_overlays"
        },
        {
            name = "TAT_IE_001",
            label = "Power Plant",
            hashMale = "MP_MP_ImportExport_Tat_001_M",
            hashFemale = "MP_MP_ImportExport_Tat_001_F",
            zone = "ZONE_TORSO",
            collection = "mpimportexport_overlays"
        },
        {
            name = "TAT_IE_002",
            label = "Tuned to Death",
            hashMale = "MP_MP_ImportExport_Tat_002_M",
            hashFemale = "MP_MP_ImportExport_Tat_002_F",
            zone = "ZONE_TORSO",
            collection = "mpimportexport_overlays"
        },
        {
            name = "TAT_IE_009",
            label = "Serpents of Destruction",
            hashMale = "MP_MP_ImportExport_Tat_009_M",
            hashFemale = "MP_MP_ImportExport_Tat_009_F",
            zone = "ZONE_TORSO",
            collection = "mpimportexport_overlays"
        },
        {
            name = "TAT_IE_010",
            label = "Take the Wheel",
            hashMale = "MP_MP_ImportExport_Tat_010_M",
            hashFemale = "MP_MP_ImportExport_Tat_010_F",
            zone = "ZONE_TORSO",
            collection = "mpimportexport_overlays"
        },
        {
            name = "TAT_IE_011",
            label = "Talk Shit Get Hit",
            hashMale = "MP_MP_ImportExport_Tat_011_M",
            hashFemale = "MP_MP_ImportExport_Tat_011_F",
            zone = "ZONE_TORSO",
            collection = "mpimportexport_overlays"
        },
        {
            name = "TAT_S2_000",
            label = "SA Assault",
            hashMale = "MP_LR_Tat_000_M",
            hashFemale = "MP_LR_Tat_000_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider2_overlays"
        },
        {
            name = "TAT_S2_008",
            label = "Love the Game",
            hashMale = "MP_LR_Tat_008_M",
            hashFemale = "MP_LR_Tat_008_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider2_overlays"
        },
        {
            name = "TAT_S2_011",
            label = "Lady Liberty",
            hashMale = "MP_LR_Tat_011_M",
            hashFemale = "MP_LR_Tat_011_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider2_overlays"
        },
        {
            name = "TAT_S2_012",
            label = "Royal Kiss",
            hashMale = "MP_LR_Tat_012_M",
            hashFemale = "MP_LR_Tat_012_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider2_overlays"
        },
        {
            name = "TAT_S2_016",
            label = "Two Face",
            hashMale = "MP_LR_Tat_016_M",
            hashFemale = "MP_LR_Tat_016_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider2_overlays"
        },
        {
            name = "TAT_S2_019",
            label = "Death Behind",
            hashMale = "MP_LR_Tat_019_M",
            hashFemale = "MP_LR_Tat_019_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider2_overlays"
        },
        {
            name = "TAT_S2_031",
            label = "Dead Pretty",
            hashMale = "MP_LR_Tat_031_M",
            hashFemale = "MP_LR_Tat_031_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider2_overlays"
        },
        {
            name = "TAT_S2_032",
            label = "Reign Over",
            hashMale = "MP_LR_Tat_032_M",
            hashFemale = "MP_LR_Tat_032_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider2_overlays"
        },
        {
            name = "TAT_S1_001",
            label = "King Fight",
            hashMale = "MP_LR_Tat_001_M",
            hashFemale = "MP_LR_Tat_001_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_S1_002",
            label = "Holy Mary",
            hashMale = "MP_LR_Tat_002_M",
            hashFemale = "MP_LR_Tat_002_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_S1_004",
            label = "Gun Mic",
            hashMale = "MP_LR_Tat_004_M",
            hashFemale = "MP_LR_Tat_004_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_S1_009",
            label = "Amazon",
            hashMale = "MP_LR_Tat_009_M",
            hashFemale = "MP_LR_Tat_009_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_S1_010",
            label = "Bad Angel",
            hashMale = "MP_LR_Tat_010_M",
            hashFemale = "MP_LR_Tat_010_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_S1_013",
            label = "Love Gamble",
            hashMale = "MP_LR_Tat_013_M",
            hashFemale = "MP_LR_Tat_013_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_S1_014",
            label = "Love is Blind",
            hashMale = "MP_LR_Tat_014_M",
            hashFemale = "MP_LR_Tat_014_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_S1_021",
            label = "Sad Angel",
            hashMale = "MP_LR_Tat_021_M",
            hashFemale = "MP_LR_Tat_021_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_S1_026",
            label = "Royal Takeover",
            hashMale = "MP_LR_Tat_026_M",
            hashFemale = "MP_LR_Tat_026_F",
            zone = "ZONE_TORSO",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_L2_002",
            label = "The Howler",
            hashMale = "MP_LUXE_TAT_002_M",
            hashFemale = "MP_LUXE_TAT_002_F",
            zone = "ZONE_TORSO",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_L2_012",
            label = "Geometric Galaxy",
            hashMale = "MP_LUXE_TAT_012_M",
            hashFemale = "MP_LUXE_TAT_012_F",
            zone = "ZONE_TORSO",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_L2_022",
            label = "Cloaked Angel",
            hashMale = "MP_LUXE_TAT_022_M",
            hashFemale = "MP_LUXE_TAT_022_F",
            zone = "ZONE_TORSO",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_L2_025",
            label = "Reaper Sway",
            hashMale = "MP_LUXE_TAT_025_M",
            hashFemale = "MP_LUXE_TAT_025_F",
            zone = "ZONE_TORSO",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_L2_027",
            label = "Cobra Dawn",
            hashMale = "MP_LUXE_TAT_027_M",
            hashFemale = "MP_LUXE_TAT_027_F",
            zone = "ZONE_TORSO",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_L2_029",
            label = "Geometric Design",
            hashMale = "MP_LUXE_TAT_029_M",
            hashFemale = "MP_LUXE_TAT_029_F",
            zone = "ZONE_TORSO",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_LX_003",
            label = "Abstract Skull",
            hashMale = "MP_LUXE_TAT_003_M",
            hashFemale = "MP_LUXE_TAT_003_F",
            zone = "ZONE_TORSO",
            collection = "mpluxe_overlays"
        },
        {
            name = "TAT_LX_006",
            label = "Adorned Wolf",
            hashMale = "MP_LUXE_TAT_006_M",
            hashFemale = "MP_LUXE_TAT_006_F",
            zone = "ZONE_TORSO",
            collection = "mpluxe_overlays"
        },
        {
            name = "TAT_LX_007",
            label = "Eye of the Griffin",
            hashMale = "MP_LUXE_TAT_007_M",
            hashFemale = "MP_LUXE_TAT_007_F",
            zone = "ZONE_TORSO",
            collection = "mpluxe_overlays"
        },
        {
            name = "TAT_LX_008",
            label = "Flying Eye",
            hashMale = "MP_LUXE_TAT_008_M",
            hashFemale = "MP_LUXE_TAT_008_F",
            zone = "ZONE_TORSO",
            collection = "mpluxe_overlays"
        },
        {
            name = "TAT_LX_014",
            label = "Ancient Queen",
            hashMale = "MP_LUXE_TAT_014_M",
            hashFemale = "MP_LUXE_TAT_014_F",
            zone = "ZONE_TORSO",
            collection = "mpluxe_overlays"
        },
        {
            name = "TAT_LX_015",
            label = "Smoking Sisters",
            hashMale = "MP_LUXE_TAT_015_M",
            hashFemale = "MP_LUXE_TAT_015_F",
            zone = "ZONE_TORSO",
            collection = "mpluxe_overlays"
        },
        {
            name = "TAT_LX_024",
            label = "Feather Mural",
            hashMale = "MP_LUXE_TAT_024_M",
            hashFemale = "MP_LUXE_TAT_024_F",
            zone = "ZONE_TORSO",
            collection = "mpluxe_overlays"
        },
        {
            name = "TAT_FX_004",
            label = "Hood Heart",
            hashMale = "MP_Security_Tat_004_M",
            hashFemale = "MP_Security_Tat_004_F",
            zone = "ZONE_TORSO",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_008",
            label = "Los Santos Tag",
            hashMale = "MP_Security_Tat_008_M",
            hashFemale = "MP_Security_Tat_008_F",
            zone = "ZONE_TORSO",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_013",
            label = "Blessed Boombox",
            hashMale = "MP_Security_Tat_013_M",
            hashFemale = "MP_Security_Tat_013_F",
            zone = "ZONE_TORSO",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_014",
            label = "Chamberlain Hills",
            hashMale = "MP_Security_Tat_014_M",
            hashFemale = "MP_Security_Tat_014_F",
            zone = "ZONE_TORSO",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_015",
            label = "Smoking Barrels",
            hashMale = "MP_Security_Tat_015_M",
            hashFemale = "MP_Security_Tat_015_F",
            zone = "ZONE_TORSO",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_016",
            label = "All From The Same Tree",
            hashMale = "MP_Security_Tat_016_M",
            hashFemale = "MP_Security_Tat_016_F",
            zone = "ZONE_TORSO",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_017",
            label = "King of the Jungle",
            hashMale = "MP_Security_Tat_017_M",
            hashFemale = "MP_Security_Tat_017_F",
            zone = "ZONE_TORSO",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_018",
            label = "Night Owl",
            hashMale = "MP_Security_Tat_018_M",
            hashFemale = "MP_Security_Tat_018_F",
            zone = "ZONE_TORSO",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_024",
            label = "Beatbox Silhouette",
            hashMale = "MP_Security_Tat_024_M",
            hashFemale = "MP_Security_Tat_024_F",
            zone = "ZONE_TORSO",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_025",
            label = "Davis Flames",
            hashMale = "MP_Security_Tat_025_M",
            hashFemale = "MP_Security_Tat_025_F",
            zone = "ZONE_TORSO",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_026",
            label = "Dollar Guns Crossed",
            hashMale = "MP_Security_Tat_026_M",
            hashFemale = "MP_Security_Tat_026_F",
            zone = "ZONE_TORSO",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_SM_000",
            label = "Bless The Dead",
            hashMale = "MP_Smuggler_Tattoo_000_M",
            hashFemale = "MP_Smuggler_Tattoo_000_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_002",
            label = "Dead Lies",
            hashMale = "MP_Smuggler_Tattoo_002_M",
            hashFemale = "MP_Smuggler_Tattoo_002_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_003",
            label = "Give Nothing Back",
            hashMale = "MP_Smuggler_Tattoo_003_M",
            hashFemale = "MP_Smuggler_Tattoo_003_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_006",
            label = "Never Surrender",
            hashMale = "MP_Smuggler_Tattoo_006_M",
            hashFemale = "MP_Smuggler_Tattoo_006_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_007",
            label = "No Honor",
            hashMale = "MP_Smuggler_Tattoo_007_M",
            hashFemale = "MP_Smuggler_Tattoo_007_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_009",
            label = "Tall Ship Conflict",
            hashMale = "MP_Smuggler_Tattoo_009_M",
            hashFemale = "MP_Smuggler_Tattoo_009_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_010",
            label = "See You In Hell",
            hashMale = "MP_Smuggler_Tattoo_010_M",
            hashFemale = "MP_Smuggler_Tattoo_010_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_013",
            label = "Torn Wings",
            hashMale = "MP_Smuggler_Tattoo_013_M",
            hashFemale = "MP_Smuggler_Tattoo_013_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_015",
            label = "Jolly Roger",
            hashMale = "MP_Smuggler_Tattoo_015_M",
            hashFemale = "MP_Smuggler_Tattoo_015_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_016",
            label = "Skull Compass",
            hashMale = "MP_Smuggler_Tattoo_016_M",
            hashFemale = "MP_Smuggler_Tattoo_016_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_017",
            label = "Framed Tall Ship",
            hashMale = "MP_Smuggler_Tattoo_017_M",
            hashFemale = "MP_Smuggler_Tattoo_017_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_018",
            label = "Finders Keepers",
            hashMale = "MP_Smuggler_Tattoo_018_M",
            hashFemale = "MP_Smuggler_Tattoo_018_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_019",
            label = "Lost At Sea",
            hashMale = "MP_Smuggler_Tattoo_019_M",
            hashFemale = "MP_Smuggler_Tattoo_019_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_021",
            label = "Dead Tales",
            hashMale = "MP_Smuggler_Tattoo_021_M",
            hashFemale = "MP_Smuggler_Tattoo_021_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_022",
            label = "X Marks The Spot",
            hashMale = "MP_Smuggler_Tattoo_022_M",
            hashFemale = "MP_Smuggler_Tattoo_022_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_024",
            label = "Pirate Captain",
            hashMale = "MP_Smuggler_Tattoo_024_M",
            hashFemale = "MP_Smuggler_Tattoo_024_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_025",
            label = "Claimed By The Beast",
            hashMale = "MP_Smuggler_Tattoo_025_M",
            hashFemale = "MP_Smuggler_Tattoo_025_F",
            zone = "ZONE_TORSO",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_ST_011",
            label = "Wheels of Death",
            hashMale = "MP_MP_Stunt_tat_011_M",
            hashFemale = "MP_MP_Stunt_tat_011_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_012",
            label = "Punk Biker",
            hashMale = "MP_MP_Stunt_tat_012_M",
            hashFemale = "MP_MP_Stunt_tat_012_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_014",
            label = "Bat Cat of Spades",
            hashMale = "MP_MP_Stunt_tat_014_M",
            hashFemale = "MP_MP_Stunt_tat_014_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_018",
            label = "Vintage Bully",
            hashMale = "MP_MP_Stunt_tat_018_M",
            hashFemale = "MP_MP_Stunt_tat_018_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_019",
            label = "Engine Heart",
            hashMale = "MP_MP_Stunt_tat_019_M",
            hashFemale = "MP_MP_Stunt_tat_019_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_024",
            label = "Road Kill",
            hashMale = "MP_MP_Stunt_tat_024_M",
            hashFemale = "MP_MP_Stunt_tat_024_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_026",
            label = "Winged Wheel",
            hashMale = "MP_MP_Stunt_tat_026_M",
            hashFemale = "MP_MP_Stunt_tat_026_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_027",
            label = "Punk Road Hog",
            hashMale = "MP_MP_Stunt_tat_027_M",
            hashFemale = "MP_MP_Stunt_tat_027_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_029",
            label = "Majestic Finish",
            hashMale = "MP_MP_Stunt_tat_029_M",
            hashFemale = "MP_MP_Stunt_tat_029_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_030",
            label = "Man's Ruin",
            hashMale = "MP_MP_Stunt_tat_030_M",
            hashFemale = "MP_MP_Stunt_tat_030_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_033",
            label = "Sugar Skull Trucker",
            hashMale = "MP_MP_Stunt_tat_033_M",
            hashFemale = "MP_MP_Stunt_tat_033_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_034",
            label = "Feather Road Kill",
            hashMale = "MP_MP_Stunt_tat_034_M",
            hashFemale = "MP_MP_Stunt_tat_034_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_037",
            label = "Big Grills",
            hashMale = "MP_MP_Stunt_tat_037_M",
            hashFemale = "MP_MP_Stunt_tat_037_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_040",
            label = "Monkey Chopper",
            hashMale = "MP_MP_Stunt_tat_040_M",
            hashFemale = "MP_MP_Stunt_tat_040_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_041",
            label = "Brapp",
            hashMale = "MP_MP_Stunt_tat_041_M",
            hashFemale = "MP_MP_Stunt_tat_041_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_044",
            label = "Ram Skull",
            hashMale = "MP_MP_Stunt_tat_044_M",
            hashFemale = "MP_MP_Stunt_tat_044_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_046",
            label = "Full Throttle",
            hashMale = "MP_MP_Stunt_tat_046_M",
            hashFemale = "MP_MP_Stunt_tat_046_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_048",
            label = "Racing Doll",
            hashMale = "MP_MP_Stunt_tat_048_M",
            hashFemale = "MP_MP_Stunt_tat_048_F",
            zone = "ZONE_TORSO",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_VW_000",
            label = "In the Pocket",
            hashMale = "MP_Vinewood_Tat_000_M",
            hashFemale = "MP_Vinewood_Tat_000_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_001",
            label = "Jackpot",
            hashMale = "MP_Vinewood_Tat_001_M",
            hashFemale = "MP_Vinewood_Tat_001_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_003",
            label = "Royal Flush",
            hashMale = "MP_Vinewood_Tat_003_M",
            hashFemale = "MP_Vinewood_Tat_003_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_006",
            label = "Wheel of Suits",
            hashMale = "MP_Vinewood_Tat_006_M",
            hashFemale = "MP_Vinewood_Tat_006_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_007",
            label = "777",
            hashMale = "MP_Vinewood_Tat_007_M",
            hashFemale = "MP_Vinewood_Tat_007_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_008",
            label = "Snake Eyes",
            hashMale = "MP_Vinewood_Tat_008_M",
            hashFemale = "MP_Vinewood_Tat_008_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_009",
            label = "Till Death Do Us Part",
            hashMale = "MP_Vinewood_Tat_009_M",
            hashFemale = "MP_Vinewood_Tat_009_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_010",
            label = "Photo Finish",
            hashMale = "MP_Vinewood_Tat_010_M",
            hashFemale = "MP_Vinewood_Tat_010_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_011",
            label = "Life's a Gamble",
            hashMale = "MP_Vinewood_Tat_011_M",
            hashFemale = "MP_Vinewood_Tat_011_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_012",
            label = "Skull of Suits",
            hashMale = "MP_Vinewood_Tat_012_M",
            hashFemale = "MP_Vinewood_Tat_012_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_015",
            label = "The Jolly Joker",
            hashMale = "MP_Vinewood_Tat_015_M",
            hashFemale = "MP_Vinewood_Tat_015_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_016",
            label = "Rose & Aces",
            hashMale = "MP_Vinewood_Tat_016_M",
            hashFemale = "MP_Vinewood_Tat_016_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_017",
            label = "Roll the Dice",
            hashMale = "MP_Vinewood_Tat_017_M",
            hashFemale = "MP_Vinewood_Tat_017_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_021",
            label = "Show Your Hand",
            hashMale = "MP_Vinewood_Tat_021_M",
            hashFemale = "MP_Vinewood_Tat_021_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_022",
            label = "Blood Money",
            hashMale = "MP_Vinewood_Tat_022_M",
            hashFemale = "MP_Vinewood_Tat_022_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_023",
            label = "Lucky 7s",
            hashMale = "MP_Vinewood_Tat_023_M",
            hashFemale = "MP_Vinewood_Tat_023_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_024",
            label = "Cash Mouth",
            hashMale = "MP_Vinewood_Tat_024_M",
            hashFemale = "MP_Vinewood_Tat_024_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_029",
            label = "The Table",
            hashMale = "MP_Vinewood_Tat_029_M",
            hashFemale = "MP_Vinewood_Tat_029_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_030",
            label = "The Royals",
            hashMale = "MP_Vinewood_Tat_030_M",
            hashFemale = "MP_Vinewood_Tat_030_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_031",
            label = "Gambling Royalty",
            hashMale = "MP_Vinewood_Tat_031_M",
            hashFemale = "MP_Vinewood_Tat_031_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_032",
            label = "Play Your Ace",
            hashMale = "MP_Vinewood_Tat_032_M",
            hashFemale = "MP_Vinewood_Tat_032_F",
            zone = "ZONE_TORSO",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_FM_011",
            label = "Blackjack",
            hashMale = "FM_Tat_Award_M_003",
            hashFemale = "FM_Tat_Award_F_003",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_012",
            label = "Hustler",
            hashMale = "FM_Tat_Award_M_004",
            hashFemale = "FM_Tat_Award_F_004",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_013",
            label = "Angel",
            hashMale = "FM_Tat_Award_M_005",
            hashFemale = "FM_Tat_Award_F_005",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_016",
            label = "Los Santos Customs",
            hashMale = "FM_Tat_Award_M_008",
            hashFemale = "FM_Tat_Award_F_008",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_019",
            label = "Blank Scroll",
            hashMale = "FM_Tat_Award_M_011",
            hashFemale = "FM_Tat_Award_F_011",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_020",
            label = "Embellished Scroll",
            hashMale = "FM_Tat_Award_M_012",
            hashFemale = "FM_Tat_Award_F_012",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_021",
            label = "Seven Deadly Sins",
            hashMale = "FM_Tat_Award_M_013",
            hashFemale = "FM_Tat_Award_F_013",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_022",
            label = "Trust No One",
            hashMale = "FM_Tat_Award_M_014",
            hashFemale = "FM_Tat_Award_F_014",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_024",
            label = "Clown",
            hashMale = "FM_Tat_Award_M_016",
            hashFemale = "FM_Tat_Award_F_016",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_025",
            label = "Clown and Gun",
            hashMale = "FM_Tat_Award_M_017",
            hashFemale = "FM_Tat_Award_F_017",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_026",
            label = "Clown Dual Wield",
            hashMale = "FM_Tat_Award_M_018",
            hashFemale = "FM_Tat_Award_F_018",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_027",
            label = "Clown Dual Wield Dollars",
            hashMale = "FM_Tat_Award_M_019",
            hashFemale = "FM_Tat_Award_F_019",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_219",
            label = "Faith",
            hashMale = "FM_Tat_M_004",
            hashFemale = "FM_Tat_F_004",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_213",
            label = "Skull on the Cross",
            hashMale = "FM_Tat_M_009",
            hashFemale = "FM_Tat_F_009",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_218",
            label = "LS Flames",
            hashMale = "FM_Tat_M_010",
            hashFemale = "FM_Tat_F_010",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_214",
            label = "LS Script",
            hashMale = "FM_Tat_M_011",
            hashFemale = "FM_Tat_F_011",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_220",
            label = "Los Santos Bills",
            hashMale = "FM_Tat_M_012",
            hashFemale = "FM_Tat_F_012",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_215",
            label = "Eagle and Serpent",
            hashMale = "FM_Tat_M_013",
            hashFemale = "FM_Tat_F_013",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_216",
            label = "Evil Clown",
            hashMale = "FM_Tat_M_016",
            hashFemale = "FM_Tat_F_016",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_217",
            label = "The Wages of Sin",
            hashMale = "FM_Tat_M_019",
            hashFemale = "FM_Tat_F_019",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_221",
            label = "Dragon",
            hashMale = "FM_Tat_M_020",
            hashFemale = "FM_Tat_F_020",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_225",
            label = "Flaming Cross",
            hashMale = "FM_Tat_M_024",
            hashFemale = "FM_Tat_F_024",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_226",
            label = "LS Bold",
            hashMale = "FM_Tat_M_025",
            hashFemale = "FM_Tat_F_025",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_230",
            label = "Trinity Knot",
            hashMale = "FM_Tat_M_029",
            hashFemale = "FM_Tat_F_029",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_231",
            label = "Lucky Celtic Dogs",
            hashMale = "FM_Tat_M_030",
            hashFemale = "FM_Tat_F_030",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_235",
            label = "Flaming Shamrock",
            hashMale = "FM_Tat_M_034",
            hashFemale = "FM_Tat_F_034",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_237",
            label = "Way of the Gun",
            hashMale = "FM_Tat_M_036",
            hashFemale = "FM_Tat_F_036",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_245",
            label = "Stone Cross",
            hashMale = "FM_Tat_M_044",
            hashFemale = "FM_Tat_F_044",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_246",
            label = "Skulls and Rose",
            hashMale = "FM_Tat_M_045",
            hashFemale = "FM_Tat_F_045",
            zone = "ZONE_TORSO",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_SB_057",
            label = "Gray Demon",
            hashMale = "MP_Sum2_Tat_057_M",
            hashFemale = "MP_Sum2_Tat_057_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_058",
            label = "Shrieking Dragon",
            hashMale = "MP_Sum2_Tat_058_M",
            hashFemale = "MP_Sum2_Tat_058_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_059",
            label = "Swords & City",
            hashMale = "MP_Sum2_Tat_059_M",
            hashFemale = "MP_Sum2_Tat_059_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_060",
            label = "Blaine County",
            hashMale = "MP_Sum2_Tat_060_M",
            hashFemale = "MP_Sum2_Tat_060_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_061",
            label = "Angry Possum",
            hashMale = "MP_Sum2_Tat_061_M",
            hashFemale = "MP_Sum2_Tat_061_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_062",
            label = "Floral Demon",
            hashMale = "MP_Sum2_Tat_062_M",
            hashFemale = "MP_Sum2_Tat_062_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_003",
            label = "Bullet Mouth",
            hashMale = "MP_Sum2_Tat_003_M",
            hashFemale = "MP_Sum2_Tat_003_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_004",
            label = "Smoking Barrel",
            hashMale = "MP_Sum2_Tat_004_M",
            hashFemale = "MP_Sum2_Tat_004_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_005",
            label = "Concealed",
            hashMale = "MP_Sum2_Tat_005_M",
            hashFemale = "MP_Sum2_Tat_005_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_006",
            label = "Painted Micro SMG",
            hashMale = "MP_Sum2_Tat_006_M",
            hashFemale = "MP_Sum2_Tat_006_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_007",
            label = "Weapon King",
            hashMale = "MP_Sum2_Tat_007_M",
            hashFemale = "MP_Sum2_Tat_007_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_035",
            label = "Sniff Sniff",
            hashMale = "MP_Sum2_Tat_035_M",
            hashFemale = "MP_Sum2_Tat_035_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_036",
            label = "Charm Pattern",
            hashMale = "MP_Sum2_Tat_036_M",
            hashFemale = "MP_Sum2_Tat_036_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_037",
            label = "Witch & Skull",
            hashMale = "MP_Sum2_Tat_037_M",
            hashFemale = "MP_Sum2_Tat_037_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_038",
            label = "Pumpkin Bug",
            hashMale = "MP_Sum2_Tat_038_M",
            hashFemale = "MP_Sum2_Tat_038_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_039",
            label = "Sinner",
            hashMale = "MP_Sum2_Tat_039_M",
            hashFemale = "MP_Sum2_Tat_039_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_040",
            label = "Carved Pumpkin",
            hashMale = "MP_Sum2_Tat_040_M",
            hashFemale = "MP_Sum2_Tat_040_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_041",
            label = "Branched Werewolf",
            hashMale = "MP_Sum2_Tat_041_M",
            hashFemale = "MP_Sum2_Tat_041_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_042",
            label = "Winged Skull",
            hashMale = "MP_Sum2_Tat_042_M",
            hashFemale = "MP_Sum2_Tat_042_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_043",
            label = "Cursed Saki",
            hashMale = "MP_Sum2_Tat_043_M",
            hashFemale = "MP_Sum2_Tat_043_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_044",
            label = "Smouldering Bat & Skull",
            hashMale = "MP_Sum2_Tat_044_M",
            hashFemale = "MP_Sum2_Tat_044_F",
            zone = "ZONE_TORSO",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_X6_004",
            label = "Herbal Bouquet",
            hashMale = "MP_Christmas3_Tat_004_M",
            hashFemale = "MP_Christmas3_Tat_004_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_005",
            label = "Cash Krampus",
            hashMale = "MP_Christmas3_Tat_005_M",
            hashFemale = "MP_Christmas3_Tat_005_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_006",
            label = "All In One Night",
            hashMale = "MP_Christmas3_Tat_006_M",
            hashFemale = "MP_Christmas3_Tat_006_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_007",
            label = "A Little Present For You",
            hashMale = "MP_Christmas3_Tat_007_M",
            hashFemale = "MP_Christmas3_Tat_007_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_014",
            label = "Masked Machete Killer",
            hashMale = "MP_Christmas3_Tat_014_M",
            hashFemale = "MP_Christmas3_Tat_014_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_015",
            label = "Killer",
            hashMale = "MP_Christmas3_Tat_015_M",
            hashFemale = "MP_Christmas3_Tat_015_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_016",
            label = "Powwer",
            hashMale = "MP_Christmas3_Tat_016_M",
            hashFemale = "MP_Christmas3_Tat_016_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_017",
            label = "Two Headed Beast",
            hashMale = "MP_Christmas3_Tat_017_M",
            hashFemale = "MP_Christmas3_Tat_017_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_018",
            label = "Dudes",
            hashMale = "MP_Christmas3_Tat_018_M",
            hashFemale = "MP_Christmas3_Tat_018_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_019",
            label = "Fooligan Jester",
            hashMale = "MP_Christmas3_Tat_019_M",
            hashFemale = "MP_Christmas3_Tat_019_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_020",
            label = "Vile Smile",
            hashMale = "MP_Christmas3_Tat_020_M",
            hashFemale = "MP_Christmas3_Tat_020_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_021",
            label = "Demon Skull Jester",
            hashMale = "MP_Christmas3_Tat_021_M",
            hashFemale = "MP_Christmas3_Tat_021_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_022",
            label = "Fatal Incursion Outline",
            hashMale = "MP_Christmas3_Tat_022_M",
            hashFemale = "MP_Christmas3_Tat_022_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_023",
            label = "Many-Headed Beast",
            hashMale = "MP_Christmas3_Tat_023_M",
            hashFemale = "MP_Christmas3_Tat_023_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_024",
            label = "Demon Stitches",
            hashMale = "MP_Christmas3_Tat_024_M",
            hashFemale = "MP_Christmas3_Tat_024_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_025",
            label = "Collector",
            hashMale = "MP_Christmas3_Tat_025_M",
            hashFemale = "MP_Christmas3_Tat_025_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_040",
            label = "Monkey",
            hashMale = "MP_Christmas3_Tat_040_M",
            hashFemale = "MP_Christmas3_Tat_040_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_041",
            label = "Dragon",
            hashMale = "MP_Christmas3_Tat_041_M",
            hashFemale = "MP_Christmas3_Tat_041_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_042",
            label = "Snake",
            hashMale = "MP_Christmas3_Tat_042_M",
            hashFemale = "MP_Christmas3_Tat_042_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_043",
            label = "Goat",
            hashMale = "MP_Christmas3_Tat_043_M",
            hashFemale = "MP_Christmas3_Tat_043_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_044",
            label = "Rat",
            hashMale = "MP_Christmas3_Tat_044_M",
            hashFemale = "MP_Christmas3_Tat_044_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_045",
            label = "Rabbit",
            hashMale = "MP_Christmas3_Tat_045_M",
            hashFemale = "MP_Christmas3_Tat_045_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_046",
            label = "Ox",
            hashMale = "MP_Christmas3_Tat_046_M",
            hashFemale = "MP_Christmas3_Tat_046_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_047",
            label = "Pig",
            hashMale = "MP_Christmas3_Tat_047_M",
            hashFemale = "MP_Christmas3_Tat_047_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_048",
            label = "Rooster",
            hashMale = "MP_Christmas3_Tat_048_M",
            hashFemale = "MP_Christmas3_Tat_048_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_049",
            label = "Dog",
            hashMale = "MP_Christmas3_Tat_049_M",
            hashFemale = "MP_Christmas3_Tat_049_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_050",
            label = "Horse",
            hashMale = "MP_Christmas3_Tat_050_M",
            hashFemale = "MP_Christmas3_Tat_050_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_051",
            label = "Tiger",
            hashMale = "MP_Christmas3_Tat_051_M",
            hashFemale = "MP_Christmas3_Tat_051_F",
            zone = "ZONE_TORSO",
            collection = "mpchristmas3_overlays"
        }
    },
    ZONE_LEFT_ARM = {
        {
            name = "TAT_AR_003",
            label = "Toxic Trails",
            hashMale = "MP_Airraces_Tattoo_003_M",
            hashFemale = "MP_Airraces_Tattoo_003_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpairraces_overlays"
        },
        {
            name = "TAT_BB_024",
            label = "Tiki Tower",
            hashMale = "MP_Bea_M_LArm_000",
            hashFemale = "",
            zone = "ZONE_LEFT_ARM",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_017",
            label = "Mermaid L.S.",
            hashMale = "MP_Bea_M_LArm_001",
            hashFemale = "",
            zone = "ZONE_LEFT_ARM",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_002",
            label = "Tribal Flower",
            hashMale = "",
            hashFemale = "MP_Bea_F_LArm_000",
            zone = "ZONE_LEFT_ARM",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_016",
            label = "Parrot",
            hashMale = "",
            hashFemale = "MP_Bea_F_LArm_001",
            zone = "ZONE_LEFT_ARM",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BI_012",
            label = "Urban Stunter",
            hashMale = "MP_MP_Biker_Tat_012_M",
            hashFemale = "MP_MP_Biker_Tat_012_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_016",
            label = "Macabre Tree",
            hashMale = "MP_MP_Biker_Tat_016_M",
            hashFemale = "MP_MP_Biker_Tat_016_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_020",
            label = "Cranial Rose",
            hashMale = "MP_MP_Biker_Tat_020_M",
            hashFemale = "MP_MP_Biker_Tat_020_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_024",
            label = "Live to Ride",
            hashMale = "MP_MP_Biker_Tat_024_M",
            hashFemale = "MP_MP_Biker_Tat_024_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_025",
            label = "Good Luck",
            hashMale = "MP_MP_Biker_Tat_025_M",
            hashFemale = "MP_MP_Biker_Tat_025_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_035",
            label = "Chain Fist",
            hashMale = "MP_MP_Biker_Tat_035_M",
            hashFemale = "MP_MP_Biker_Tat_035_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_045",
            label = "Ride Hard Die Fast",
            hashMale = "MP_MP_Biker_Tat_045_M",
            hashFemale = "MP_MP_Biker_Tat_045_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_053",
            label = "Muffler Helmet",
            hashMale = "MP_MP_Biker_Tat_053_M",
            hashFemale = "MP_MP_Biker_Tat_053_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_055",
            label = "Poison Scorpion",
            hashMale = "MP_MP_Biker_Tat_055_M",
            hashFemale = "MP_MP_Biker_Tat_055_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BUS_003",
            label = "$100 Bill",
            hashMale = "MP_Buis_M_LeftArm_000",
            hashFemale = "",
            zone = "ZONE_LEFT_ARM",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_004",
            label = "All-Seeing Eye",
            hashMale = "MP_Buis_M_LeftArm_001",
            hashFemale = "",
            zone = "ZONE_LEFT_ARM",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_F_005",
            label = "Greed is Good",
            hashMale = "",
            hashFemale = "MP_Buis_F_LArm_000",
            zone = "ZONE_LEFT_ARM",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_H27_001",
            label = "Viking Warrior",
            hashMale = "MP_Christmas2017_Tattoo_001_M",
            hashFemale = "MP_Christmas2017_Tattoo_001_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_004",
            label = "Tiger & Mask",
            hashMale = "MP_Christmas2017_Tattoo_004_M",
            hashFemale = "MP_Christmas2017_Tattoo_004_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_007",
            label = "Spartan Combat",
            hashMale = "MP_Christmas2017_Tattoo_007_M",
            hashFemale = "MP_Christmas2017_Tattoo_007_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_013",
            label = "Katana",
            hashMale = "MP_Christmas2017_Tattoo_013_M",
            hashFemale = "MP_Christmas2017_Tattoo_013_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_025",
            label = "Winged Serpent",
            hashMale = "MP_Christmas2017_Tattoo_025_M",
            hashFemale = "MP_Christmas2017_Tattoo_025_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_029",
            label = "Cerberus",
            hashMale = "MP_Christmas2017_Tattoo_029_M",
            hashFemale = "MP_Christmas2017_Tattoo_029_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_X2_000",
            label = "Skull Rider",
            hashMale = "MP_Xmas2_M_Tat_000",
            hashFemale = "MP_Xmas2_F_Tat_000",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_010",
            label = "Electric Snake",
            hashMale = "MP_Xmas2_M_Tat_010",
            hashFemale = "MP_Xmas2_F_Tat_010",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_012",
            label = "8 Ball Skull",
            hashMale = "MP_Xmas2_M_Tat_012",
            hashFemale = "MP_Xmas2_F_Tat_012",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_020",
            label = "Time's Up Outline",
            hashMale = "MP_Xmas2_M_Tat_020",
            hashFemale = "MP_Xmas2_F_Tat_020",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_021",
            label = "Time's Up Color",
            hashMale = "MP_Xmas2_M_Tat_021",
            hashFemale = "MP_Xmas2_F_Tat_021",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_GR_004",
            label = "Sidearm",
            hashMale = "MP_Gunrunning_Tattoo_004_M",
            hashFemale = "MP_Gunrunning_Tattoo_004_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_008",
            label = "Bandolier",
            hashMale = "MP_Gunrunning_Tattoo_008_M",
            hashFemale = "MP_Gunrunning_Tattoo_008_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_015",
            label = "Spiked Skull",
            hashMale = "MP_Gunrunning_Tattoo_015_M",
            hashFemale = "MP_Gunrunning_Tattoo_015_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_016",
            label = "Blood Money",
            hashMale = "MP_Gunrunning_Tattoo_016_M",
            hashFemale = "MP_Gunrunning_Tattoo_016_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_025",
            label = "Praying Skull",
            hashMale = "MP_Gunrunning_Tattoo_025_M",
            hashFemale = "MP_Gunrunning_Tattoo_025_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_027",
            label = "Serpent Revolver",
            hashMale = "MP_Gunrunning_Tattoo_027_M",
            hashFemale = "MP_Gunrunning_Tattoo_027_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_H3_040",
            label = "Tiger Heart",
            hashMale = "mpHeist3_Tat_040_M",
            hashFemale = "mpHeist3_Tat_040_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_041",
            label = "Mighty Thog",
            hashMale = "mpHeist3_Tat_041_M",
            hashFemale = "mpHeist3_Tat_041_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H4_009",
            label = "Scratch Panther",
            hashMale = "MP_Heist4_Tat_009_M",
            hashFemale = "MP_Heist4_Tat_009_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_HP_003",
            label = "Diamond Sparkle",
            hashMale = "FM_Hip_M_Tat_003",
            hashFemale = "FM_Hip_F_Tat_003",
            zone = "ZONE_LEFT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_007",
            label = "Bricks",
            hashMale = "FM_Hip_M_Tat_007",
            hashFemale = "FM_Hip_F_Tat_007",
            zone = "ZONE_LEFT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_015",
            label = "Mustache",
            hashMale = "FM_Hip_M_Tat_015",
            hashFemale = "FM_Hip_F_Tat_015",
            zone = "ZONE_LEFT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_016",
            label = "Lightning Bolt",
            hashMale = "FM_Hip_M_Tat_016",
            hashFemale = "FM_Hip_F_Tat_016",
            zone = "ZONE_LEFT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_026",
            label = "Pizza",
            hashMale = "FM_Hip_M_Tat_026",
            hashFemale = "FM_Hip_F_Tat_026",
            zone = "ZONE_LEFT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_027",
            label = "Padlock",
            hashMale = "FM_Hip_M_Tat_027",
            hashFemale = "FM_Hip_F_Tat_027",
            zone = "ZONE_LEFT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_028",
            label = "Thorny Rose",
            hashMale = "FM_Hip_M_Tat_028",
            hashFemale = "FM_Hip_F_Tat_028",
            zone = "ZONE_LEFT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_034",
            label = "Stop",
            hashMale = "FM_Hip_M_Tat_034",
            hashFemale = "FM_Hip_F_Tat_034",
            zone = "ZONE_LEFT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_037",
            label = "Sunrise",
            hashMale = "FM_Hip_M_Tat_037",
            hashFemale = "FM_Hip_F_Tat_037",
            zone = "ZONE_LEFT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_039",
            label = "Sleeve",
            hashMale = "FM_Hip_M_Tat_039",
            hashFemale = "FM_Hip_F_Tat_039",
            zone = "ZONE_LEFT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_043",
            label = "Triangle White",
            hashMale = "FM_Hip_M_Tat_043",
            hashFemale = "FM_Hip_F_Tat_043",
            zone = "ZONE_LEFT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_048",
            label = "Peace",
            hashMale = "FM_Hip_M_Tat_048",
            hashFemale = "FM_Hip_F_Tat_048",
            zone = "ZONE_LEFT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_IE_004",
            label = "Piston Sleeve",
            hashMale = "MP_MP_ImportExport_Tat_004_M",
            hashFemale = "MP_MP_ImportExport_Tat_004_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpimportexport_overlays"
        },
        {
            name = "TAT_IE_008",
            label = "Scarlett",
            hashMale = "MP_MP_ImportExport_Tat_008_M",
            hashFemale = "MP_MP_ImportExport_Tat_008_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpimportexport_overlays"
        },
        {
            name = "TAT_S2_006",
            label = "Love Hustle",
            hashMale = "MP_LR_Tat_006_M",
            hashFemale = "MP_LR_Tat_006_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mplowrider2_overlays"
        },
        {
            name = "TAT_S2_018",
            label = "Skeleton Party",
            hashMale = "MP_LR_Tat_018_M",
            hashFemale = "MP_LR_Tat_018_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mplowrider2_overlays"
        },
        {
            name = "TAT_S2_022",
            label = "My Crazy Life",
            hashMale = "MP_LR_Tat_022_M",
            hashFemale = "MP_LR_Tat_022_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mplowrider2_overlays"
        },
        {
            name = "TAT_S1_005",
            label = "No Evil",
            hashMale = "MP_LR_Tat_005_M",
            hashFemale = "MP_LR_Tat_005_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_S1_027",
            label = "Los Santos Life",
            hashMale = "MP_LR_Tat_027_M",
            hashFemale = "MP_LR_Tat_027_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_S1_033",
            label = "City Sorrow",
            hashMale = "MP_LR_Tat_033_M",
            hashFemale = "MP_LR_Tat_033_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_L2_005",
            label = "Fatal Dagger",
            hashMale = "MP_LUXE_TAT_005_M",
            hashFemale = "MP_LUXE_TAT_005_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_L2_016",
            label = "Egyptian Mural",
            hashMale = "MP_LUXE_TAT_016_M",
            hashFemale = "MP_LUXE_TAT_016_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_L2_018",
            label = "Divine Goddess",
            hashMale = "MP_LUXE_TAT_018_M",
            hashFemale = "MP_LUXE_TAT_018_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_L2_028",
            label = "Python Skull",
            hashMale = "MP_LUXE_TAT_028_M",
            hashFemale = "MP_LUXE_TAT_028_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_L2_031",
            label = "Geometric Design",
            hashMale = "MP_LUXE_TAT_031_M",
            hashFemale = "MP_LUXE_TAT_031_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_LX_009",
            label = "Floral Symmetry",
            hashMale = "MP_LUXE_TAT_009_M",
            hashFemale = "MP_LUXE_TAT_009_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpluxe_overlays"
        },
        {
            name = "TAT_LX_020",
            label = "Archangel & Mary",
            hashMale = "MP_LUXE_TAT_020_M",
            hashFemale = "MP_LUXE_TAT_020_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpluxe_overlays"
        },
        {
            name = "TAT_LX_021",
            label = "Gabriel",
            hashMale = "MP_LUXE_TAT_021_M",
            hashFemale = "MP_LUXE_TAT_021_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpluxe_overlays"
        },
        {
            name = "TAT_FX_006",
            label = "Skeleton Shot",
            hashMale = "MP_Security_Tat_006_M",
            hashFemale = "MP_Security_Tat_006_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_010",
            label = "Music Is The Remedy",
            hashMale = "MP_Security_Tat_010_M",
            hashFemale = "MP_Security_Tat_010_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_011",
            label = "Serpent Mic",
            hashMale = "MP_Security_Tat_011_M",
            hashFemale = "MP_Security_Tat_011_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_019",
            label = "Weed Knuckles",
            hashMale = "MP_Security_Tat_019_M",
            hashFemale = "MP_Security_Tat_019_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_SM_004",
            label = "Honor",
            hashMale = "MP_Smuggler_Tattoo_004_M",
            hashFemale = "MP_Smuggler_Tattoo_004_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_008",
            label = "Horrors Of The Deep",
            hashMale = "MP_Smuggler_Tattoo_008_M",
            hashFemale = "MP_Smuggler_Tattoo_008_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_014",
            label = "Mermaid's Curse",
            hashMale = "MP_Smuggler_Tattoo_014_M",
            hashFemale = "MP_Smuggler_Tattoo_014_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_ST_001",
            label = "8 Eyed Skull",
            hashMale = "MP_MP_Stunt_tat_001_M",
            hashFemale = "MP_MP_Stunt_tat_001_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_002",
            label = "Big Cat",
            hashMale = "MP_MP_Stunt_tat_002_M",
            hashFemale = "MP_MP_Stunt_tat_002_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_008",
            label = "Moonlight Ride",
            hashMale = "MP_MP_Stunt_tat_008_M",
            hashFemale = "MP_MP_Stunt_tat_008_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_022",
            label = "Piston Head",
            hashMale = "MP_MP_Stunt_tat_022_M",
            hashFemale = "MP_MP_Stunt_tat_022_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_023",
            label = "Tanked",
            hashMale = "MP_MP_Stunt_tat_023_M",
            hashFemale = "MP_MP_Stunt_tat_023_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_035",
            label = "Stuntman's End",
            hashMale = "MP_MP_Stunt_tat_035_M",
            hashFemale = "MP_MP_Stunt_tat_035_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_039",
            label = "Kaboom",
            hashMale = "MP_MP_Stunt_tat_039_M",
            hashFemale = "MP_MP_Stunt_tat_039_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_043",
            label = "Engine Arm",
            hashMale = "MP_MP_Stunt_tat_043_M",
            hashFemale = "MP_MP_Stunt_tat_043_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_VW_002",
            label = "Suits",
            hashMale = "MP_Vinewood_Tat_002_M",
            hashFemale = "MP_Vinewood_Tat_002_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_005",
            label = "Get Lucky",
            hashMale = "MP_Vinewood_Tat_005_M",
            hashFemale = "MP_Vinewood_Tat_005_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_014",
            label = "Vice",
            hashMale = "MP_Vinewood_Tat_014_M",
            hashFemale = "MP_Vinewood_Tat_014_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_019",
            label = "Can't Win Them All",
            hashMale = "MP_Vinewood_Tat_019_M",
            hashFemale = "MP_Vinewood_Tat_019_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_026",
            label = "Banknote Rose",
            hashMale = "MP_Vinewood_Tat_026_M",
            hashFemale = "MP_Vinewood_Tat_026_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_FM_009",
            label = "Burning Heart",
            hashMale = "FM_Tat_Award_M_001",
            hashFemale = "FM_Tat_Award_F_001",
            zone = "ZONE_LEFT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_015",
            label = "Racing Blonde",
            hashMale = "FM_Tat_Award_M_007",
            hashFemale = "FM_Tat_Award_F_007",
            zone = "ZONE_LEFT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_023",
            label = "Racing Brunette",
            hashMale = "FM_Tat_Award_M_015",
            hashFemale = "FM_Tat_Award_F_015",
            zone = "ZONE_LEFT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_201",
            label = "Serpents",
            hashMale = "FM_Tat_M_005",
            hashFemale = "FM_Tat_F_005",
            zone = "ZONE_LEFT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_202",
            label = "Oriental Mural",
            hashMale = "FM_Tat_M_006",
            hashFemale = "FM_Tat_F_006",
            zone = "ZONE_LEFT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_203",
            label = "Zodiac Skull",
            hashMale = "FM_Tat_M_015",
            hashFemale = "FM_Tat_F_015",
            zone = "ZONE_LEFT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_232",
            label = "Lady M",
            hashMale = "FM_Tat_M_031",
            hashFemale = "FM_Tat_F_031",
            zone = "ZONE_LEFT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_242",
            label = "Dope Skull",
            hashMale = "FM_Tat_M_041",
            hashFemale = "FM_Tat_F_041",
            zone = "ZONE_LEFT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_SB_008",
            label = "Bigness Chimp",
            hashMale = "MP_Sum2_Tat_008_M",
            hashFemale = "MP_Sum2_Tat_008_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_009",
            label = "Up-n-Atomizer Design",
            hashMale = "MP_Sum2_Tat_009_M",
            hashFemale = "MP_Sum2_Tat_009_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_010",
            label = "Rocket Launcher Girl",
            hashMale = "MP_Sum2_Tat_010_M",
            hashFemale = "MP_Sum2_Tat_010_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_028",
            label = "Laser Eyes Skull",
            hashMale = "MP_Sum2_Tat_028_M",
            hashFemale = "MP_Sum2_Tat_028_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_029",
            label = "Classic Vampire",
            hashMale = "MP_Sum2_Tat_029_M",
            hashFemale = "MP_Sum2_Tat_029_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_049",
            label = "Demon Drummer",
            hashMale = "MP_Sum2_Tat_049_M",
            hashFemale = "MP_Sum2_Tat_049_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_X6_000",
            label = "The Christmas Spirit",
            hashMale = "MP_Christmas3_Tat_000_M",
            hashFemale = "MP_Christmas3_Tat_000_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_001",
            label = "Festive Reaper",
            hashMale = "MP_Christmas3_Tat_001_M",
            hashFemale = "MP_Christmas3_Tat_001_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_026",
            label = "Fooligan Clown",
            hashMale = "MP_Christmas3_Tat_026_M",
            hashFemale = "MP_Christmas3_Tat_026_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_028",
            label = "Dude Outline",
            hashMale = "MP_Christmas3_Tat_028_M",
            hashFemale = "MP_Christmas3_Tat_028_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_030",
            label = "Dude Jester",
            hashMale = "MP_Christmas3_Tat_030_M",
            hashFemale = "MP_Christmas3_Tat_030_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_033",
            label = "Fooligan Impotent Rage",
            hashMale = "MP_Christmas3_Tat_033_M",
            hashFemale = "MP_Christmas3_Tat_033_F",
            zone = "ZONE_LEFT_ARM",
            collection = "mpchristmas3_overlays"
        }
    },
    ZONE_HEAD = {
        {
            name = "TAT_BB_021",
            label = "Pirate Skull",
            hashMale = "MP_Bea_M_Head_000",
            hashFemale = "",
            zone = "ZONE_HEAD",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_022",
            label = "Surf LS",
            hashMale = "MP_Bea_M_Head_001",
            hashFemale = "",
            zone = "ZONE_HEAD",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_031",
            label = "Shark",
            hashMale = "MP_Bea_M_Head_002",
            hashFemale = "",
            zone = "ZONE_HEAD",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_028",
            label = "Little Fish",
            hashMale = "MP_Bea_M_Neck_000",
            hashFemale = "",
            zone = "ZONE_HEAD",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_029",
            label = "Surfs Up",
            hashMale = "MP_Bea_M_Neck_001",
            hashFemale = "",
            zone = "ZONE_HEAD",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_008",
            label = "Tribal Butterfly",
            hashMale = "",
            hashFemale = "MP_Bea_F_Neck_000",
            zone = "ZONE_HEAD",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BI_009",
            label = "Morbid Arachnid",
            hashMale = "MP_MP_Biker_Tat_009_M",
            hashFemale = "MP_MP_Biker_Tat_009_F",
            zone = "ZONE_HEAD",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_038",
            label = "FTW",
            hashMale = "MP_MP_Biker_Tat_038_M",
            hashFemale = "MP_MP_Biker_Tat_038_F",
            zone = "ZONE_HEAD",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_051",
            label = "Western Stylized",
            hashMale = "MP_MP_Biker_Tat_051_M",
            hashFemale = "MP_MP_Biker_Tat_051_F",
            zone = "ZONE_HEAD",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BUS_005",
            label = "Cash is King",
            hashMale = "MP_Buis_M_Neck_000",
            hashFemale = "",
            zone = "ZONE_HEAD",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_006",
            label = "Bold Dollar Sign",
            hashMale = "MP_Buis_M_Neck_001",
            hashFemale = "",
            zone = "ZONE_HEAD",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_007",
            label = "Script Dollar Sign",
            hashMale = "MP_Buis_M_Neck_002",
            hashFemale = "",
            zone = "ZONE_HEAD",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_008",
            label = "$100",
            hashMale = "MP_Buis_M_Neck_003",
            hashFemale = "",
            zone = "ZONE_HEAD",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_F_007",
            label = "Val-de-Grace Logo",
            hashMale = "",
            hashFemale = "MP_Buis_F_Neck_000",
            zone = "ZONE_HEAD",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_F_008",
            label = "Money Rose",
            hashMale = "",
            hashFemale = "MP_Buis_F_Neck_001",
            zone = "ZONE_HEAD",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_X2_007",
            label = "Los Muertos",
            hashMale = "MP_Xmas2_M_Tat_007",
            hashFemale = "MP_Xmas2_F_Tat_007",
            zone = "ZONE_HEAD",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_024",
            label = "Snake Head Outline",
            hashMale = "MP_Xmas2_M_Tat_024",
            hashFemale = "MP_Xmas2_F_Tat_024",
            zone = "ZONE_HEAD",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_025",
            label = "Snake Head Color",
            hashMale = "MP_Xmas2_M_Tat_025",
            hashFemale = "MP_Xmas2_F_Tat_025",
            zone = "ZONE_HEAD",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_029",
            label = "Beautiful Death",
            hashMale = "MP_Xmas2_M_Tat_029",
            hashFemale = "MP_Xmas2_F_Tat_029",
            zone = "ZONE_HEAD",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_GR_003",
            label = "Lock & Load",
            hashMale = "MP_Gunrunning_Tattoo_003_M",
            hashFemale = "MP_Gunrunning_Tattoo_003_F",
            zone = "ZONE_HEAD",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_H3_000",
            label = "Five Stars",
            hashMale = "mpHeist3_Tat_000_M",
            hashFemale = "mpHeist3_Tat_000_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_001",
            label = "Ace of Spades",
            hashMale = "mpHeist3_Tat_001_M",
            hashFemale = "mpHeist3_Tat_001_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_002",
            label = "Animal",
            hashMale = "mpHeist3_Tat_002_M",
            hashFemale = "mpHeist3_Tat_002_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_003",
            label = "Assault Rifle",
            hashMale = "mpHeist3_Tat_003_M",
            hashFemale = "mpHeist3_Tat_003_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_004",
            label = "Bandage",
            hashMale = "mpHeist3_Tat_004_M",
            hashFemale = "mpHeist3_Tat_004_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_005",
            label = "Spades",
            hashMale = "mpHeist3_Tat_005_M",
            hashFemale = "mpHeist3_Tat_005_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_006",
            label = "Crowned",
            hashMale = "mpHeist3_Tat_006_M",
            hashFemale = "mpHeist3_Tat_006_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_007",
            label = "Two Horns",
            hashMale = "mpHeist3_Tat_007_M",
            hashFemale = "mpHeist3_Tat_007_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_008",
            label = "Ice Cream",
            hashMale = "mpHeist3_Tat_008_M",
            hashFemale = "mpHeist3_Tat_008_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_009",
            label = "Knifed",
            hashMale = "mpHeist3_Tat_009_M",
            hashFemale = "mpHeist3_Tat_009_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_010",
            label = "Green Leaf",
            hashMale = "mpHeist3_Tat_010_M",
            hashFemale = "mpHeist3_Tat_010_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_011",
            label = "Lipstick Kiss",
            hashMale = "mpHeist3_Tat_011_M",
            hashFemale = "mpHeist3_Tat_011_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_012",
            label = "Razor Pop",
            hashMale = "mpHeist3_Tat_012_M",
            hashFemale = "mpHeist3_Tat_012_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_013",
            label = "LS Star",
            hashMale = "mpHeist3_Tat_013_M",
            hashFemale = "mpHeist3_Tat_013_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_014",
            label = "LS Wings",
            hashMale = "mpHeist3_Tat_014_M",
            hashFemale = "mpHeist3_Tat_014_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_015",
            label = "On/Off",
            hashMale = "mpHeist3_Tat_015_M",
            hashFemale = "mpHeist3_Tat_015_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_016",
            label = "Sleepy",
            hashMale = "mpHeist3_Tat_016_M",
            hashFemale = "mpHeist3_Tat_016_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_017",
            label = "Space Monkey",
            hashMale = "mpHeist3_Tat_017_M",
            hashFemale = "mpHeist3_Tat_017_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_018",
            label = "Stitches",
            hashMale = "mpHeist3_Tat_018_M",
            hashFemale = "mpHeist3_Tat_018_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_019",
            label = "Teddy Bear",
            hashMale = "mpHeist3_Tat_019_M",
            hashFemale = "mpHeist3_Tat_019_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_020",
            label = "UFO",
            hashMale = "mpHeist3_Tat_020_M",
            hashFemale = "mpHeist3_Tat_020_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_021",
            label = "Wanted",
            hashMale = "mpHeist3_Tat_021_M",
            hashFemale = "mpHeist3_Tat_021_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_022",
            label = "Thog's Sword",
            hashMale = "mpHeist3_Tat_022_M",
            hashFemale = "mpHeist3_Tat_022_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_042",
            label = "Hearts",
            hashMale = "mpHeist3_Tat_042_M",
            hashFemale = "mpHeist3_Tat_042_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_043",
            label = "Diamonds",
            hashMale = "mpHeist3_Tat_043_M",
            hashFemale = "mpHeist3_Tat_043_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H3_044",
            label = "Clubs",
            hashMale = "mpHeist3_Tat_044_M",
            hashFemale = "mpHeist3_Tat_044_F",
            zone = "ZONE_HEAD",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_HP_005",
            label = "Beautiful Eye",
            hashMale = "FM_Hip_M_Tat_005",
            hashFemale = "FM_Hip_F_Tat_005",
            zone = "ZONE_HEAD",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_021",
            label = "Geo Fox",
            hashMale = "FM_Hip_M_Tat_021",
            hashFemale = "FM_Hip_F_Tat_021",
            zone = "ZONE_HEAD",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_FX_001",
            label = "Bright Diamond",
            hashMale = "MP_Security_Tat_001_M",
            hashFemale = "MP_Security_Tat_001_F",
            zone = "ZONE_HEAD",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_002",
            label = "Hustle",
            hashMale = "MP_Security_Tat_002_M",
            hashFemale = "MP_Security_Tat_002_F",
            zone = "ZONE_HEAD",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_027",
            label = "Black Widow",
            hashMale = "MP_Security_Tat_027_M",
            hashFemale = "MP_Security_Tat_027_F",
            zone = "ZONE_HEAD",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_SM_011",
            label = "Sinner",
            hashMale = "MP_Smuggler_Tattoo_011_M",
            hashFemale = "MP_Smuggler_Tattoo_011_F",
            zone = "ZONE_HEAD",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_012",
            label = "Thief",
            hashMale = "MP_Smuggler_Tattoo_012_M",
            hashFemale = "MP_Smuggler_Tattoo_012_F",
            zone = "ZONE_HEAD",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_ST_000",
            label = "Stunt Skull",
            hashMale = "MP_MP_Stunt_Tat_000_M",
            hashFemale = "MP_MP_Stunt_Tat_000_F",
            zone = "ZONE_HEAD",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_004",
            label = "Scorpion",
            hashMale = "MP_MP_Stunt_tat_004_M",
            hashFemale = "MP_MP_Stunt_tat_004_F",
            zone = "ZONE_HEAD",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_006",
            label = "Toxic Spider",
            hashMale = "MP_MP_Stunt_tat_006_M",
            hashFemale = "MP_MP_Stunt_tat_006_F",
            zone = "ZONE_HEAD",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_017",
            label = "Bat Wheel",
            hashMale = "MP_MP_Stunt_tat_017_M",
            hashFemale = "MP_MP_Stunt_tat_017_F",
            zone = "ZONE_HEAD",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_042",
            label = "Flaming Quad",
            hashMale = "MP_MP_Stunt_tat_042_M",
            hashFemale = "MP_MP_Stunt_tat_042_F",
            zone = "ZONE_HEAD",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_FM_008",
            label = "Skull",
            hashMale = "FM_Tat_Award_M_000",
            hashFemale = "FM_Tat_Award_F_000",
            zone = "ZONE_HEAD",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_SB_000",
            label = "Live Fast Mono",
            hashMale = "MP_Sum2_Tat_000_M",
            hashFemale = "MP_Sum2_Tat_000_F",
            zone = "ZONE_HEAD",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_001",
            label = "Live Fast Color",
            hashMale = "MP_Sum2_Tat_001_M",
            hashFemale = "MP_Sum2_Tat_001_F",
            zone = "ZONE_HEAD",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_018",
            label = "Branched Skull",
            hashMale = "MP_Sum2_Tat_018_M",
            hashFemale = "MP_Sum2_Tat_018_F",
            zone = "ZONE_HEAD",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_019",
            label = "Scythed Corpse",
            hashMale = "MP_Sum2_Tat_019_M",
            hashFemale = "MP_Sum2_Tat_019_F",
            zone = "ZONE_HEAD",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_020",
            label = "Scythed Corpse & Reaper",
            hashMale = "MP_Sum2_Tat_020_M",
            hashFemale = "MP_Sum2_Tat_020_F",
            zone = "ZONE_HEAD",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_021",
            label = "Third Eye",
            hashMale = "MP_Sum2_Tat_021_M",
            hashFemale = "MP_Sum2_Tat_021_F",
            zone = "ZONE_HEAD",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_022",
            label = "Pierced Third Eye",
            hashMale = "MP_Sum2_Tat_022_M",
            hashFemale = "MP_Sum2_Tat_022_F",
            zone = "ZONE_HEAD",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_023",
            label = "Lip Drip",
            hashMale = "MP_Sum2_Tat_023_M",
            hashFemale = "MP_Sum2_Tat_023_F",
            zone = "ZONE_HEAD",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_024",
            label = "Skin Mask",
            hashMale = "MP_Sum2_Tat_024_M",
            hashFemale = "MP_Sum2_Tat_024_F",
            zone = "ZONE_HEAD",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_025",
            label = "Webbed Scythe",
            hashMale = "MP_Sum2_Tat_025_M",
            hashFemale = "MP_Sum2_Tat_025_F",
            zone = "ZONE_HEAD",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_026",
            label = "Oni Demon",
            hashMale = "MP_Sum2_Tat_026_M",
            hashFemale = "MP_Sum2_Tat_026_F",
            zone = "ZONE_HEAD",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_027",
            label = "Bat Wings",
            hashMale = "MP_Sum2_Tat_027_M",
            hashFemale = "MP_Sum2_Tat_027_F",
            zone = "ZONE_HEAD",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_X6_010",
            label = "Dude",
            hashMale = "MP_Christmas3_Tat_010_M",
            hashFemale = "MP_Christmas3_Tat_010_F",
            zone = "ZONE_HEAD",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_011",
            label = "Fooligan Tribal",
            hashMale = "MP_Christmas3_Tat_011_M",
            hashFemale = "MP_Christmas3_Tat_011_F",
            zone = "ZONE_HEAD",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_012",
            label = "Skull Jester",
            hashMale = "MP_Christmas3_Tat_012_M",
            hashFemale = "MP_Christmas3_Tat_012_F",
            zone = "ZONE_HEAD",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_013",
            label = "Budonk-adonk!",
            hashMale = "MP_Christmas3_Tat_013_M",
            hashFemale = "MP_Christmas3_Tat_013_F",
            zone = "ZONE_HEAD",
            collection = "mpchristmas3_overlays"
        }
    },
    ZONE_LEFT_LEG = {
        {
            name = "TAT_BB_027",
            label = "Tribal Star",
            hashMale = "MP_Bea_M_Lleg_000",
            hashFemale = "",
            zone = "ZONE_LEFT_LEG",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BI_002",
            label = "Rose Tribute",
            hashMale = "MP_MP_Biker_Tat_002_M",
            hashFemale = "MP_MP_Biker_Tat_002_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_015",
            label = "Ride or Die",
            hashMale = "MP_MP_Biker_Tat_015_M",
            hashFemale = "MP_MP_Biker_Tat_015_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_027",
            label = "Bad Luck",
            hashMale = "MP_MP_Biker_Tat_027_M",
            hashFemale = "MP_MP_Biker_Tat_027_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_036",
            label = "Engulfed Skull",
            hashMale = "MP_MP_Biker_Tat_036_M",
            hashFemale = "MP_MP_Biker_Tat_036_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_037",
            label = "Scorched Soul",
            hashMale = "MP_MP_Biker_Tat_037_M",
            hashFemale = "MP_MP_Biker_Tat_037_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_044",
            label = "Ride Free",
            hashMale = "MP_MP_Biker_Tat_044_M",
            hashFemale = "MP_MP_Biker_Tat_044_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_056",
            label = "Bone Cruiser",
            hashMale = "MP_MP_Biker_Tat_056_M",
            hashFemale = "MP_MP_Biker_Tat_056_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_057",
            label = "Laughing Skull",
            hashMale = "MP_MP_Biker_Tat_057_M",
            hashFemale = "MP_MP_Biker_Tat_057_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BUS_F_006",
            label = "Single",
            hashMale = "",
            hashFemale = "MP_Buis_F_LLeg_000",
            zone = "ZONE_LEFT_LEG",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_X2_001",
            label = "Spider Outline",
            hashMale = "MP_Xmas2_M_Tat_001",
            hashFemale = "MP_Xmas2_F_Tat_001",
            zone = "ZONE_LEFT_LEG",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_002",
            label = "Spider Color",
            hashMale = "MP_Xmas2_M_Tat_002",
            hashFemale = "MP_Xmas2_F_Tat_002",
            zone = "ZONE_LEFT_LEG",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_GR_005",
            label = "Patriot Skull",
            hashMale = "MP_Gunrunning_Tattoo_005_M",
            hashFemale = "MP_Gunrunning_Tattoo_005_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_007",
            label = "Stylized Tiger",
            hashMale = "MP_Gunrunning_Tattoo_007_M",
            hashFemale = "MP_Gunrunning_Tattoo_007_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_011",
            label = "Death Skull",
            hashMale = "MP_Gunrunning_Tattoo_011_M",
            hashFemale = "MP_Gunrunning_Tattoo_011_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_023",
            label = "Rose Revolver",
            hashMale = "MP_Gunrunning_Tattoo_023_M",
            hashFemale = "MP_Gunrunning_Tattoo_023_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_H3_032",
            label = "Love Fist",
            hashMale = "mpHeist3_Tat_032_M",
            hashFemale = "mpHeist3_Tat_032_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H4_010",
            label = "Tropical Serpent",
            hashMale = "MP_Heist4_Tat_010_M",
            hashFemale = "MP_Heist4_Tat_010_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_024",
            label = "Pineapple Skull",
            hashMale = "MP_Heist4_Tat_024_M",
            hashFemale = "MP_Heist4_Tat_024_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_025",
            label = "Glow Princess",
            hashMale = "MP_Heist4_Tat_025_M",
            hashFemale = "MP_Heist4_Tat_025_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_028",
            label = "Skull Waters",
            hashMale = "MP_Heist4_Tat_028_M",
            hashFemale = "MP_Heist4_Tat_028_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_029",
            label = "Soundwaves",
            hashMale = "MP_Heist4_Tat_029_M",
            hashFemale = "MP_Heist4_Tat_029_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_HP_009",
            label = "Squares",
            hashMale = "FM_Hip_M_Tat_009",
            hashFemale = "FM_Hip_F_Tat_009",
            zone = "ZONE_LEFT_LEG",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_019",
            label = "Charm",
            hashMale = "FM_Hip_M_Tat_019",
            hashFemale = "FM_Hip_F_Tat_019",
            zone = "ZONE_LEFT_LEG",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_040",
            label = "Black Anchor",
            hashMale = "FM_Hip_M_Tat_040",
            hashFemale = "FM_Hip_F_Tat_040",
            zone = "ZONE_LEFT_LEG",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_S2_029",
            label = "Death Us Do Part",
            hashMale = "MP_LR_Tat_029_M",
            hashFemale = "MP_LR_Tat_029_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mplowrider2_overlays"
        },
        {
            name = "TAT_S1_007",
            label = "LS Serpent",
            hashMale = "MP_LR_Tat_007_M",
            hashFemale = "MP_LR_Tat_007_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_S1_020",
            label = "Presidents",
            hashMale = "MP_LR_Tat_020_M",
            hashFemale = "MP_LR_Tat_020_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_L2_011",
            label = "Cross of Roses",
            hashMale = "MP_LUXE_TAT_011_M",
            hashFemale = "MP_LUXE_TAT_011_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_LX_000",
            label = "Serpent of Death",
            hashMale = "MP_LUXE_TAT_000_M",
            hashFemale = "MP_LUXE_TAT_000_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpluxe_overlays"
        },
        {
            name = "TAT_FX_022",
            label = "LS Smoking Cartridges",
            hashMale = "MP_Security_Tat_022_M",
            hashFemale = "MP_Security_Tat_022_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_023",
            label = "Trust",
            hashMale = "MP_Security_Tat_023_M",
            hashFemale = "MP_Security_Tat_023_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_ST_007",
            label = "Dagger Devil",
            hashMale = "MP_MP_Stunt_tat_007_M",
            hashFemale = "MP_MP_Stunt_tat_007_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_013",
            label = "Dirt Track Hero",
            hashMale = "MP_MP_Stunt_tat_013_M",
            hashFemale = "MP_MP_Stunt_tat_013_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_021",
            label = "Golden Cobra",
            hashMale = "MP_MP_Stunt_tat_021_M",
            hashFemale = "MP_MP_Stunt_tat_021_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_028",
            label = "Quad Goblin",
            hashMale = "MP_MP_Stunt_tat_028_M",
            hashFemale = "MP_MP_Stunt_tat_028_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_031",
            label = "Stunt Jesus",
            hashMale = "MP_MP_Stunt_tat_031_M",
            hashFemale = "MP_MP_Stunt_tat_031_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_VW_013",
            label = "One-armed Bandit",
            hashMale = "MP_Vinewood_Tat_013_M",
            hashFemale = "MP_Vinewood_Tat_013_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_027",
            label = "8-Ball Rose",
            hashMale = "MP_Vinewood_Tat_027_M",
            hashFemale = "MP_Vinewood_Tat_027_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_FM_017",
            label = "Dragon and Dagger",
            hashMale = "FM_Tat_Award_M_009",
            hashFemale = "FM_Tat_Award_F_009",
            zone = "ZONE_LEFT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_209",
            label = "Melting Skull",
            hashMale = "FM_Tat_M_002",
            hashFemale = "FM_Tat_F_002",
            zone = "ZONE_LEFT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_211",
            label = "Dragon Mural",
            hashMale = "FM_Tat_M_008",
            hashFemale = "FM_Tat_F_008",
            zone = "ZONE_LEFT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_222",
            label = "Serpent Skull",
            hashMale = "FM_Tat_M_021",
            hashFemale = "FM_Tat_F_021",
            zone = "ZONE_LEFT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_224",
            label = "Hottie",
            hashMale = "FM_Tat_M_023",
            hashFemale = "FM_Tat_F_023",
            zone = "ZONE_LEFT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_227",
            label = "Smoking Dagger",
            hashMale = "FM_Tat_M_026",
            hashFemale = "FM_Tat_F_026",
            zone = "ZONE_LEFT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_233",
            label = "Faith",
            hashMale = "FM_Tat_M_032",
            hashFemale = "FM_Tat_F_032",
            zone = "ZONE_LEFT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_234",
            label = "Chinese Dragon",
            hashMale = "FM_Tat_M_033",
            hashFemale = "FM_Tat_F_033",
            zone = "ZONE_LEFT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_236",
            label = "Dragon",
            hashMale = "FM_Tat_M_035",
            hashFemale = "FM_Tat_F_035",
            zone = "ZONE_LEFT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_238",
            label = "Grim Reaper",
            hashMale = "FM_Tat_M_037",
            hashFemale = "FM_Tat_F_037",
            zone = "ZONE_LEFT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_SB_053",
            label = "Mobster Skull",
            hashMale = "MP_Sum2_Tat_053_M",
            hashFemale = "MP_Sum2_Tat_053_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_054",
            label = "Wounded Head",
            hashMale = "MP_Sum2_Tat_054_M",
            hashFemale = "MP_Sum2_Tat_054_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_055",
            label = "Stabbed Skull",
            hashMale = "MP_Sum2_Tat_055_M",
            hashFemale = "MP_Sum2_Tat_055_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_056",
            label = "Tiger Blade",
            hashMale = "MP_Sum2_Tat_056_M",
            hashFemale = "MP_Sum2_Tat_056_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_002",
            label = "Cobra Biker",
            hashMale = "MP_Sum2_Tat_002_M",
            hashFemale = "MP_Sum2_Tat_002_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_014",
            label = "Minimal SMG",
            hashMale = "MP_Sum2_Tat_014_M",
            hashFemale = "MP_Sum2_Tat_014_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_015",
            label = "Minimal Advanced Rifle",
            hashMale = "MP_Sum2_Tat_015_M",
            hashFemale = "MP_Sum2_Tat_015_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_016",
            label = "Minimal Sniper Rifle",
            hashMale = "MP_Sum2_Tat_016_M",
            hashFemale = "MP_Sum2_Tat_016_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_032",
            label = "Many-eyed Goat",
            hashMale = "MP_Sum2_Tat_032_M",
            hashFemale = "MP_Sum2_Tat_032_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_X6_009",
            label = "Naughty Snow Globe",
            hashMale = "MP_Christmas3_Tat_009_M",
            hashFemale = "MP_Christmas3_Tat_009_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_034",
            label = "Zombie Head",
            hashMale = "MP_Christmas3_Tat_034_M",
            hashFemale = "MP_Christmas3_Tat_034_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_037",
            label = "Orang-O-Tang Grenade",
            hashMale = "MP_Christmas3_Tat_037_M",
            hashFemale = "MP_Christmas3_Tat_037_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_038",
            label = "Fool",
            hashMale = "MP_Christmas3_Tat_038_M",
            hashFemale = "MP_Christmas3_Tat_038_F",
            zone = "ZONE_LEFT_LEG",
            collection = "mpchristmas3_overlays"
        }
    },
    ZONE_RIGHT_LEG = {
        {
            name = "TAT_BB_025",
            label = "Tribal Tiki Tower",
            hashMale = "MP_Bea_M_Rleg_000",
            hashFemale = "",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_007",
            label = "School of Fish",
            hashMale = "",
            hashFemale = "MP_Bea_F_RLeg_000",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BI_004",
            label = "Dragon's Fury",
            hashMale = "MP_MP_Biker_Tat_004_M",
            hashFemale = "MP_MP_Biker_Tat_004_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_022",
            label = "Western Insignia",
            hashMale = "MP_MP_Biker_Tat_022_M",
            hashFemale = "MP_MP_Biker_Tat_022_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_028",
            label = "Dusk Rider",
            hashMale = "MP_MP_Biker_Tat_028_M",
            hashFemale = "MP_MP_Biker_Tat_028_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_040",
            label = "American Made",
            hashMale = "MP_MP_Biker_Tat_040_M",
            hashFemale = "MP_MP_Biker_Tat_040_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_048",
            label = "STFU",
            hashMale = "MP_MP_Biker_Tat_048_M",
            hashFemale = "MP_MP_Biker_Tat_048_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BUS_F_010",
            label = "Diamond Crown",
            hashMale = "",
            hashFemale = "MP_Buis_F_RLeg_000",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_X2_014",
            label = "Floral Dagger",
            hashMale = "MP_Xmas2_M_Tat_014",
            hashFemale = "MP_Xmas2_F_Tat_014",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_GR_006",
            label = "Combat Skull",
            hashMale = "MP_Gunrunning_Tattoo_006_M",
            hashFemale = "MP_Gunrunning_Tattoo_006_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_026",
            label = "Restless Skull",
            hashMale = "MP_Gunrunning_Tattoo_026_M",
            hashFemale = "MP_Gunrunning_Tattoo_026_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_030",
            label = "Pistol Ace",
            hashMale = "MP_Gunrunning_Tattoo_030_M",
            hashFemale = "MP_Gunrunning_Tattoo_030_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_H3_031",
            label = "Kifflom",
            hashMale = "mpHeist3_Tat_031_M",
            hashFemale = "mpHeist3_Tat_031_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H4_027",
            label = "Skullphones",
            hashMale = "MP_Heist4_Tat_027_M",
            hashFemale = "MP_Heist4_Tat_027_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_HP_038",
            label = "Grub",
            hashMale = "FM_Hip_M_Tat_038",
            hashFemale = "FM_Hip_F_Tat_038",
            zone = "ZONE_RIGHT_LEG",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_042",
            label = "Sparkplug",
            hashMale = "FM_Hip_M_Tat_042",
            hashFemale = "FM_Hip_F_Tat_042",
            zone = "ZONE_RIGHT_LEG",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_S2_030",
            label = "San Andreas Prayer",
            hashMale = "MP_LR_Tat_030_M",
            hashFemale = "MP_LR_Tat_030_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mplowrider2_overlays"
        },
        {
            name = "TAT_S1_017",
            label = "Ink Me",
            hashMale = "MP_LR_Tat_017_M",
            hashFemale = "MP_LR_Tat_017_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_S1_023",
            label = "Dance of Hearts",
            hashMale = "MP_LR_Tat_023_M",
            hashFemale = "MP_LR_Tat_023_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_L2_023",
            label = "Starmetric",
            hashMale = "MP_LUXE_TAT_023_M",
            hashFemale = "MP_LUXE_TAT_023_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_LX_001",
            label = "Elaborate Los Muertos",
            hashMale = "MP_LUXE_TAT_001_M",
            hashFemale = "MP_LUXE_TAT_001_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpluxe_overlays"
        },
        {
            name = "TAT_FX_003",
            label = "Bandana Knife",
            hashMale = "MP_Security_Tat_003_M",
            hashFemale = "MP_Security_Tat_003_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_021",
            label = "Graffiti Skull",
            hashMale = "MP_Security_Tat_021_M",
            hashFemale = "MP_Security_Tat_021_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_SM_020",
            label = "Homeward Bound",
            hashMale = "MP_Smuggler_Tattoo_020_M",
            hashFemale = "MP_Smuggler_Tattoo_020_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_ST_005",
            label = "Demon Spark Plug",
            hashMale = "MP_MP_Stunt_tat_005_M",
            hashFemale = "MP_MP_Stunt_tat_005_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_015",
            label = "Praying Gloves",
            hashMale = "MP_MP_Stunt_tat_015_M",
            hashFemale = "MP_MP_Stunt_tat_015_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_020",
            label = "Piston Angel",
            hashMale = "MP_MP_Stunt_tat_020_M",
            hashFemale = "MP_MP_Stunt_tat_020_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_025",
            label = "Speed Freak",
            hashMale = "MP_MP_Stunt_tat_025_M",
            hashFemale = "MP_MP_Stunt_tat_025_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_032",
            label = "Wheelie Mouse",
            hashMale = "MP_MP_Stunt_tat_032_M",
            hashFemale = "MP_MP_Stunt_tat_032_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_045",
            label = "Severed Hand",
            hashMale = "MP_MP_Stunt_tat_045_M",
            hashFemale = "MP_MP_Stunt_tat_045_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_047",
            label = "Brake Knife",
            hashMale = "MP_MP_Stunt_tat_047_M",
            hashFemale = "MP_MP_Stunt_tat_047_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_VW_020",
            label = "Cash is King",
            hashMale = "MP_Vinewood_Tat_020_M",
            hashFemale = "MP_Vinewood_Tat_020_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_FM_014",
            label = "Skull and Sword",
            hashMale = "FM_Tat_Award_M_006",
            hashFemale = "FM_Tat_Award_F_006",
            zone = "ZONE_RIGHT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_210",
            label = "The Warrior",
            hashMale = "FM_Tat_M_007",
            hashFemale = "FM_Tat_F_007",
            zone = "ZONE_RIGHT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_212",
            label = "Tribal",
            hashMale = "FM_Tat_M_017",
            hashFemale = "FM_Tat_F_017",
            zone = "ZONE_RIGHT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_223",
            label = "Fiery Dragon",
            hashMale = "FM_Tat_M_022",
            hashFemale = "FM_Tat_F_022",
            zone = "ZONE_RIGHT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_240",
            label = "Broken Skull",
            hashMale = "FM_Tat_M_039",
            hashFemale = "FM_Tat_F_039",
            zone = "ZONE_RIGHT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_241",
            label = "Flaming Skull",
            hashMale = "FM_Tat_M_040",
            hashFemale = "FM_Tat_F_040",
            zone = "ZONE_RIGHT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_243",
            label = "Flaming Scorpion",
            hashMale = "FM_Tat_M_042",
            hashFemale = "FM_Tat_F_042",
            zone = "ZONE_RIGHT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_244",
            label = "Indian Ram",
            hashMale = "FM_Tat_M_043",
            hashFemale = "FM_Tat_F_043",
            zone = "ZONE_RIGHT_LEG",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_SB_050",
            label = "Gold Gun",
            hashMale = "MP_Sum2_Tat_050_M",
            hashFemale = "MP_Sum2_Tat_050_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_051",
            label = "Blue Serpent",
            hashMale = "MP_Sum2_Tat_051_M",
            hashFemale = "MP_Sum2_Tat_051_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_052",
            label = "Night Demon",
            hashMale = "MP_Sum2_Tat_052_M",
            hashFemale = "MP_Sum2_Tat_052_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_033",
            label = "Three-eyed Demon",
            hashMale = "MP_Sum2_Tat_033_M",
            hashFemale = "MP_Sum2_Tat_033_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_034",
            label = "Smoldering Reaper",
            hashMale = "MP_Sum2_Tat_034_M",
            hashFemale = "MP_Sum2_Tat_034_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_017",
            label = "Skull Grenade",
            hashMale = "MP_Sum2_Tat_017_M",
            hashFemale = "MP_Sum2_Tat_017_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_X6_008",
            label = "Gingerbread Steed",
            hashMale = "MP_Christmas3_Tat_008_M",
            hashFemale = "MP_Christmas3_Tat_008_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_035",
            label = "Erupting Skeleton",
            hashMale = "MP_Christmas3_Tat_035_M",
            hashFemale = "MP_Christmas3_Tat_035_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_036",
            label = "B'Donk Now Crank It Later",
            hashMale = "MP_Christmas3_Tat_036_M",
            hashFemale = "MP_Christmas3_Tat_036_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_039",
            label = "Jack Me",
            hashMale = "MP_Christmas3_Tat_039_M",
            hashFemale = "MP_Christmas3_Tat_039_F",
            zone = "ZONE_RIGHT_LEG",
            collection = "mpchristmas3_overlays"
        }
    },
    ZONE_RIGHT_ARM = {
        {
            name = "TAT_BB_026",
            label = "Tribal Sun",
            hashMale = "MP_Bea_M_RArm_000",
            hashFemale = "",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_030",
            label = "Vespucci Beauty",
            hashMale = "MP_Bea_M_RArm_001",
            hashFemale = "",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BB_015",
            label = "Tribal Fish",
            hashMale = "",
            hashFemale = "MP_Bea_F_RArm_001",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpbeach_overlays"
        },
        {
            name = "TAT_BI_007",
            label = "Swooping Eagle",
            hashMale = "MP_MP_Biker_Tat_007_M",
            hashFemale = "MP_MP_Biker_Tat_007_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_014",
            label = "Lady Mortality",
            hashMale = "MP_MP_Biker_Tat_014_M",
            hashFemale = "MP_MP_Biker_Tat_014_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_033",
            label = "Eagle Emblem",
            hashMale = "MP_MP_Biker_Tat_033_M",
            hashFemale = "MP_MP_Biker_Tat_033_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_042",
            label = "Grim Rider",
            hashMale = "MP_MP_Biker_Tat_042_M",
            hashFemale = "MP_MP_Biker_Tat_042_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_046",
            label = "Skull Chain",
            hashMale = "MP_MP_Biker_Tat_046_M",
            hashFemale = "MP_MP_Biker_Tat_046_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_047",
            label = "Snake Bike",
            hashMale = "MP_MP_Biker_Tat_047_M",
            hashFemale = "MP_MP_Biker_Tat_047_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_049",
            label = "These Colors Don't Run",
            hashMale = "MP_MP_Biker_Tat_049_M",
            hashFemale = "MP_MP_Biker_Tat_049_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BI_054",
            label = "Mum",
            hashMale = "MP_MP_Biker_Tat_054_M",
            hashFemale = "MP_MP_Biker_Tat_054_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpbiker_overlays"
        },
        {
            name = "TAT_BUS_009",
            label = "Dollar Skull",
            hashMale = "MP_Buis_M_RightArm_000",
            hashFemale = "",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_010",
            label = "Green",
            hashMale = "MP_Buis_M_RightArm_001",
            hashFemale = "",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_BUS_F_009",
            label = "Dollar Sign",
            hashMale = "",
            hashFemale = "MP_Buis_F_RArm_000",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpbusiness_overlays"
        },
        {
            name = "TAT_H27_006",
            label = "Medusa",
            hashMale = "MP_Christmas2017_Tattoo_006_M",
            hashFemale = "MP_Christmas2017_Tattoo_006_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_012",
            label = "Tiger Headdress",
            hashMale = "MP_Christmas2017_Tattoo_012_M",
            hashFemale = "MP_Christmas2017_Tattoo_012_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_014",
            label = "Celtic Band",
            hashMale = "MP_Christmas2017_Tattoo_014_M",
            hashFemale = "MP_Christmas2017_Tattoo_014_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_017",
            label = "Feather Sleeve",
            hashMale = "MP_Christmas2017_Tattoo_017_M",
            hashFemale = "MP_Christmas2017_Tattoo_017_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_018",
            label = "Muscle Tear",
            hashMale = "MP_Christmas2017_Tattoo_018_M",
            hashFemale = "MP_Christmas2017_Tattoo_018_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_023",
            label = "Samurai Tallship",
            hashMale = "MP_Christmas2017_Tattoo_023_M",
            hashFemale = "MP_Christmas2017_Tattoo_023_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_H27_028",
            label = "Spartan Mural",
            hashMale = "MP_Christmas2017_Tattoo_028_M",
            hashFemale = "MP_Christmas2017_Tattoo_028_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas2017_overlays"
        },
        {
            name = "TAT_X2_003",
            label = "Snake Outline",
            hashMale = "MP_Xmas2_M_Tat_003",
            hashFemale = "MP_Xmas2_F_Tat_003",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_004",
            label = "Snake Shaded",
            hashMale = "MP_Xmas2_M_Tat_004",
            hashFemale = "MP_Xmas2_F_Tat_004",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_008",
            label = "Death Before Dishonor",
            hashMale = "MP_Xmas2_M_Tat_008",
            hashFemale = "MP_Xmas2_F_Tat_008",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_022",
            label = "You're Next Outline",
            hashMale = "MP_Xmas2_M_Tat_022",
            hashFemale = "MP_Xmas2_F_Tat_022",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_023",
            label = "You're Next Color",
            hashMale = "MP_Xmas2_M_Tat_023",
            hashFemale = "MP_Xmas2_F_Tat_023",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_026",
            label = "Fuck Luck Outline",
            hashMale = "MP_Xmas2_M_Tat_026",
            hashFemale = "MP_Xmas2_F_Tat_026",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_X2_027",
            label = "Fuck Luck Color",
            hashMale = "MP_Xmas2_M_Tat_027",
            hashFemale = "MP_Xmas2_F_Tat_027",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas2_overlays"
        },
        {
            name = "TAT_GR_002",
            label = "Grenade",
            hashMale = "MP_Gunrunning_Tattoo_002_M",
            hashFemale = "MP_Gunrunning_Tattoo_002_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_021",
            label = "Have a Nice Day",
            hashMale = "MP_Gunrunning_Tattoo_021_M",
            hashFemale = "MP_Gunrunning_Tattoo_021_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_GR_024",
            label = "Combat Reaper",
            hashMale = "MP_Gunrunning_Tattoo_024_M",
            hashFemale = "MP_Gunrunning_Tattoo_024_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpgunrunning_overlays"
        },
        {
            name = "TAT_H3_034",
            label = "LS Monogram",
            hashMale = "mpHeist3_Tat_034_M",
            hashFemale = "mpHeist3_Tat_034_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpheist3_overlays"
        },
        {
            name = "TAT_H4_000",
            label = "Headphone Splat",
            hashMale = "MP_Heist4_Tat_000_M",
            hashFemale = "MP_Heist4_Tat_000_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_001",
            label = "Tropical Dude",
            hashMale = "MP_Heist4_Tat_001_M",
            hashFemale = "MP_Heist4_Tat_001_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_002",
            label = "Jellyfish Shades",
            hashMale = "MP_Heist4_Tat_002_M",
            hashFemale = "MP_Heist4_Tat_002_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_003",
            label = "Lighthouse",
            hashMale = "MP_Heist4_Tat_003_M",
            hashFemale = "MP_Heist4_Tat_003_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_005",
            label = "LSUR",
            hashMale = "MP_Heist4_Tat_005_M",
            hashFemale = "MP_Heist4_Tat_005_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_006",
            label = "Music Locker",
            hashMale = "MP_Heist4_Tat_006_M",
            hashFemale = "MP_Heist4_Tat_006_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_007",
            label = "Skeleton DJ",
            hashMale = "MP_Heist4_Tat_007_M",
            hashFemale = "MP_Heist4_Tat_007_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_008",
            label = "Smiley Glitch",
            hashMale = "MP_Heist4_Tat_008_M",
            hashFemale = "MP_Heist4_Tat_008_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_011",
            label = "Soulwax",
            hashMale = "MP_Heist4_Tat_011_M",
            hashFemale = "MP_Heist4_Tat_011_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_012",
            label = "Still Slipping",
            hashMale = "MP_Heist4_Tat_012_M",
            hashFemale = "MP_Heist4_Tat_012_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_026",
            label = "Shark Water",
            hashMale = "MP_Heist4_Tat_026_M",
            hashFemale = "MP_Heist4_Tat_026_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_031",
            label = "Octopus Shades",
            hashMale = "MP_Heist4_Tat_031_M",
            hashFemale = "MP_Heist4_Tat_031_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_H4_032",
            label = "K.U.L.T. 99.1 FM",
            hashMale = "MP_Heist4_Tat_032_M",
            hashFemale = "MP_Heist4_Tat_032_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpheist4_overlays"
        },
        {
            name = "TAT_HP_001",
            label = "Single Arrow",
            hashMale = "FM_Hip_M_Tat_001",
            hashFemale = "FM_Hip_F_Tat_001",
            zone = "ZONE_RIGHT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_004",
            label = "Bone",
            hashMale = "FM_Hip_M_Tat_004",
            hashFemale = "FM_Hip_F_Tat_004",
            zone = "ZONE_RIGHT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_008",
            label = "Cube",
            hashMale = "FM_Hip_M_Tat_008",
            hashFemale = "FM_Hip_F_Tat_008",
            zone = "ZONE_RIGHT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_010",
            label = "Horseshoe",
            hashMale = "FM_Hip_M_Tat_010",
            hashFemale = "FM_Hip_F_Tat_010",
            zone = "ZONE_RIGHT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_014",
            label = "Spray Can",
            hashMale = "FM_Hip_M_Tat_014",
            hashFemale = "FM_Hip_F_Tat_014",
            zone = "ZONE_RIGHT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_017",
            label = "Eye Triangle",
            hashMale = "FM_Hip_M_Tat_017",
            hashFemale = "FM_Hip_F_Tat_017",
            zone = "ZONE_RIGHT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_018",
            label = "Origami",
            hashMale = "FM_Hip_M_Tat_018",
            hashFemale = "FM_Hip_F_Tat_018",
            zone = "ZONE_RIGHT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_020",
            label = "Geo Pattern",
            hashMale = "FM_Hip_M_Tat_020",
            hashFemale = "FM_Hip_F_Tat_020",
            zone = "ZONE_RIGHT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_022",
            label = "Pencil",
            hashMale = "FM_Hip_M_Tat_022",
            hashFemale = "FM_Hip_F_Tat_022",
            zone = "ZONE_RIGHT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_023",
            label = "Smiley",
            hashMale = "FM_Hip_M_Tat_023",
            hashFemale = "FM_Hip_F_Tat_023",
            zone = "ZONE_RIGHT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_036",
            label = "Shapes",
            hashMale = "FM_Hip_M_Tat_036",
            hashFemale = "FM_Hip_F_Tat_036",
            zone = "ZONE_RIGHT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_044",
            label = "Triangle Black",
            hashMale = "FM_Hip_M_Tat_044",
            hashFemale = "FM_Hip_F_Tat_044",
            zone = "ZONE_RIGHT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_HP_045",
            label = "Mesh Band",
            hashMale = "FM_Hip_M_Tat_045",
            hashFemale = "FM_Hip_F_Tat_045",
            zone = "ZONE_RIGHT_ARM",
            collection = "mphipster_overlays"
        },
        {
            name = "TAT_IE_003",
            label = "Mechanical Sleeve",
            hashMale = "MP_MP_ImportExport_Tat_003_M",
            hashFemale = "MP_MP_ImportExport_Tat_003_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpimportexport_overlays"
        },
        {
            name = "TAT_IE_005",
            label = "Dialed In",
            hashMale = "MP_MP_ImportExport_Tat_005_M",
            hashFemale = "MP_MP_ImportExport_Tat_005_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpimportexport_overlays"
        },
        {
            name = "TAT_IE_006",
            label = "Engulfed Block",
            hashMale = "MP_MP_ImportExport_Tat_006_M",
            hashFemale = "MP_MP_ImportExport_Tat_006_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpimportexport_overlays"
        },
        {
            name = "TAT_IE_007",
            label = "Drive Forever",
            hashMale = "MP_MP_ImportExport_Tat_007_M",
            hashFemale = "MP_MP_ImportExport_Tat_007_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpimportexport_overlays"
        },
        {
            name = "TAT_S2_003",
            label = "Lady Vamp",
            hashMale = "MP_LR_Tat_003_M",
            hashFemale = "MP_LR_Tat_003_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mplowrider2_overlays"
        },
        {
            name = "TAT_S2_028",
            label = "Loving Los Muertos",
            hashMale = "MP_LR_Tat_028_M",
            hashFemale = "MP_LR_Tat_028_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mplowrider2_overlays"
        },
        {
            name = "TAT_S2_035",
            label = "Black Tears",
            hashMale = "MP_LR_Tat_035_M",
            hashFemale = "MP_LR_Tat_035_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mplowrider2_overlays"
        },
        {
            name = "TAT_S1_015",
            label = "Seductress",
            hashMale = "MP_LR_Tat_015_M",
            hashFemale = "MP_LR_Tat_015_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mplowrider_overlays"
        },
        {
            name = "TAT_L2_010",
            label = "Intrometric",
            hashMale = "MP_LUXE_TAT_010_M",
            hashFemale = "MP_LUXE_TAT_010_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_L2_017",
            label = "Heavenly Deity",
            hashMale = "MP_LUXE_TAT_017_M",
            hashFemale = "MP_LUXE_TAT_017_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_L2_026",
            label = "Floral Print",
            hashMale = "MP_LUXE_TAT_026_M",
            hashFemale = "MP_LUXE_TAT_026_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_L2_030",
            label = "Geometric Design",
            hashMale = "MP_LUXE_TAT_030_M",
            hashFemale = "MP_LUXE_TAT_030_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpluxe2_overlays"
        },
        {
            name = "TAT_LX_004",
            label = "Floral Raven",
            hashMale = "MP_LUXE_TAT_004_M",
            hashFemale = "MP_LUXE_TAT_004_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpluxe_overlays"
        },
        {
            name = "TAT_LX_013",
            label = "Mermaid Harpist",
            hashMale = "MP_LUXE_TAT_013_M",
            hashFemale = "MP_LUXE_TAT_013_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpluxe_overlays"
        },
        {
            name = "TAT_LX_019",
            label = "Geisha Bloom",
            hashMale = "MP_LUXE_TAT_019_M",
            hashFemale = "MP_LUXE_TAT_019_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpluxe_overlays"
        },
        {
            name = "TAT_FX_000",
            label = "Hood Skeleton",
            hashMale = "MP_Security_Tat_000_M",
            hashFemale = "MP_Security_Tat_000_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_005",
            label = "Peacock",
            hashMale = "MP_Security_Tat_005_M",
            hashFemale = "MP_Security_Tat_005_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_007",
            label = "Ballas 4 Life",
            hashMale = "MP_Security_Tat_007_M",
            hashFemale = "MP_Security_Tat_007_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_009",
            label = "Ascension",
            hashMale = "MP_Security_Tat_009_M",
            hashFemale = "MP_Security_Tat_009_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_012",
            label = "Zombie Rhymes",
            hashMale = "MP_Security_Tat_012_M",
            hashFemale = "MP_Security_Tat_012_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_FX_020",
            label = "Dog Fist",
            hashMale = "MP_Security_Tat_020_M",
            hashFemale = "MP_Security_Tat_020_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsecurity_overlays"
        },
        {
            name = "TAT_SM_001",
            label = "Crackshot",
            hashMale = "MP_Smuggler_Tattoo_001_M",
            hashFemale = "MP_Smuggler_Tattoo_001_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_005",
            label = "Mutiny",
            hashMale = "MP_Smuggler_Tattoo_005_M",
            hashFemale = "MP_Smuggler_Tattoo_005_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_SM_023",
            label = "Stylized Kraken",
            hashMale = "MP_Smuggler_Tattoo_023_M",
            hashFemale = "MP_Smuggler_Tattoo_023_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsmuggler_overlays"
        },
        {
            name = "TAT_ST_003",
            label = "Poison Wrench",
            hashMale = "MP_MP_Stunt_tat_003_M",
            hashFemale = "MP_MP_Stunt_tat_003_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_009",
            label = "Arachnid of Death",
            hashMale = "MP_MP_Stunt_tat_009_M",
            hashFemale = "MP_MP_Stunt_tat_009_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_010",
            label = "Grave Vulture",
            hashMale = "MP_MP_Stunt_tat_010_M",
            hashFemale = "MP_MP_Stunt_tat_010_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_016",
            label = "Coffin Racer",
            hashMale = "MP_MP_Stunt_tat_016_M",
            hashFemale = "MP_MP_Stunt_tat_016_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_036",
            label = "Biker Stallion",
            hashMale = "MP_MP_Stunt_tat_036_M",
            hashFemale = "MP_MP_Stunt_tat_036_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_038",
            label = "One Down Five Up",
            hashMale = "MP_MP_Stunt_tat_038_M",
            hashFemale = "MP_MP_Stunt_tat_038_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_ST_049",
            label = "Seductive Mechanic",
            hashMale = "MP_MP_Stunt_tat_049_M",
            hashFemale = "MP_MP_Stunt_tat_049_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpstunt_overlays"
        },
        {
            name = "TAT_VW_004",
            label = "Lady Luck",
            hashMale = "MP_Vinewood_Tat_004_M",
            hashFemale = "MP_Vinewood_Tat_004_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_018",
            label = "The Gambler's Life",
            hashMale = "MP_Vinewood_Tat_018_M",
            hashFemale = "MP_Vinewood_Tat_018_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_025",
            label = "Queen of Roses",
            hashMale = "MP_Vinewood_Tat_025_M",
            hashFemale = "MP_Vinewood_Tat_025_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_VW_028",
            label = "Skull & Aces",
            hashMale = "MP_Vinewood_Tat_028_M",
            hashFemale = "MP_Vinewood_Tat_028_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpvinewood_overlays"
        },
        {
            name = "TAT_FM_010",
            label = "Grim Reaper Smoking Gun",
            hashMale = "FM_Tat_Award_M_002",
            hashFemale = "FM_Tat_Award_F_002",
            zone = "ZONE_RIGHT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_018",
            label = "Ride or Die",
            hashMale = "FM_Tat_Award_M_010",
            hashFemale = "FM_Tat_Award_F_010",
            zone = "ZONE_RIGHT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_204",
            label = "Brotherhood",
            hashMale = "FM_Tat_M_000",
            hashFemale = "FM_Tat_F_000",
            zone = "ZONE_RIGHT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_205",
            label = "Dragons",
            hashMale = "FM_Tat_M_001",
            hashFemale = "FM_Tat_F_001",
            zone = "ZONE_RIGHT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_206",
            label = "Dragons and Skull",
            hashMale = "FM_Tat_M_003",
            hashFemale = "FM_Tat_F_003",
            zone = "ZONE_RIGHT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_207",
            label = "Flower Mural",
            hashMale = "FM_Tat_M_014",
            hashFemale = "FM_Tat_F_014",
            zone = "ZONE_RIGHT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_208",
            label = "Serpent Skull",
            hashMale = "FM_Tat_M_018",
            hashFemale = "FM_Tat_F_018",
            zone = "ZONE_RIGHT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_228",
            label = "Virgin Mary",
            hashMale = "FM_Tat_M_027",
            hashFemale = "FM_Tat_F_027",
            zone = "ZONE_RIGHT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_229",
            label = "Mermaid",
            hashMale = "FM_Tat_M_028",
            hashFemale = "FM_Tat_F_028",
            zone = "ZONE_RIGHT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_239",
            label = "Dagger",
            hashMale = "FM_Tat_M_038",
            hashFemale = "FM_Tat_F_038",
            zone = "ZONE_RIGHT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_FM_247",
            label = "Lion",
            hashMale = "FM_Tat_M_047",
            hashFemale = "FM_Tat_F_047",
            zone = "ZONE_RIGHT_ARM",
            collection = "multiplayer_overlays"
        },
        {
            name = "TAT_SB_011",
            label = "Nothing Mini About It",
            hashMale = "MP_Sum2_Tat_011_M",
            hashFemale = "MP_Sum2_Tat_011_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_012",
            label = "Snake Revolver",
            hashMale = "MP_Sum2_Tat_012_M",
            hashFemale = "MP_Sum2_Tat_012_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_013",
            label = "Weapon Sleeve",
            hashMale = "MP_Sum2_Tat_013_M",
            hashFemale = "MP_Sum2_Tat_013_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_030",
            label = "Centipede",
            hashMale = "MP_Sum2_Tat_030_M",
            hashFemale = "MP_Sum2_Tat_030_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_031",
            label = "Fleshy Eye",
            hashMale = "MP_Sum2_Tat_031_M",
            hashFemale = "MP_Sum2_Tat_031_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_045",
            label = "Armored Arm",
            hashMale = "MP_Sum2_Tat_045_M",
            hashFemale = "MP_Sum2_Tat_045_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_046",
            label = "Demon Smile",
            hashMale = "MP_Sum2_Tat_046_M",
            hashFemale = "MP_Sum2_Tat_046_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_047",
            label = "Angel & Devil",
            hashMale = "MP_Sum2_Tat_047_M",
            hashFemale = "MP_Sum2_Tat_047_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_SB_048",
            label = "Death Is Certain",
            hashMale = "MP_Sum2_Tat_048_M",
            hashFemale = "MP_Sum2_Tat_048_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpsum2_overlays"
        },
        {
            name = "TAT_X6_002",
            label = "Skull Bauble",
            hashMale = "MP_Christmas3_Tat_002_M",
            hashFemale = "MP_Christmas3_Tat_002_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_003",
            label = "Bony Snowman",
            hashMale = "MP_Christmas3_Tat_003_M",
            hashFemale = "MP_Christmas3_Tat_003_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_027",
            label = "Orang-O-Tang Dude",
            hashMale = "MP_Christmas3_Tat_027_M",
            hashFemale = "MP_Christmas3_Tat_027_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_029",
            label = "Orang-O-Tang Gray",
            hashMale = "MP_Christmas3_Tat_029_M",
            hashFemale = "MP_Christmas3_Tat_029_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_031",
            label = "Sailor Fuku Killer",
            hashMale = "MP_Christmas3_Tat_031_M",
            hashFemale = "MP_Christmas3_Tat_031_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas3_overlays"
        },
        {
            name = "TAT_X6_032",
            label = "Fooligan",
            hashMale = "MP_Christmas3_Tat_032_M",
            hashFemale = "MP_Christmas3_Tat_032_F",
            zone = "ZONE_RIGHT_ARM",
            collection = "mpchristmas3_overlays"
        }
    },
}

Skin.TattosIndexTranslator = {
    [1] = "ZONE_HEAD",
    [2] = "ZONE_TORSO",
    [3] = "ZONE_RIGHT_ARM",
    [4] = "ZONE_LEFT_ARM",
    [5] = "ZONE_RIGHT_LEG",
    [6] = "ZONE_LEFT_LEG",
}