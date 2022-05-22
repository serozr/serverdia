local COMMAND = {}

COMMAND.name = "command" 

COMMAND.commands = {}
COMMAND.prefix = "!"

function COMMAND.SetPrefix(command)
	COMMAND.prefix = command or "!"
end

function COMMAND.GetPrefix()
	return command.prefix
end


function COMMAND.Register(command, desc, func)
	if not command then
		print("[COMMAND]", "[Error]", "Invalid command name given")
		return
	end

	if not func then
		print("[COMMAND]", "[Error]", "Invalid callback function given")
		return
	end

	command = string.lower(command)

	COMMAND.commands[command] = {
		command = command,
		desc = desc or "n/a",
		func = func
	}

	print("[COMMAND]", "The command", command, "has now been registered")
end


function COMMAND.GetCommand(command)
	return COMMAND.commands[command] or false
end


function COMMAND.FormatArguments(args)
	local Start, End = nil, nil

	for k, v in pairs(args) do
		if (string.sub(v, 1, 1) == "\"") then
			Start = k
		elseif Start and (string.sub(v, string.len(v), string.len(v)) == "\"") then
			End = k
			break
		end
	end

	if Start and End then
		args[Start] = string.Trim(table.concat(args, " ", Start, End), "\"")

		for i = 1, (End - Start) do
			table.remove(args, Start + 1)
		end

		args = command.FormatArguments(args)
	end

	return args
end

if CONFIG.commandEvent then
	CLIENT:on("messageCreate", function(msg)

		local author = msg.author

		local content = msg.content

		if author == CLIENT.user then return end

		if author.bot then return end

		local prefix = command.GetPrefix()

		if not (string.sub(content, 1, string.len(prefix)) == prefix) then
			return
		end

		local args = command.FormatArguments(string.Explode(" ", content))

		args[1] = string.sub(args[1], string.len(prefix) + 1)

		local command = command.GetCommand(string.lower(args[1]))

		if not command then print("Invalid command", "'"..args[1].."'") return end

		table.remove(args, 1)

		command.func(msg, args)
	end)
end

return COMMAND
