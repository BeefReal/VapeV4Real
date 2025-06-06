-- Define utility functions
local function isfile(path)
    local ok, result = pcall(function() return readfile(path) end)
    return ok and result ~= nil and result ~= ""
end

local function downloadFile(url, path)
    if not isfile(path) then
        local success, response = pcall(function()
            return game:HttpGet(url)
        end)
        if success then
            writefile(path, response)
            print("[VisualWave] Downloaded: " .. path)
        else
            warn("[VisualWave] Failed to download: " .. path)
        end
    else
        print("[VisualWave] Already exists: " .. path)
    end
end

-- Create folder structure
local folders = {
    "VisualWave",
    "VisualWave/gui",
    "VisualWave/modules",
    "VisualWave/assets",
}

for _, folder in ipairs(folders) do
    if not isfolder(folder) then
        makefolder(folder)
        print("[VisualWave] Created folder: " .. folder)
    end
end

-- Download files into correct folders
local baseURL = "https://raw.githubusercontent.com/BeefReal/VisualWave-V1/main/"

local filesToDownload = {
    ["VisualWave/MainScript.lua"] = baseURL .. "MainScript.lua",
    ["VisualWave/Loader.lua"] = baseURL .. "Loader.lua",
    ["VisualWave/gui/custom_gui.lua"] = baseURL .. "gui/custom_gui.lua",
    ["VisualWave/modules/Fly.lua"] = baseURL .. "modules/Fly.lua",
    ["VisualWave/modules/InfiniteJump.lua"] = baseURL .. "modules/InfiniteJump.lua",
    ["VisualWave/README.md"] = baseURL .. "README.md",
}

for path, url in pairs(filesToDownload) do
    downloadFile(url, path)
end

-- Load GUI automatically
local guiPath = "VisualWave/gui/custom_gui.lua"
if isfile(guiPath) then
    loadstring(readfile(guiPath))()
else
    warn("[VisualWave] GUI script not found: " .. guiPath)
end
