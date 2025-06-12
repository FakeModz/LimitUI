local Input = "./dist/main.lua"
local Header = "build/header.lua"
local Output = "./dist/main.lua"

local File = io.open(Header, "r")
if not File then
    error("Failed to open header file: " .. Header)
end
local HeaderContent = File:read("*all")
File:close()

File = io.open(Input, "r")
if not File then
    error("Failed to open input file: " .. Input)
end
local Content = File:read("*all")
File:close()

local NewContent = HeaderContent .. "\n\n" .. Content

File = io.open(Output, "w")
if not File then
    error("Failed to open output file: " .. Output)
end
File:write(NewContent)
File:close()

print("\n✓ Done! Check /dist/main.lua")