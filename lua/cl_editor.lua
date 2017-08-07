cusHud.edit = false


local curTab = curTab or nil







function cusHud.DisplayEditor()
	
	cusHud.editDisplay = {}
	

	loadEdiotrOptions()
	
	cusHud.edit = true
	
	cusHud.mainEle.currentPan = {pan = nil, op = ""}
	
	
	local screen = vgui.Create("DPanelSelect")
	screen:SetSize(ScrW(), ScrH())
	screen:SetBackgroundColor(Color(0,0,0,0))
	
	cusHud.mainEle.jobs = vgui.Create("DPanel")
	cusHud.mainEle.jobs:SetSize(ScrW(), ScrH())
	cusHud.mainEle.jobs:SetBackgroundColor(Color(0,0,0,100))
	screen:AddItem(cusHud.mainEle.jobs)
	
	
	
	local editorFrame = vgui.Create("DFrame")
	editorFrame:SetSize(400, ScrH() - 100)
	editorFrame:SetPos(ScrW() + 1, 20)
	editorFrame:MakePopup()
	editorFrame:SetTitle("Hud Editor v1")
	
	function editorFrame:OnClose()
		screen:Remove()
		for k,v in pairs(cusHud.editDisplay) do
			//v:Remove()
		end
		cusHud.edit = false
	end
	
	editorFrame:MoveTo(ScrW() - editorFrame:GetWide(), 20, 1,0)
	
	cusHud.mainEle.editorFrame = editorFrame
	
	local holderPanel = vgui.Create("DPanel", editorFrame)
	holderPanel:SetPos(30,25)
	holderPanel:SetSize( editorFrame:GetWide() - 30,  editorFrame:GetTall()-25)
	holderPanel:SetBackgroundColor(Color(170,170,170,255))
	
	cusHud.mainEle.editorHolder = holderPanel
	
		
	hook.Call("RegisterEditor_Hud", nil, "")
	
	
	local tabPan = vgui.Create("DPanel", editorFrame)
	tabPan:SetSize(30, editorFrame:GetTall())
	tabPan:SetPos(0,25)
	
	local startX = 5
	local startY = 30
	local curY = 30
	print(table.Count(cusHud.tabs))
	for k,v in pairs(cusHud.tabs) do
		print(v.title, startX, curY)
		local tabBtn = vgui.Create("DButton", tabPan)
		tabBtn:SetSize(20,20)
		tabBtn:SetText(v.text)
		tabBtn:SetPos(startX, curY)
		tabBtn.DoClick = function() 
			holderPanel:Clear()
			v.OnClick()
		end
		curY = curY + startY
	end
	
	
	screen:Receiver("screenPanel", function(pnl,tbl,dropped,menu,x,y)
	
		if tbl[1] != cusHud.mainEle.currentPan.pan then
			cusHud.mainEle.currentPan.pan = tbl[1]
			for k,v in pairs(cusHud.editDisplay) do
				if v.pan == tbl[1] then
					cusHud.mainEle.currentPan.op = v.op
					break
				end
			end
		
		end
		cusHud.editor[cusHud.editorMode](pnl, tbl, dropped, menu, x, y)
		
		
	end)
	
	
end

concommand.Add("openHudEditor", cusHud.DisplayEditor)


function loadEdiotrOptions()
	cusHud.editor["move"] = function(pnl, tbl, dropped, menu, x, y)
		if !dropped then return end
		
		local xM = x - (tbl[1]:GetWide() / 2) + 5 
		local yM = y - (tbl[1]:GetTall() / 2) + 5
				
		tbl[1]:SetPos(xM,yM)
		//hook.Call("elementMoveEvent", nil, tbl[1])
	end


	cusHud.editor["scale"] = function(pnl, tbl, dropped, menu, x, y)
		local mx,my = tbl[1]:GetPos()
		local rx = tbl[1]:GetWide() / 2 + 5
		local ry = tbl[1]:GetTall() / 2 + 5
			
		//tbl[1]:SetSize((x - mx) + rx, (y - my) + ry)
		tbl[1]:SetSize(x - mx,y-my)
	end
	
end


function cusHud.sql.save(tbl)
	//PrintTable(tbl)
	sql.Query("INSERT INTO surfHud (type, x,y,z,sX,sY,col) VALUES ('"..tbl.op.."',"..tbl.x..","..tbl.y..","..tbl.z..","..tbl.sX..","..tbl.sY..",'"..tbl.color.r.."/"..tbl.color.g.."/"..tbl.color.b.."/"..tbl.color.a.."')")
end

function cusHud.sql.reloadDB()
	sql.Query("DROP TABLE surfHud")
	cusHud.sql.create()
end

function cusHud.sql.getDesign()
	if sql.TableExists("surfHud") then
		local respon = sql.Query("SELECT * FROM 'surfHud'")
		return respon
	else
		return nil
	end
end

function cusHud.sql.create()
	local complete = sql.Query("CREATE TABLE IF NOT EXISTS surfHud (type VARCHAR(200), x BIGINT, y BIGINT, z BIGINT, sX BIGINT, sY BIGINT, col VARCHAR(40))")
end
