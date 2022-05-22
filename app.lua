
local fs = require('fs') 
local discordia = require("discordia")
discordia.extensions()
_G.CLIENT = discordia.Client()

_G.CONFIG = require("./config.lua")


print("[LIBRARIES]", "Loading library files")
for k, v in fs.scandirSync("./lib") do
	print("[LIBRARIES]", "Loading:", k)
	local data = require("./lib/"..k)
	print("	", "[LIBRARIES]", "Success:", k, "has been loaded.")
end


print("[HANDLERS]", "Loading handler files")
for k, v in fs.scandirSync("./handler") do
	print("[HANDLERS]", "Loading:", k)
	local data = require("./handler/"..k)
	if not data.name then
		print("	", "[HANDLERS]", "Error:", k, "does not have a valid name!")
	elseif _G[data.name] then
		print("	", "[HANDLERS]", "Error:", k, "has a name which is already registered as a handler. The name is", data.name)
	else
		_G[data.name] = data
		print("	", "[HANDLERS]", "Success:", k, "has been loaded with the name", data.name)
	end
end


print("[CMDS]", "Loading command files")
for k, v in fs.scandirSync("./commands") do
	print("[CMDS]", "Loading:", k)
	local data = require("./commands/"..k)
	print("	", "[CMDS]", "Success:", k, "has been loaded.")
end


print("[EVENTS]", "Loading command files")
for k, v in fs.scandirSync("./events") do
	print("[EVENTS]", "Loading:", k)
	local data = require("./events/"..k)
	print("	", "[EVENTS]", "Success:", k, "has been loaded.")
end

CLIENT:run('Bot '..CONFIG.token)