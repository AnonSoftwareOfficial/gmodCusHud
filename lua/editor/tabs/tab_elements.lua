
local function click()
	--[[
	local holderPanel = vgui.Create("DPanel", cusHud.mainEle.editorHolder)
	holderPanel:SetPos(0,0)
	holderPanel:SetSize( cusHud.mainEle.editorHolder:GetWide(),  cusHud.mainEle.editorHolder:GetTall())
	holderPanel:SetBackgroundColor(Color(170,170,170,255))
	--]]
	
	local titlePan = cusHud.mainEle.editorHolder
	
	local scrollHolder = vgui.Create("DScrollPanel", cusHud.mainEle.editorHolder)
	scrollHolder:SetSize(cusHud.mainEle.editorHolder:GetWide(), cusHud.mainEle.editorHolder:GetTall())
	
	
	local tw,th = GetTextSize("Default", "Create")
	local title = vgui.Create("DLabel", scrollHolder)
	title:SetText("Create")
	title:SetPos((titlePan:GetWide() / 2) - (tw / 2), 30)
	title:SetSize(tw,th)
	title:SetTextColor(Color(255,255,255,255))
	title:SetZPos(10)
	
	
	
	
	cusHud.tools["elements"](60,80, 300,300,scrollHolder)
	
end





cusHud.tabs.elements = {text = "E", title = "Create Element", OnClick=function() click() end}


cusHud.tools["elements"] = function(x,y,sX,sY,holder)
	
	print(table.Count(cusHud.createElement))
	
	local curY = y
	
	print(x,curY)
	
	for k,v in pairs(cusHud.editorElements) do
		local tw,th = GetTextSize("Default", k)
		local elC = vgui.Create("DButton", holder)
		elC:SetText(k)
		elC:SetSize(40,40)
		elC:SetPos(x,curY)
		elC.DoClick = function()
			//v({screen = cusHud.mainEle.jobs})
			
			cusHud.editorElements[v.op].click({screen = cusHud.mainEle.jobs, x = x,y=y,sX = x + 20, sY= y + 20})
			
		end
		
		curY = curY + th + 50
	
	end
	


end
