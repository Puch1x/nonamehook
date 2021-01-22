print("XX   XX XX   XX XX   XX")
print("XXX  XX XXX  XX XX   XX")
print("XXXX XX XXXX XX XXXXXXX")
print("XXXXXXX XXXXXXX XXXXXXX")
print("XX XXXX XX XXXX XX   XX")
print("XX  XXX XX  XXX XX   XX")
print("XX   XX XX   XX XX   XX")
print("NoNamehook loaded...") --by Puchi--

local dont_update = false
local version_number = "1.1.1"
local updated = false
local github_ver_num = http.Get("https://raw.githubusercontent.com/Puch1x/nonamehook/main/version?token=AOFTWAT4QAEPJLJL4NFFCJLABMOGU")

if version_number ~= string.gsub(github_ver_num, "\n", "") and not dont_update then
    updated = true
    local github_file = http.Get("https://raw.githubusercontent.com/Puch1x/nonamehook/main/nonamehook.lua?token=AOFTWATMLU3VI7GMWWXW3QLABMO5O")
    local curren_file = file.Open(GetScriptName(), "w")
    curren_file:Write(github_file)
    curren_file:Close()
end


--refs and gui elements--
local window = gui.Window("nonamehook.window", "NoNamehook", 150, 150, 310, 600)
local group = gui.Groupbox(window, "version 1.0", 5, 10, 300, 235)
local category = gui.Combobox(group, "nonamehook.category", "category", "legit", "semirage", "rage", "viewmodel changer", "fog editor", "misc")


    --legit category--
local legitesp = gui.Checkbox(group, "nonamehook.legitesp", "esp toggle", 0)
local legitespmulti = gui.Multibox(group, "esp options")
local legitespmultiopt1 = gui.Checkbox(legitespmulti, "nonamehook.legitespmultiopt1", "name", 0)
local legitespmultiopt2 = gui.Checkbox(legitespmulti, "nonamehook.legitespmultiopt2", "health", 0)
local legitespmultiopt3 = gui.Checkbox(legitespmulti, "nonamehook.legitespmultiopt3", "weapon", 0)
local legitkeybox = gui.Keybox(group, "nonamehook.legitkeybox", "esp hotkey", 67)
local legitindicators = gui.Checkbox(group, "nonamehook.legitindicators", "legit indicators", 0)
local legitindicatorscolor = gui.ColorPicker(group, "nonamehook.legitindicators.colorpicker", "activated color", 0, 170, 200, 255)


    --semirage category--
local semirage = gui.Checkbox(group, "nonamehook.semirage", "semirage", 0)
local semiragecolor = gui.ColorPicker(group, "nonamehook.semiragecolor", "colors", 0, 170, 200, 255)
local semiragedmgoverride = gui.Checkbox(group, "nonamehook.semiragedmgoverride", "mindmg override on key", 0)
local semiragedmgoverridekey = gui.Keybox(group, "nonamehook.semiragedmgoverridekey", "override key", 34)
local semiragedmgoverridevalue = gui.Slider(group, "nonamehook.semirageoverridevalue", "override value", 20, 1, 100)


    --viewmodel changer--
local viewmodelchangercheck = gui.Checkbox(group, "nonamehook.viewmodelchangerswitch", "viewmodel changer", 0)
local viewmodelchangerfov = gui.Slider(group, "nonamehook.viewmodelchangerfov", "fov", 60, 40, 90)
local viewmodelchangeroffsetx = gui.Slider(group, "nonamehook.viewmodelchangeroffsetx", "offset x", 1, -20, 10, 0.05)
local viewmodelchangeroffsety = gui.Slider(group, "nonamehook.viewmodelchangeroffsety", "offset y", 1, -5, 10, 0.05)
local viewmodelchangeroffsetz = gui.Slider(group, "nonamehook.viewmodelchangeroffsetz", "offset z", -1, -5, 5, 0.05)
local viewmodelchangerhandside = gui.Combobox(group, "nonamehook.viewmodelchangerhandside", "hand side", "right", "left")


    --fog editor--
local fogcheck = gui.Checkbox(group, "nonamehook.fogeditorswitch", "fog editor", 0)
local fogstart = gui.Slider(group, "nonamehook.fogeditorstart", "start", 0, -1000, 5000, 50)
local fogend = gui.Slider(group, "nonamehook.fogeditorend", "end", 0, -1000, 5000, 50)
local fogcolorred = gui.Slider(group, "nonamehook.fogeditorcolorred", "red", 1, 1, 255)
local fogcolorgreen = gui.Slider(group, "nonamehook.fogeditorcolorgreen", "green", 1, 1, 255)
local fogcolorblue = gui.Slider(group, "nonamehook.fogeditorcolorblue", "blue", 1, 1, 255)
local fogdensity = gui.Slider(group, "nonamehook.fogdensity", "max. density", -1, -1, 2, 0.25)
local foghdrcolor = gui.Slider(group, "nonamehook.foghdrcolor", "hdr color scale", 1, 0, 2, 0.25)


    --misc stuff--
local engineradarcheck = gui.Checkbox(group, "nonamehook.engineradar", "engine radar", 0)
local chatspammer = gui.Checkbox(group, "nonamehook.chatspammer", "chat spammer", 0)
local chatspammerdelay = gui.Slider(group, "nonamehook.chatspammerdelay","delay", 1, 1, 5, 0.25)
local chatspammerselection = gui.Combobox(group, "nonamehook.chatspammerselection", "text", "hallal message", "Astolfo > all", "fuck niggers", "fuck the haters", "stfu")
local ragdollcheck = gui.Checkbox(group, "nonamehook.ragdollmanipulation", "ragdoll manipulation", 0)
local ragdollforce = gui.Slider(group, "nonamehook.ragdollforce", "force", 100, 0, 5000)
local ragdollgravity = gui.Slider(group, "nonamehook.ragdollgravity", "gravity", 600, -1000, 1000, 100)
local invunlock = gui.Button(group, "Unlock Inventory", Inventoryunlock)

local InGame
local function isInGame()

    if entities.GetLocalPlayer() ~= nil then
        InGame = true
    end

end
callbacks.Register("Draw", isInGame)


--Variables and stuff--
local screenW, screenH = draw.GetScreenSize()
local screenWCenter = screenW/2
local screenHCenter = screenH/2


--making the window appear when Aimware's window is opened--
local function activecheck()

    window:SetActive(gui.Reference("Menu"):IsActive())

    if category:GetValue() == 0 then     --legit
        legitesp:SetInvisible(false)
        legitespmulti:SetInvisible(false)
        legitkeybox:SetInvisible(false)
        legitindicators:SetInvisible(false)
        legitindicatorscolor:SetInvisible(false)
    else
        legitesp:SetInvisible(true)
        legitespmulti:SetInvisible(true)
        legitkeybox:SetInvisible(true)
        legitindicators:SetInvisible(true)
        legitindicatorscolor:SetInvisible(true)
    end

    if category:GetValue() == 1 then     --semirage
        semirage:SetInvisible(false)
        semiragecolor:SetInvisible(false)
        semiragedmgoverride:SetInvisible(false)
        semiragedmgoverridekey:SetInvisible(false)
        semiragedmgoverridevalue:SetInvisible(false)
    else
        semirage:SetInvisible(true)
        semiragecolor:SetInvisible(true)
        semiragedmgoverride:SetInvisible(true)
        semiragedmgoverridekey:SetInvisible(true)
        semiragedmgoverridevalue:SetInvisible(true)
    end

    if category:GetValue() == 3 then    --viewmodel changer
        viewmodelchangercheck:SetInvisible(false)
        viewmodelchangerfov:SetInvisible(false)
        viewmodelchangeroffsetx:SetInvisible(false)
        viewmodelchangeroffsety:SetInvisible(false)
        viewmodelchangeroffsetz:SetInvisible(false)
        viewmodelchangerhandside:SetInvisible(false)
    else
        viewmodelchangercheck:SetInvisible(true)
        viewmodelchangerfov:SetInvisible(true)
        viewmodelchangeroffsetx:SetInvisible(true)
        viewmodelchangeroffsety:SetInvisible(true)
        viewmodelchangeroffsetz:SetInvisible(true)
        viewmodelchangerhandside:SetInvisible(true)
    end

    if category:GetValue() == 4 then    --fog editor
        fogcheck:SetInvisible(false)
        fogstart:SetInvisible(false)
        fogend:SetInvisible(false)
        fogdensity:SetInvisible(false)
        foghdrcolor:SetInvisible(false)
        fogcolorred:SetInvisible(false)
        fogcolorgreen:SetInvisible(false)
        fogcolorblue:SetInvisible(false)
    else
        fogcheck:SetInvisible(true)
        fogstart:SetInvisible(true)
        fogend:SetInvisible(true)
        fogcolorred:SetInvisible(true)
        fogcolorgreen:SetInvisible(true)
        fogcolorblue:SetInvisible(true)
        fogdensity:SetInvisible(true)
        foghdrcolor:SetInvisible(true)
    end

    if category:GetValue() == 5 then    -- misc
        engineradarcheck:SetInvisible(false)
        chatspammer:SetInvisible(false)
        chatspammerdelay:SetInvisible(false)
        chatspammerselection:SetInvisible(false)
        invunlock:SetInvisible(false)
        ragdollcheck:SetInvisible(false)
        ragdollforce:SetInvisible(false)
        ragdollgravity:SetInvisible(false)
    else
        engineradarcheck:SetInvisible(true)
        chatspammer:SetInvisible(true)
        chatspammerdelay:SetInvisible(true)
        chatspammerselection:SetInvisible(true)
        invunlock:SetInvisible(true)
        ragdollcheck:SetInvisible(true)
        ragdollforce:SetInvisible(true)
        ragdollgravity:SetInvisible(true)
    end

end
callbacks.Register("Draw", activecheck)


local function legitfunctions()

    if InGame == true then

        if input.IsButtonPressed(legitkeybox:GetValue()) then
            toggled = not toggled
        end

        if legitesp:GetValue() == true then

            if toggled then

                gui.SetValue("esp.overlay.enemy.box", 1)

                if legitespmultiopt1:GetValue() then
                    gui.SetValue("esp.overlay.enemy.name", 1)
                end

                if legitespmultiopt2:GetValue() then
                    gui.SetValue("esp.overlay.enemy.health.healthbar", true)
                    gui.SetValue("esp.overlay.enemy.health.healthnum", true)
                end

                if legitespmultiopt3:GetValue() then
                    gui.SetValue("esp.overlay.enemy.weapon", 1)
                end

            else

                gui.SetValue("esp.overlay.enemy.box", 0)
           
                if legitespmultiopt1:GetValue() then
                    gui.SetValue("esp.overlay.enemy.name", 0)
                end

                if legitespmultiopt2:GetValue() then
                    gui.SetValue("esp.overlay.enemy.health.healthbar", false)
                    gui.SetValue("esp.overlay.enemy.health.healthnum", false)
                end

                if legitespmultiopt3:GetValue() then
                    gui.SetValue("esp.overlay.enemy.weapon", 0)
                end

            end

        end

    end

end
callbacks.Register("Draw", legitfunctions)


local indicatorfont = draw.CreateFont('Verdan Bold', 30, 3000)
local indicatorX = screenW-(screenW-20)
local indicatorY = screenHCenter+100
draw.SetFont(indicatorfont)


local function legitindicator()
    
    if InGame == true then

        draw.SetFont(indicatorfont)

        if legitindicators:GetValue() then

            if gui.GetValue("esp.overlay.enemy.box") ~= 0 then
                draw.Color(legitindicatorscolor:GetValue())
                draw.TextShadow(indicatorX, indicatorY, "ESP")
            else
                draw.Color(200, 0, 0, 255)
                draw.TextShadow(indicatorX, indicatorY, "ESP")
            end

            if gui.GetValue("lbot.antiaim.type") ~= "\"Off\"" then
                draw.Color(legitindicatorscolor:GetValue())
                draw.TextShadow(indicatorX, (indicatorY+35), "LAA")
            else
                draw.Color(200, 0, 0, 255)
                draw.TextShadow(indicatorX, (indicatorY+35),"LAA")
            end                

            if input.IsButtonDown(gui.GetValue("lbot.aim.key")) then
                draw.Color(legitindicatorscolor:GetValue())
                draw.TextShadow(indicatorX, (indicatorY+70), "LBOT")
            else
                draw.Color(200, 0, 0, 255)
                draw.TextShadow(indicatorX, (indicatorY+70), "LBOT")
            end

        end

    end    

end
callbacks.Register("Draw", legitindicator)



local latestcolor
local latestend
local lateststart
local latestmaxdensity
local latesthdrcolorscale

local function fogeditor()

    if InGame == true then

        if fogcheck:GetValue() then

            if client.GetConVar("fog_override") ~= 1 then
                client.SetConVar("fog_override", 1, true)
            end
        
            if client.GetConVar("fog_color") ~= latestcolor then
                client.SetConVar("fog_color", fogcolor:GetValue(), true)
                latestcolor = fogcolor:GetValue()
            end

            if client.GetConVar("fog_end") ~= latestend then
                client.SetConVar("fog_end", fogend:GetValue(), true)
                latestend = fogend:GetValue()
            end

            if client.GetConVar("fog_start") ~= lateststart then
                client.SetConVar("fog_start", fogstart:GetValue(), true)
                lateststart = fogend:GetValue()
            end

            if client.GetConVar("fog_maxdensity") ~= latestmaxdensity then
                client.SetConVar("fog_maxdensity", fogdensity:GetValue(), true)
                latestmaxdensity = fogdensity:GetValue()
            end

            if client.GetConVar("fog_hdrcolorscale") ~= latesthdrcolorscale then
                client.SetConVar("fog_hdrcolorscale", foghdrcolor:GetValue(), true)
                latesthdrcolorscale = foghdrcolor:GetValue()
            end

        else
            if client.GetConVar("fog_override") ~= 0 then
                client.SetConVar("fog_override", 0, true)
            end

        end

    end

end
callbacks.Register("Draw", fogeditor)


local lastestoffsetx
local latestoffsety
local latestoffsetz


local function viewmodelchanger()

    if InGame == true then

        if viewmodelchangercheck:GetValue() then

            if gui.GetValue("esp.local.viewmodelfov") ~= viewmodelchangerfov:GetValue() then
                gui.SetValue("esp.local.viewmodelfov", viewmodelchangerfov:GetValue())
            end

            if client.GetConVar("viewmodel_offset_x") ~= latestoffsetx then
                client.SetConVar("viewmodel_offset_x", viewmodelchangeroffsetx:GetValue(), false)
                latestoffsetx = viewmodelchangeroffsetx:GetValue()
            end

            if client.GetConVar("viewmodel_offset_y") ~= latestoffsety then
                client.SetConVar("viewmodel_offset_y", viewmodelchangeroffsety:GetValue(), false)
                latestoffsety = viewmodelchangeroffsety:GetValue()
            end

            if client.GetConVar("viewmodel_offset_z") ~= latestoffsetz then
                client.SetConVar("viewmodel_offset_z", viewmodelchangeroffsetz:GetValue(), false)
                latestoffsetz = viewmodelchangeroffsetz:GetValue()
            end
            
            
        end

    end

end
callbacks.Register("Draw", viewmodelchanger)


local function engineradar()

    if engineradarcheck:GetValue() then

        if InGame == true then

            for index, Player in pairs(entities.FindByClass("CCSPlayer")) do
		    Player:SetProp("m_bSpotted", 1);
            end

        end

    end

end
callbacks.Register("Draw", engineradar)


local rbothitchance = nil
local rbotMinDmg = nil
local rbotAWall = nil
local rbotAWallStatus = nil
local lbotHitchance = nil
local lbotMaxFov = nil
local lbotAWall = nil
local currentMinDmg = nil


local function weaponCheck()

    if semirage:GetValue() == true then

        local a = entities.GetLocalPlayer():GetWeaponID()

        if gui.GetValue("rbot.master") == true then

            if a == 4 or a == 61 or a == 63 or a == 2 or a == 3 or a == 32 or a == 36 or a == 30 then
                rbothitchance = gui.GetValue("rbot.accuracy.weapon.pistol.hitchance")
                rbotMinDmg = gui.GetValue("rbot.accuracy.weapon.pistol.mindmg")
                rbotAWall = gui.GetValue("rbot.hitscan.mode.pistol.autowall")
            elseif a == 1 or a == 64 then
                rbothitchance = gui.GetValue("rbot.accuracy.weapon.hpistol.hitchance")
                rbotMinDmg = gui.GetValue("rbot.accuracy.weapon.hpistol.mindmg")
                rbotAWall = gui.GetValue("rbot.hitscan.mode.hpistol.autowall")
            elseif a == 17 or a == 26 or a == 19 or a == 24 or a == 23 or a == 34 or a == 33 then
                rbothitchance = gui.GetValue("rbot.accuracy.weapon.smg.hitchance")
                rbotMinDmg = gui.GetValue("rbot.accuracy.weapon.smg.mindmg")
                rbotAWall = gui.GetValue("rbot.hitscan.mode.smg.autowall")
            elseif a == 7 or a == 8 or a == 10 or a == 13 or a == 60 or a == 16 or a == 39 then
                rbothitchance = gui.GetValue("rbot.accuracy.weapon.rifle.hitchance")
                rbotMinDmg = gui.GetValue("rbot.accuracy.weapon.rifle.mindmg")
                rbotAWall = gui.GetValue("rbot.hitscan.mode.rifle.autowall")
            elseif a == 35 or a == 27 or a == 25 or a == 29 then
                rbothitchance = gui.GetValue("rbot.accuracy.weapon.shotgun.hitchance")
                rbotMinDmg = gui.GetValue("rbot.accuracy.weapon.shotgun.mindmg")
                rbotAWall = gui.GetValue("rbot.hitscan.mode.shotgun.autowall")
            elseif a == 40 then
                rbothitchance = gui.GetValue("rbot.accuracy.weapon.scout.hitchance")
                rbotMinDmg = gui.GetValue("rbot.accuracy.weapon.scout.mindmg")
                rbotAWall = gui.GetValue("rbot.hitscan.mode.scout.autowall")
            elseif a == 11 or a == 38 then
                rbothitchance = gui.GetValue("rbot.accuracy.weapon.asniper.hitchance")
                rbotMinDmg = gui.GetValue("rbot.accuracy.weapon.asniper.mindmg")
                rbotAWall = gui.GetValue("rbot.hitscan.mode.asniper.autowall")
            elseif a == 9 then
                rbothitchance = gui.GetValue("rbot.accuracy.weapon.sniper.hitchance")
                rbotMinDmg = gui.GetValue("rbot.accuracy.weapon.sniper.mindmg")
                rbotAWall = gui.GetValue("rbot.hitscan.mode.sniper.autowall")
            elseif a == 28 or a == 13 then
                rbothitchance = gui.GetValue("rbot.accuracy.weapon.lmg.hitchance")
                rbotMinDmg = gui.GetValue("rbot.accuracy.weapon.lmg.mindmg")
                rbotAWall = gui.GetValue("rbot.hitscan.mode.lmg.autowall")
            elseif a == 31 then
                rbothitchance = gui.GetValue("rbot.accuracy.weapon.zeus.hitchance")
                rbotMinDmg = gui.GetValue("rbot.accuracy.weapon.zeus.mindmg")
                rbotAWall = gui.GetValue("rbot.hitscan.mode.zeus.autowall")
            else
                rbothitchance = gui.GetValue("rbot.accuracy.weapon.shared.hitchance")
                rbotMinDmg = gui.GetValue("rbot.accuracy.weapon.shared.mindmg")
                rbotAWall = gui.GetValue("rbot.hitscan.mode.shared.autowall")
            end

            if rbotAWall == true then
                rbotAWallStatus = "on"
            else
                rbotAWallStatus = "off"
            end

        end 

        if gui.GetValue("lbot.master") == true then

             if a == 4 or a == 61 or a == 63 or a == 2 or a == 3 or a == 32 or a == 36 or a == 30 then
                lbotHitchance = gui.GetValue("lbot.trg.pistol.hitchance")
                lbotMaxFov = gui.GetValue("lbot.weapon.target.pistol.maxfov")
                lbotAWall = gui.GetValue("lbot.weapon.vis.pistol.autowall")
            elseif a == 1 or a == 64 then
                lbotHitchance = gui.GetValue("lbot.trg.hpistol.hitchance")
                lbotMaxFov = gui.GetValue("lbot.weapon.target.hpistol.maxfov")
                lbotAWall = gui.GetValue("lbot.weapon.vis.hpistol.autowall")
            elseif a == 17 or a == 26 or a == 19 or a == 24 or a == 23 or a == 34 or a == 33 then
                lbotHitchance = gui.GetValue("lbot.trg.smg.hitchance")
                lbotMaxFov = gui.GetValue("lbot.weapon.target.smg.maxfov")
                lbotAWall = gui.GetValue("lbot.weapon.vis.smg.autowall")
            elseif a == 7 or a == 8 or a == 10 or a == 13 or a == 60 or a == 16 or a == 39 then
                lbotHitchance = gui.GetValue("lbot.trg.rifle.hitchance")
                lbotMaxFov = gui.GetValue("lbot.weapon.target.rifle.maxfov")
                lbotAWall = gui.GetValue("lbot.weapon.vis.rifle.autowall")
            elseif a == 35 or a == 27 or a == 25 or a == 29 then
                lbotHitchance = gui.GetValue("lbot.trg.shotgun.hitchance")
                lbotMaxFov = gui.GetValue("lbot.weapon.target.shotgun.maxfov")
                lbotAWall = gui.GetValue("lbot.weapon.vis.shotgun.autowall")
            elseif a == 40 then
                lbotHitchance = gui.GetValue("lbot.trg.scout.hitchance")
                lbotMaxFov = gui.GetValue("lbot.weapon.target.scout.maxfov")
                lbotAWall = gui.GetValue("lbot.weapon.vis.scout.autowall")
            elseif a == 11 or a == 38 then
                lbotHitchance = gui.GetValue("lbot.trg.asniper.hitchance")
                lbotMaxFov = gui.GetValue("lbot.weapon.target.asniper.maxfov")
                lbotAWall = gui.GetValue("lbot.weapon.vis.asniper.autowall")
            elseif a == 9 then
                lbotHitchance = gui.GetValue("lbot.trg.sniper.hitchance")
                lbotMaxFov = gui.GetValue("lbot.weapon.target.sniper.maxfov")
                lbotAWall = gui.GetValue("lbot.weapon.vis.sniper.autowall")
            elseif a == 28 or a == 13 then
                lbotHitchance = gui.GetValue("lbot.trg.lmg.hitchance")
                lbotMaxFov = gui.GetValue("lbot.weapon.target.lmg.maxfov")
                lbotAWall = gui.GetValue("lbot.weapon.vis.lmg.autowall")
            elseif a == 31 then
                lbotHitchance = gui.GetValue("lbot.trg.zeus.hitchance")
                lbotMaxFov = gui.GetValue("lbot.weapon.target.zeus.maxfov")
                lbotAWall = gui.GetValue("lbot.weapon.vis.zeus.autowall")
            else
                lbotHitchance = gui.GetValue("lbot.trg.shared.hitchance")
                lbotMaxFov = gui.GetValue("lbot.weapon.target.shared.maxfov")
                lbotAWall = gui.GetValue("lbot.weapon.vis.shared.autowall")
            end

            if lbotAWall == true then
                lbotAWallStatus = "on"
            else
                lbotAWallStatus = "off"
            end

        end

    end

end
callbacks.Register("Draw", weaponCheck)


local positionX
local positionY

if positionX == nil and positionY == nil then
    positionX = screenWCenter
    positionY = screenHCenter
end

local font = draw.CreateFont( "Agency FB", 20, 100 )

local function semirageindicators()

    if semirage:GetValue() == true then

        if InGame == true then

            if gui.GetValue("lbot.master") == true then
                draw.SetFont(font)
                draw.Color(255, 255, 255, 255)
                draw.TextShadow(positionX, positionY+20, "hchance:" )
                draw.Color(semiragecolor:GetValue())
                draw.TextShadow(positionX+60, positionY+20, lbotHitchance)
                draw.Color(255, 255, 255, 255)
                draw.TextShadow(positionX, positionY+35, "maxfov:")
                draw.Color(semiragecolor:GetValue())
                draw.TextShadow(positionX+60, positionY+35, lbotMaxFov)
                draw.Color(255, 255, 255, 255)
                draw.TextShadow(positionX, positionY+50, "awall:")
                draw.Color(semiragecolor:GetValue())
                draw.TextShadow(positionX+60, positionY+50, lbotAWallStatus)
            end

            if gui.GetValue("rbot.master") == true then
                draw.SetFont(font)
                draw.Color(255, 255, 255, 255)
                draw.TextShadow(positionX, positionY+20, "hchance:" )
                draw.Color(semiragecolor:GetValue())
                draw.TextShadow(positionX+60, positionY+20, rbothitchance)
                draw.Color(255, 255, 255, 255)
                draw.TextShadow(positionX, positionY+35, "mindmg:")
                draw.Color(semiragecolor:GetValue())
                draw.TextShadow(positionX+60, positionY+35, rbotMinDmg)
                draw.Color(255, 255, 255, 255)
                draw.TextShadow(positionX, positionY+50, "awall:")
                draw.Color(semiragecolor:GetValue())
                draw.TextShadow(positionX+60, positionY+50, rbotAWallStatus)
            end

        end

    end

end
callbacks.Register("Draw", semirageindicators)


local timing = false
local lasttiming = 0
local message


local function chatspam()

    if chatspammer:GetValue() == true then

        if InGame == true then
            
            local delay = chatspammerdelay:GetValue()

            if globals.CurTime() >= (lasttiming+delay) then
                timing = true
                lasttiming = globals.CurTime()
            end

            if chatspammerselection:GetValue() == 0 then
                message = "﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽﷽"
            elseif chatspammerselection:GetValue() == 1 then
                message = "Astolfo > all"
            elseif chatspammerselection:GetValue() == 2 then
                message = "fuck niggers"
            elseif chatspammerselection:GetValue() == 3 then
                message = "fuck the haters"
            elseif chatspammerselection:GetValue() == 4 then
                message = "shut the fuck you stupid bitch ass nigger femboy dipshit asshole fucktard pedophile motherfucker crybaby noname newfagg kys"
            end

            if timing == true then
                client.ChatSay(message)
                timing = false
            end
        
        end
    end

end
callbacks.Register("Draw", chatspam)


local function ragdollmanipulation()

    if ragdollcheck:GetValue() == true then

        if InGame == true then

            client.SetConVar("phys_pushscale", ragdollforce:GetValue(), true)
            client.SetConVar("cl_ragdoll_gravity", ragdollgravity:GetValue(), true)

        end

    end

end
callbacks.Register("Draw", ragdollmanipulation)


local function Inventoryunlock()

    panorama.RunScript([[
    LoadoutAPI.IsLoadoutAllowed = () => {
    return true; 
    };
    ]])

end
