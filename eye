-- =====================================================================
-- ROBLOX DYNAMIC CLIENT SHADER & ENVIRONMENT OPTIMIZER
-- Seamlessly transitions: Morning -> Pandora (8-11) -> Day -> Sunset -> Night
-- =====================================================================
if _G.ShaderAxecuted then return end
_G.ShaderAxecuted = true

local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

-- Force Roblox's highest tier rendering tech globally
pcall(function()
	Lighting.Technology = Enum.Technology.Future
end)

-- =====================================================================
-- INSTANCE SETUP (Creates effects if they don't exist)
-- =====================================================================

local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere", Lighting)
local colorCorrection = Lighting:FindFirstChild("ClientColorCorr") or Instance.new("ColorCorrectionEffect", Lighting)
colorCorrection.Name = "ClientColorCorr"
local bloom = Lighting:FindFirstChild("ClientBloom") or Instance.new("BloomEffect", Lighting)
bloom.Name = "ClientBloom"
local sunRays = Lighting:FindFirstChild("ClientSunRays") or Instance.new("SunRaysEffect", Lighting)
sunRays.Name = "ClientSunRays"
local dof = Lighting:FindFirstChild("ClientDOF") or Instance.new("DepthOfFieldEffect", Lighting)
dof.Name = "ClientDOF"
local bgm = SoundService:FindFirstChild("ClientEnvBGM") or Instance.new("Sound", SoundService)
bgm.Name = "ClientEnvBGM"
bgm.Looped = true

local currentTheme = nil

-- =====================================================================
-- THEME FUNCTIONS
-- =====================================================================

local function applyMorningTheme()
	for _, v in ipairs(Workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			local name = v.Name:lower()
			if name == "street" or name == "road" or name == "asphalt" then
				v.Material = Enum.Material.SmoothPlastic
				v.Color = Color3.fromRGB(20, 25, 32)
				v.Reflectance = 0.18
			elseif name == "wall" or name == "concrete" or name == "building" then
				v.Material = Enum.Material.SmoothPlastic
				v.Color = Color3.fromRGB(55, 65, 75)
			elseif v.Material == Enum.Material.Glass or name == "window" or name == "glass" then
				v.Color = Color3.fromRGB(160, 200, 225)
				v.Reflectance = 0.5
			elseif name == "leaf" or name == "leaves" or name == "grass_part" or name == "grass" then
				v.Material = Enum.Material.SmoothPlastic
				v.Color = Color3.fromRGB(30, 45, 35)
			end
		end
	end

	Lighting.Brightness = 1.4
	Lighting.Ambient = Color3.fromRGB(45, 60, 80)
	Lighting.OutdoorAmbient = Color3.fromRGB(75, 95, 120)
	Lighting.GlobalShadows = true
	Lighting.ShadowSoftness = 0.85
	Lighting.EnvironmentDiffuseScale = 1
	Lighting.EnvironmentSpecularScale = 1
	Lighting.ExposureCompensation = -0.1
	Lighting.FogColor = Color3.fromRGB(135, 155, 175)
	Lighting.FogStart = 20
	Lighting.FogEnd = 300 

	atmosphere.Density = 0.65 
	atmosphere.Offset = 0.25 
	atmosphere.Color = Color3.fromRGB(150, 170, 190)
	atmosphere.Decay = Color3.fromRGB(45, 55, 70) 
	atmosphere.Glare = 0.20 
	atmosphere.Haze = 2.5 

	colorCorrection.Brightness = 0.02
	colorCorrection.Contrast = 0.12 
	colorCorrection.Saturation = -0.15 
	colorCorrection.TintColor = Color3.fromRGB(225, 235, 255)

	bloom.Intensity = 0.75 
	bloom.Size = 45 
	bloom.Threshold = 1.3 

	sunRays.Intensity = 0.12 
	sunRays.Spread = 0.85 

	dof.FocusDistance = 35 
	dof.InFocusRadius = 45 
	dof.NearIntensity = 0.15 
	dof.FarIntensity = 0.75 

	if bgm.SoundId ~= "rbxassetid://1843477169" then
		bgm.SoundId = "rbxassetid://1843477169" 
		bgm.Volume = 2
		bgm:Play()
	end
end

local function applyPandoraTheme()
	-- AVATAR / PANDORA JUNGLE MAPPING
	for _, v in ipairs(Workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			local name = v.Name:lower()
			if name == "leaf" or name == "leaves" or name == "grass" or name == "vine" then 
				v.Material = Enum.Material.SmoothPlastic 
				v.Color = Color3.fromRGB(15, 160, 130) -- Bioluminescent emerald
			elseif name == "wood" or name == "tree" or name == "trunk" or name == "branch" then 
				v.Material = Enum.Material.Wood
				v.Color = Color3.fromRGB(30, 25, 35) 
			elseif name == "rock" or name == "stone" or name == "mountain" or name == "wall" or name == "concrete" then 
				v.Material = Enum.Material.Slate 
				v.Color = Color3.fromRGB(35, 40, 45) 
				v.Reflectance = 0.05
			elseif v.Material == Enum.Material.Water or v.Material == Enum.Material.Neon then 
				if v.Material ~= Enum.Material.Water then
					v.Color = Color3.fromRGB(40, 200, 255) 
				end
			end 
		end 
	end

	Lighting.Brightness = 1.4
	Lighting.Ambient = Color3.fromRGB(15, 30, 40)
	Lighting.OutdoorAmbient = Color3.fromRGB(35, 50, 60)
	Lighting.GlobalShadows = true
	Lighting.ShadowSoftness = 0.45
	Lighting.EnvironmentDiffuseScale = 0.5
	Lighting.EnvironmentSpecularScale = 1
	Lighting.ExposureCompensation = -0.1
	Lighting.FogColor = Color3.fromRGB(135, 155, 175)
	Lighting.FogStart = 60
	Lighting.FogEnd = 1000 

	atmosphere.Density = 0.40
	atmosphere.Offset = 0.33
	atmosphere.Color = Color3.fromRGB(180, 190, 210)
	atmosphere.Decay = Color3.fromRGB(75, 85, 90) 
	atmosphere.Glare = 0.30 
	atmosphere.Haze = 2

	colorCorrection.Brightness = 0.01
	colorCorrection.Contrast = 0.13
	colorCorrection.Saturation = -0.1
	colorCorrection.TintColor = Color3.fromRGB(225, 235, 255)

	bloom.Intensity = 0.3
	bloom.Size = 25
	bloom.Threshold = 2

	sunRays.Intensity = 0.1
	sunRays.Spread = 0.6

	dof.FocusDistance = 45
	dof.InFocusRadius = 65
	dof.NearIntensity = 0.1
	dof.FarIntensity = 0.6



	if bgm.SoundId ~= "rbxassetid://9043217032" then
		bgm.SoundId = "rbxassetid://9043217032" 
		bgm.Volume = 2
		bgm:Play()
	end
end

local function applyDayTheme()
	-- BRIGHT DAY (Fixed distant blackness)
	for _, v in ipairs(Workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			local name = v.Name:lower()
			if name == "street" or name == "road" or name == "asphalt" then
				v.Material = Enum.Material.SmoothPlastic
				v.Color = Color3.fromRGB(25, 25, 28)
				v.Reflectance = 0.02 
			elseif name == "wall" or name == "concrete" or name == "building" then
				v.Material = Enum.Material.SmoothPlastic
				v.Color = Color3.fromRGB(100, 100, 105) 
			elseif v.Material == Enum.Material.Glass or name == "window" or name == "glass" then
				v.Color = Color3.fromRGB(150, 180, 210) 
			elseif name == "leaf" or name == "leaves" or name == "grass_part" or name == "grass" then
				v.Material = Enum.Material.SmoothPlastic
				v.Color = Color3.fromRGB(45, 75, 45) 
			end
		end
	end

	Lighting.Brightness = 3
	Lighting.Ambient = Color3.fromRGB(0, 0, 0) 
	Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0) 
	Lighting.GlobalShadows = true
	Lighting.ShadowSoftness = 0
	Lighting.EnvironmentDiffuseScale = 1
	Lighting.EnvironmentSpecularScale = 1
	Lighting.ExposureCompensation = 0.0 
	
	-- Fixed Fog & Decay to create a bright, clear distance instead of black
	Lighting.FogColor = Color3.fromRGB(160, 180, 210) 
	Lighting.FogStart = 60
	Lighting.FogEnd = 2000 

	atmosphere.Density = 0.2 
	atmosphere.Offset = 0.40
	atmosphere.Color = Color3.fromRGB(200, 220, 240) 
	atmosphere.Decay = Color3.fromRGB(140, 160, 190) -- Bright, hazy blue for realistic distant horizons
	atmosphere.Glare = 0.40 
	atmosphere.Haze = 1.2  

	colorCorrection.Brightness = 0.0
	colorCorrection.Contrast = 0.1
	colorCorrection.Saturation = 0.1
	colorCorrection.TintColor = Color3.fromRGB(255, 255, 255) 

	bloom.Intensity = 0.1
	bloom.Size = 12         
	bloom.Threshold = 2.5   

	sunRays.Intensity = 0.1 
	sunRays.Spread = 0.3    

	dof.FocusDistance = 50  
	dof.InFocusRadius = 100   
	dof.NearIntensity = 0.0  
	dof.FarIntensity = 0.2  

	if bgm.SoundId ~= "rbxassetid://9114892930" then
		bgm.SoundId = "rbxassetid://9114892930"
		bgm.Volume = 2
		bgm:Play()
	end
end

local function applySunsetTheme()
	-- SOFT BEAUTIFUL SUNSET (Less intense orange, more golden/peach)
	for _, v in ipairs(Workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			local name = v.Name:lower()
			if name == "street" or name == "road" or name == "asphalt" then 
				v.Material = Enum.Material.SmoothPlastic 
				v.Color = Color3.fromRGB(45, 42, 45) 
				v.Reflectance = 0.02 
			elseif name == "wall" or name == "concrete" or name == "building" then 
				v.Material = Enum.Material.SmoothPlastic 
				v.Color = Color3.fromRGB(225, 215, 205) 
			elseif v.Material == Enum.Material.Glass or name == "window" or name == "glass" then 
				v.Material = Enum.Material.Glass
				v.Color = Color3.fromRGB(255, 190, 170) 
				v.Reflectance = 0.5 
			elseif name == "leaf" or name == "leaves" or name == "grass_part" or name == "grass" then 
				v.Material = Enum.Material.SmoothPlastic 
				v.Color = Color3.fromRGB(75, 85, 65) 
			end 
		end 
	end

	Lighting.Brightness = 3.2 
	Lighting.Ambient = Color3.fromRGB(70, 60, 85) 
	Lighting.OutdoorAmbient = Color3.fromRGB(150, 110, 120) 
	Lighting.GlobalShadows = true
	Lighting.ShadowSoftness = 0.8 
	Lighting.EnvironmentDiffuseScale = 0.8
	Lighting.EnvironmentSpecularScale = 0.6 
	Lighting.ExposureCompensation = 0.05 
	
	-- Softened fog and atmosphere to a gentle golden pink/peach
	Lighting.FogColor = Color3.fromRGB(235, 120, 120) -- Warm soft red
	Lighting.FogStart = 60
	Lighting.FogEnd = 1000 

	atmosphere.Density = 0.30
	atmosphere.Offset = 0.20 
	atmosphere.Color = Color3.fromRGB(255, 140, 140) -- Soft warm red
	atmosphere.Decay = Color3.fromRGB(180, 110, 140) -- Soft pinkish purple horizon
	atmosphere.Glare = 0.85 
	atmosphere.Haze = 1.8

	colorCorrection.Brightness = 0.03
	colorCorrection.Contrast = 0.12 
	colorCorrection.Saturation = 0.15 -- Pulled down from 0.35 so it's not blindingly orange
	colorCorrection.TintColor = Color3.fromRGB(255, 245, 235)

	bloom.Intensity = 0.55 
	bloom.Size = 35 
	bloom.Threshold = 1.8 

	sunRays.Intensity = 0.65 
	sunRays.Spread = 0.75 

	dof.FocusDistance = 45 
	dof.InFocusRadius = 60 
	dof.NearIntensity = 0.0 
	dof.FarIntensity = 0.35 

	if bgm.SoundId ~= "rbxassetid://9039644075" then
		bgm.SoundId = "rbxassetid://9039644075" 
		bgm.Volume = 2
		bgm:Play()
	end
end

local function applyNightTheme()
	-- CYBERPUNK WET CITY MAPPING
	for _, v in ipairs(Workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			local name = v.Name:lower()
			if name == "street" or name == "road" or name == "asphalt" then 
				v.Material = Enum.Material.SmoothPlastic 
				v.Color = Color3.fromRGB(15, 15, 20) 
				v.Reflectance = 0.35 
			elseif name == "wall" or name == "concrete" or name == "building" then 
				v.Material = Enum.Material.SmoothPlastic 
				v.Color = Color3.fromRGB(20, 22, 28) 
				v.Reflectance = 0.05
			elseif v.Material == Enum.Material.Glass or name == "window" or name == "glass" then 
				v.Material = Enum.Material.Glass
				v.Color = Color3.fromRGB(0, 10, 20) 
				v.Reflectance = 0.6 
			elseif name == "leaf" or name == "leaves" or name == "grass_part" then 
				v.Material = Enum.Material.SmoothPlastic 
				v.Color = Color3.fromRGB(10, 15, 20) 
			end 
		end 
	end

	Lighting.Brightness = 2.5
	Lighting.Ambient = Color3.fromRGB(100, 110, 120) 
	Lighting.OutdoorAmbient = Color3.fromRGB(100,110,120) 
	Lighting.GlobalShadows = true
	Lighting.ShadowSoftness = 0.15 
	Lighting.EnvironmentDiffuseScale = 0.3 
	Lighting.EnvironmentSpecularScale = 1.0 
	Lighting.ExposureCompensation = -0.3 
	Lighting.FogColor = Color3.fromRGB(10, 12, 25)
	Lighting.FogStart = 30
	Lighting.FogEnd = 400 

	atmosphere.Density = 1
	atmosphere.Offset = 0.25 
	atmosphere.Color = Color3.fromRGB(25, 40, 75) 
	atmosphere.Decay = Color3.fromRGB(15, 5, 25) 
	atmosphere.Glare = 0.0 
	atmosphere.Haze = 0.5

	colorCorrection.Brightness = 0.02
	colorCorrection.Contrast = 0.1
	colorCorrection.Saturation = 0.25 
	colorCorrection.TintColor = Color3.fromRGB(210, 235, 255)

	bloom.Intensity = 0.5
	bloom.Size = 28 
	bloom.Threshold = 0.2

	sunRays.Intensity = 0 -- Turn off for night
	sunRays.Spread = 0

	dof.FocusDistance = 35 
	dof.InFocusRadius = 50 
	dof.NearIntensity = 0.15 
	dof.FarIntensity = 0.65 

	if bgm.SoundId ~= "rbxassetid://9043232847" then
		bgm.SoundId = "rbxassetid://9043232847" 
		bgm.Volume = 0.55
		bgm:Play()
	end
end

-- =====================================================================
-- TIME TRACKER & STATE MANAGER
-- =====================================================================

local function updateEnvironmentByTime()
	local clockTime = Lighting.ClockTime
	local targetTheme = ""

	-- Phase logic
	if clockTime >= 6 and clockTime < 8 then
		targetTheme = "Morning"
	elseif clockTime >= 8 and clockTime < 12 then
		targetTheme = "Pandora"
	elseif clockTime >= 12 and clockTime < 16 then
		targetTheme = "Day"
	elseif clockTime >= 16 and clockTime < 18 then
		targetTheme = "Sunset"
	else
		-- 17 to 24, and 0 to 6
		targetTheme = "Night"
	end

	-- Only run the heavy material/color adjustments if the phase actually changed
	if currentTheme ~= targetTheme then
		currentTheme = targetTheme
		
		if targetTheme == "Morning" then
			applyMorningTheme()
		elseif targetTheme == "Pandora" then
			applyPandoraTheme()
		elseif targetTheme == "Day" then
			applyDayTheme()
		elseif targetTheme == "Sunset" then
			applySunsetTheme()
		elseif targetTheme == "Night" then
			applyNightTheme()
		end
	end
end

-- Initialize the environment on load
updateEnvironmentByTime()

-- Listen for time changes
Lighting:GetPropertyChangedSignal("ClockTime"):Connect(updateEnvironmentByTime)
