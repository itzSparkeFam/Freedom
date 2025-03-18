local sequentalId = -1

local function setSequentalInvoiceId()
    local recentInvoice = MySQL.single.await('SELECT id FROM tgg_billing_invoices ORDER BY id DESC LIMIT 1')

    -- If the table is empty, set the sequentalId to 1
    if recentInvoice == nil then
        sequentalId = 0

        return
    end

    sequentalId = recentInvoice.id
end

function GenerateSequentalUUID()
    if sequentalId == -1 then
        setSequentalInvoiceId()
    end

    sequentalId = sequentalId + 1

    -- Get the length of the UUID prefix from the configuration
    local prefix = Config.UUIDPrefix
    local prefixLength = string.len(prefix)

    -- Calculate the number of random digits needed to fill between the prefix and the index
    local totalLength = 14 -- Total length of the UUID
    local indexLength = string.len(tostring(sequentalId))
    local randomDigitsNeeded = totalLength - prefixLength - indexLength

    -- Generate the random number padding string
    local randomNumberPadding = ""
    for _ = 1, randomDigitsNeeded do
        randomNumberPadding = randomNumberPadding .. math.random(0, 9) -- Concatenate random digits
    end

    -- Concatenate prefix, index, and random number padding to form the UUID
    return prefix .. sequentalId .. randomNumberPadding
end
