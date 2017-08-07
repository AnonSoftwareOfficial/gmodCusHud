print("Loaded Square")
cusHud.createElement["curtime"] = function(v)	
	local colStr = string.Explode("/", v.col)
	local col = Color(colStr[1],colStr[2],colStr[3],colStr[4])	
	local CurrentTime = (LocalPlayer():InSurf() and CurTime() - ZARP.StartTime  or 0)
	draw.SimpleText("Current Time: "..ZARP.FormatTime(CurrentTime),"SURF_Bebas35",v.x, v.y, col)
	
end
cusHud.eleDetails["curtime"] = {description = "Cretae a square"}


local function GetTextSize(font, text)
	surface.SetFont(font)
	return surface.GetTextSize(text)
end

cusHud.editorElements["curtime"] = {click = function(v)
	
	local tw,th = GetTextSize("SURF_Bebas35", "CURRENT TIME: 00:00:00:00")
	
	local count = table.Count(cusHud.editDisplay)
	count = count + 1
	cusHud.editDisplay["curtime"..count] = {} 
	
	cusHud.editDisplay["curtime"..count].pan = vgui.Create("DPanel",v.screen)
	cusHud.editDisplay["curtime"..count].pan:SetSize(tw,th)
	cusHud.editDisplay["curtime"..count].pan:SetPos(v.x,v.y)
	cusHud.editDisplay["curtime"..count].pan:SetBackgroundColor(Color(0,0,0,0))
	cusHud.editDisplay["curtime"..count].pan:Droppable("screenPanel")
	cusHud.editDisplay["curtime"..count].op = "curtime"
	
	
	local dlabel = vgui.Create("DLabel", cusHud.editDisplay["curtime"..count].pan)
	dlabel:SetText("CURRENT TIME: 00:00:00:00")
	dlabel:SetFont("SURF_Bebas35")
	dlabel:SetSize(tw,th)
	
	cusHud.mainEle.currentPan = cusHud.editDisplay("curtime"..count)
end, op = "curtime"}

