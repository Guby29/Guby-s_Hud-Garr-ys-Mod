resource.AddFile("resource/fonts/Roboto-Bold.ttf")
surface.CreateFont("Default", {
    font = "Roboto",
    size = ScrW() * 0.02,
    weight = 600,
    antialiasing = true
})

hook.Add("Initialize", "NO_PROPS_PROPERTY", function()
    hook.Remove("HUDPaint", "FPP_HUDPaint")
end)



hook.Add("HUDPaint", "guby_hud", function()
    local health = LocalPlayer():Health()
    local armor = LocalPlayer():Armor()
    local money = LocalPlayer():getDarkRPVar("money")
    local energy = LocalPlayer():getDarkRPVar("energy")
    local job = LocalPlayer():getDarkRPVar("job")

    -- Debut Hud Minitions


    if ! LocalPlayer():Alive() then return end
    if not IsValid(LocalPlayer():GetActiveWeapon()) then return end

    if LocalPlayer():GetActiveWeapon():Clip1() ~= -1 then
        surface.SetDrawColor(Color(75, 75, 75, 255))
        surface.SetTexture(surface.GetTextureID("gui/gradient"))
        surface.DrawTexturedRectRotated(ScrW() * 0.92, ScrH() * 0.95, ScrW() * 0.15, ScrW() * 0.05, 180)
        draw.SimpleText(LocalPlayer():GetActiveWeapon():Clip1() ..
            "/" .. LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "Default",
            ScrW() * 0.95, ScrH() - 52, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Ammo :", "Default", ScrW() * 0.89, ScrH() - 52, Color(255, 255, 255), TEXT_ALIGN_CENTER,
            TEXT_ALIGN_CENTER)
        surface.SetMaterial(Material("materials/guby_hud/ammo.png"))
    end

    -- Fin hud munitions

    -- conditions :

    if (health > 999) then
        health = "999+"
    end

    if (health <= 15) then
        draw.RoundedBox(0, 0, ScrH() * 0, ScrW() * 1, ScrH() * 1, Color(136, 0, 27, 90))
    end

    -- Dessin du HUD

    surface.SetDrawColor(Color(75, 75, 75, 255))
    surface.SetTexture(surface.GetTextureID("gui/gradient"))
    surface.DrawTexturedRect(0, ScrH() * 0.92, ScrW() * 0.5, ScrH() * 0.075)

    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(Material("materials/guby_hud/heart.png"))
    surface.DrawTexturedRect(ScrW() * 0.01, ScrH() * 0.93, ScrW() * 0.03, ScrW() * 0.03)
    draw.SimpleText(health, "Default", ScrW() * 0.045, ScrH() * 0.938, Color(255, 255, 255, 255))

    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(Material("materials/guby_hud/gilet.png"))
    surface.DrawTexturedRect(ScrW() * 0.08, ScrH() * 0.93, ScrW() * 0.03, ScrW() * 0.03)
    draw.SimpleText(armor, "Default", ScrW() * 0.11, ScrH() * 0.938, Color(255, 255, 255, 255))

    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(Material("materials/guby_hud/food.png"))
    surface.DrawTexturedRect(ScrW() * 0.15, ScrH() * 0.93, ScrW() * 0.03, ScrW() * 0.03)
    draw.SimpleText(energy, "Default", ScrW() * 0.18, ScrH() * 0.938, Color(255, 255, 255, 255))

    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(Material("materials/guby_hud/wallet.png"))
    surface.DrawTexturedRect(ScrW() * 0.22, ScrH() * 0.93, ScrW() * 0.03, ScrW() * 0.03)
    local moneyFormatted = FormatMoney(tostring(money))
    draw.SimpleText("$" .. moneyFormatted, "Default", ScrW() * 0.25, ScrH() * 0.938, Color(255, 255, 255, 255))

    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(Material("materials/guby_hud/malette.png"))
    surface.DrawTexturedRect(ScrW() * 0.31, ScrH() * 0.93, ScrW() * 0.03, ScrW() * 0.03)
    draw.SimpleText(job, "Default", ScrW() * 0.34, ScrH() * 0.938, Color(255, 255, 255, 255))
end)


function FormatMoney(text)
    if text == nil then return "0" end
    if string.len(text) <= 3 then
        return text
    elseif string.len(text) == 4 then
        if string.match(string.sub(text, 2, 2), "0") then
            return string.sub(text, 0, 1) .. "k";
        else
            return string.sub(text, 1, 1) .. "," .. string.sub(text, 2, 2) .. "k";
        end
    elseif string.len(text) == 5 then
        if string.match(string.sub(text, 3, 3), "0") then
            return string.sub(text, 0, 2) .. "k";
        else
            return string.sub(text, 0, 2) .. "," .. string.sub(text, 3, 3) .. "k";
        end
    elseif string.len(text) == 6 then
        if string.match(string.sub(text, 4, 4), "0") then
            return string.sub(text, 0, 3) .. "k";
        else
            return string.sub(text, 0, 3) .. "," .. string.sub(text, 4, 4) .. "k";
        end
    elseif string.len(text) == 7 then
        if string.match(string.sub(text, 2, 2), "0") then
            if tonumber(string.sub(text, 0, 1)) > 1 then
                return string.sub(text, 0, 1) .. "M";
            else
                return string.sub(text, 0, 1) .. "M";
            end
        else
            if tonumber(string.sub(text, 0, 1)) > 1 then
                return string.sub(text, 0, 1) .. "," .. string.sub(text, 1, 2) .. "M";
            else
                return string.sub(text, 0, 1) .. "," .. string.sub(text, 1, 2) .. "M";
            end
        end
    elseif string.len(text) == 8 then
        if string.match(string.sub(text, 3, 3), "0") then
            return string.sub(text, 0, 2) .. "M";
        else
            return string.sub(text, 0, 2) .. "," .. string.sub(text, 3, 3) .. "M";
        end
    elseif string.len(text) == 9 then
        if string.match(string.sub(text, 4, 4), "0") then
            return string.sub(text, 0, 3) .. "M";
        else
            return string.sub(text, 0, 3) .. "," .. string.sub(text, 4, 4) .. "M";
        end
    elseif string.len(text) == 10 then
        if string.match(string.sub(text, 2, 2), "0") then
            if tonumber(string.sub(text, 0, 1)) > 1 then
                return string.sub(text, 0, 1) .. "B";
            else
                return string.sub(text, 0, 1) .. "B";
            end
        else
            if tonumber(string.sub(text, 0, 1)) > 1 then
                return string.sub(text, 0, 1) .. "," .. string.sub(text, 2, 2) .. "B";
            else
                return string.sub(text, 0, 1) .. "," .. string.sub(text, 2, 2) .. "B";
            end
        end
    else
        return text
    end
end

local HideElement = {
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true,

    ["DarkRP_HUD"] = true,
    ["DarkRP_EntityDisplay"] = true,
    ["DarkRP_LocalPlayerHUD"] = true,
    ["DarkRP_Hungermod"] = false,
    ["DarkRP_Agenda"] = true,
    ["DarkRP_LockdownHUD"] = true,
    ["DarkRP_ArrestedHUD"] = true,
    ["DarkRP_ChatReceivers"] = true,
}

hook.Add("HUDShouldDraw", "mTxServ:ShouldDraw", function(name)
    if HideElement[name] then return false end
end)
