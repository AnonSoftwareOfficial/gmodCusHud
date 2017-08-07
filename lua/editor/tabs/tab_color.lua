local function GetTextSize(font, text)
	surface.SetFont(font)
	return surface.GetTextSize(text)
end


local function click()
	
	
	local titlePan = cusHud.mainEle.editorHolder
	
	
	local tw,th = GetTextSize("Default", "Set Colour")
	local title = vgui.Create("DLabel", titlePan)
	title:SetText("Set Colour")
	title:SetPos((titlePan:GetWide() / 2) - (tw / 2), 30)
	title:SetSize(tw,th)
	title:SetTextColor(Color(255,255,255,255))
	title:SetZPos(10)
	
	cusHud.tools["colorMixer"](20,40, 300,300,cusHud.mainEle.editorHolder)
	
end



cusHud.tabs.color = {text = "C", title = "Color Element", OnClick=function() click() end}


cusHud.tools["colorMixer"] = function(x,y, sX,sY, editHolder)
	local currentmixerOp = ""
	
	local mixerPan = vgui.Create("DPanel", editHolder)
	mixerPan:SetSize(250,250)
	mixerPan:SetPos((editHolder:GetWide() / 2) - (mixerPan:GetWide() / 2), 200)
	
	local mixer = vgui.Create("DColorMixer", mixerPan)
	mixer:Dock(FILL)
	mixer:SetPalette(false)
	mixer:SetWangs(false)
	mixer:SetAlphaBar(true)
	
	
	function mixer:ValueChanged(self, color)
		
		local color = mixer:GetColor()
		if cusHud.mainEle.currentPan.pan != nil then
			if currentmixerOp != cusHud.mainEle.currentPan.op then
				currentmixerOp = cusHud.mainEle.currentPan.op
				return
			else
				if cusHud.mainEle.currentPan.op == "box" then
					cusHud.mainEle.currentPan.pan:SetBackgroundColor(color)
				else
					cusHud.mainEle.currentPan.pan:GetChildren()[1]:SetTextColor(color)
				end
			end
		end
	end
	


end
