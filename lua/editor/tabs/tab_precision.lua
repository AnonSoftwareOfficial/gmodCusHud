local function GetTextSize(font, text)
	surface.SetFont(font)
	return surface.GetTextSize(text)
end


local function click()
	
	
	local titlePan = cusHud.mainEle.editorHolder
	
	
	local tw,th = GetTextSize("Default", "Options")
	local title = vgui.Create("DLabel", titlePan)
	title:SetText("Options")
	title:SetPos((titlePan:GetWide() / 2) - (tw / 2), 30)
	title:SetSize(tw,th)
	title:SetTextColor(Color(255,255,255,255))
	title:SetZPos(10)
	
	cusHud.tools["precision"](20,40, 300,300,cusHud.mainEle.editorHolder)
	
end



cusHud.tabs.precision = {text = "P", title = "Precision Tools", OnClick=function() click() end}


local function createText(text, x,y, holder, sizeX,sizeY, font, col)
	
	local textLb = vgui.Create("DLabel",holder)
	textLb:SetPos(x,y)
	textLb:SetSize(sizeX, sizeY)
	textLb:SetFont(font)
	textLb:SetText(text)
	textLb:SetTextColor(col or Color(255,255,255,255))
	return textLb
end

local function createInput(x,y,sizeX,sizeY,Text, enterFunc, editHolder)
	local textEnt = vgui.Create("DTextEntry", editHolder)
	textEnt:SetPos(x,y)
	textEnt:SetSize(sizeX,sizeY)
	textEnt:SetText(Text)
	textEnt.OnEnter = function(self) enterFunc(self) end
end

cusHud.tools["precision"] = function(x,y, sX,sY, editHolder)
	
	local Ztext = createText("Z:", 40,45,editHolder, 30,30, "Default", Color(255,255,255,255) )
	
	local zEntry = vgui.Create("DTextEntry", editHolder)
	zEntry:SetPos(60,50)
	zEntry:SetSize(50,20)
	zEntry:SetText("1")
	zEntry.OnEnter = function(self)
		cusHud.mainEle.currentPan.pan:SetZPos(tonumber(self:GetValue()))
	end
	
	
	
	local Xtext = createText("X:", 40,85,editHolder, 30,30, "Default", Color(255,255,255,255) )	
	local xEntry = vgui.Create("DTextEntry", editHolder)
	xEntry:SetPos(60,90)
	xEntry:SetSize(50,20)
	xEntry:SetText(x)
	xEntry.OnEnter = function(self)
		local x,y = cusHud.mainEle.currentPan.pan:GetPos()
		cusHud.mainEle.currentPan.pan:SetPos(tonumber(self:GetValue()), y)
	end
	
	local Ytext = createText("Y:", 150,85,editHolder, 30,30, "Default", Color(255,255,255,255) )
	local yEntry = createInput(170,90,50,20,"100",function(self)
		local x,y = cusHud.mainEle.currentPan.pan:GetPos()
		cusHud.mainEle.currentPan.pan:SetPos(x, tonumber(self:GetValue()))
	end, editHolder)
	
	
	
	local XtextSize = createText("Size X:", 20,123,editHolder, 35,35, "Default", Color(255,255,255,255) )
	local xEntrySize = createInput(60,130,50,20,"100",function(self)
		local x,y = cusHud.mainEle.currentPan.pan:GetSize()
		cusHud.mainEle.currentPan.pan:SetSize(x, tonumber(self:GetValue()))
	end, editHolder)
	
	local YtextSize = createText("Size Y:", 130,123,editHolder, 35,35, "Default", Color(255,255,255,255) )
	local yEntrySize = createInput(170,130,50,20,"100",function(self)
		local x,y = cusHud.mainEle.currentPan.pan:GetSize()
		cusHud.mainEle.currentPan.pan:SetSize(tonumber(self:GetValue()), y)
	end, editHolder)
	
end