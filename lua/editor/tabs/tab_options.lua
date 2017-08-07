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
	
	cusHud.tools["op"](20,40, 300,300,cusHud.mainEle.editorHolder)
	
end



cusHud.tabs.options = {text = "O", title = "Color Element", OnClick=function() click() end}


cusHud.tools["op"] = function(x,y, sX,sY, editHolder)
	
	local btnScale = vgui.Create("DButton", editHolder)
	btnScale:SetText("Scale")
	btnScale:SetSize(45,30)
	btnScale:SetPos(20,70)
	btnScale.DoClick = function()
		cusHud.editorMode = "scale"		
	end
	
	local btnScale = vgui.Create("DButton", editHolder)
	btnScale:SetText("Move")
	btnScale:SetSize(45,30)
	btnScale:SetPos(20,120)
	btnScale.DoClick = function()
		cusHud.editorMode = "move"		
	end
	
end
