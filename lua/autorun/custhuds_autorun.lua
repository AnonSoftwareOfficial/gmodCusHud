
if SERVER then
	AddCSLuaFile("sh_config.lua")
	//AddCSLuaFile("cl_main.lua")
	AddCSLuaFile("cl_sqlf.lua")
	
	AddCSLuaFile("cl_functions.lua")
	AddCSLuaFile("cl_editor.lua")
	

	
	
	local folder = "editor/elements/"
	for _, file in pairs(file.Find(folder .. "e_*.lua", "LUA")) do
		AddCSLuaFile( folder .. file )
	end
	
	local folder = "editor/tabs/"
	for _, file in pairs(file.Find(folder .. "tab_*.lua", "LUA")) do
		AddCSLuaFile( folder .. file )
	end
	
	local folder = "editor/tools/"
	for _, file in pairs(file.Find(folder .. "m_*.lua", "LUA")) do
		AddCSLuaFile( folder .. file )
	end
else


	include("sh_config.lua")
	//include("cl_main.lua")
	include("cl_sqlf.lua")
	print("Loading Editor")
	
	include("cl_functions.lua")
	include("cl_editor.lua")
	
	function RegisterEditor()
	
		local folder = "editor/tabs/"
		for _, file in pairs(file.Find(folder .. "tab_*.lua", "LUA")) do
			print(file)
			include( folder .. file )
		end
		
		local folder = "editor/tools/"
		for _, file in pairs(file.Find(folder .. "m_*.lua", "LUA")) do
			print(file)
			include( folder .. file )
		end
	end
	
	function RegisterEle()
		print("Loading Elements")
		local folder = "editor/elements/"
		for _, file in pairs(file.Find(folder .. "e_*.lua", "LUA")) do
			print(file)
			include( folder .. file )
		end
	end
	
	hook.Add("RegisterEditor_Hud", "RegisterAllElements", RegisterEditor)
	
	hook.Add("RegisterElements_Hud", "RegisterElements", RegisterEle)
end