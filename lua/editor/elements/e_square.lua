print("Loaded Square")
cusHud.createElement["box"] = function(v)	
	local colStr = string.Explode("/", v.col)
	local col = Color(colStr[1],colStr[2],colStr[3],colStr[4])
	draw.RoundedBox(5,v.x,v.y,v.sX,v.sY,col)
end
cusHud.eleDetails["box"] = {description = "Cretae a square"}


cusHud.editorElements["box"] = {click = function(v)
	
	local count = table.Count(cusHud.editDisplay)
	count = count + 1
	cusHud.editDisplay["box"..count] = {} 
	
	cusHud.editDisplay["box"..count].pan = vgui.Create("DPanel",v.screen)
	cusHud.editDisplay["box"..count].pan:SetSize(v.sX,v.sY)
	cusHud.editDisplay["box"..count].pan:SetPos(v.x,v.y)
	cusHud.editDisplay["box"..count].pan:SetBackgroundColor(v.color)
	cusHud.editDisplay["box"..count].pan:Droppable("screenPanel")
	cusHud.editDisplay["box"..count].op = "box"
	
	cusHud.mainEle.currentPan = cusHud.editDisplay["box"..count]
	
end, op = "box"}

/*
for i=1,15 do
	cusHud.eleDetails["box"..i] = {description = "Cretae a square "..i}
	cusHud.createElement["box"..i] = {click = function(v)	
		local colStr = string.Explode("/", v.col)
		local col = Color(colStr[1],colStr[2],colStr[3],colStr[4])
		draw.RoundedBox(5,v.x,v.y,v.sX,v.sY,col)
	end,
	op = "box"
	}

end


*/
