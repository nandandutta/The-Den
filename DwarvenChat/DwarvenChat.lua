-- Currently maintained, designed and updated by Gruzzly

-- Create our LibDataBroker Object
local ldb = LibStub:GetLibrary("LibDataBroker-1.1");
local psBroker = ldb:NewDataObject("DwarvenChat", { 
	type = "data source",
	label = "DwarvenChat", 
	icon = "Interface\\AddOns\\DwarvenChat\\icon",
	text = "--"
	}
	)


-- Event Handler
local function OnEvent(self, event, addOnName)
	if event == "ADDON_LOADED" and addOnName:lower() == "DwarvenChat" then

		-- Build our slash commands
		DwarvenChat_OnLoad()

		-- set saved variables for first time users		
		if Dwarven_talk_on == nil then
   			Dwarven_talk_on = 1;
  		end
  		if Dwarven_strict_on == nil then
   			Dwarven_strict_on = 0; 
  		end

		--  Get our speak tables
		if speakDB == nil then
			CreateSpeakDB()
		end 
			

		-- set the status text of our LDB object
		if (Dwarven_talk_on == 1) then
			psBroker.text = "|c0000FF00ON |r"
		else
			psBroker.text = "|c00FF0000OFF|r"
		end		
 	elseif event == "PLAYER_LOGOUT" then
		
	end
	OnEvent= nil;
	self:SetScript("OnEvent",nil);
end

-- Create our frame
local psFrame = CreateFrame("FRAME", "DwarvenChat");
psFrame:RegisterEvent("ADDON_LOADED");
psFrame:RegisterEvent("PLAYER_LOGOUT"); 
psFrame:SetScript("OnEvent", OnEvent);


function DwarvenChat_OnLoad()

	-- Create our slash commands
	SlashCmdList["DwarvenChatTOGGLE"] = Dwarven_toggle;
	SLASH_DwarvenChatTOGGLE1 = "/dwarfspeak";
	SLASH_DwarvenChatTOGGLE2 = "/dpeak";
	SlashCmdList["PSAY"] = Dwarven_say;
	SLASH_PSAY1 = "/ds";
	SLASH_PSAY2 = "/dsay";
	SlashCmdList["DYELL"] = Dwarven_yell;
	SLASH_PYELL1 = "/dy";
	SLASH_PYELL2 = "/dyell";
	SlashCmdList["DPARTY"] = Dwarven_party;
	SLASH_PPARTY1 = "/dp";
	SLASH_PPARTY2 = "/dparty";
	SlashCmdList["DGUILD"] = Dwarven_guild;
	SLASH_PGUILD1 = "/dg";
	SLASH_PGUILD2 = "/dguild";
	SlashCmdList["DSTRICTTOGGLE"] = Dwarven_strict;
	SLASH_DSTRICTTOGGLE1 = "/dstrict";

	-- announce addon load
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("Dwarven Accent loaded!");
	end
end


-- Blizzard function to be hooked
local DwarvenChat_SendChatMessage = SendChatMessage;

-- Wintertime and Dwarf Accent conflict.
-- If we detect Wintertime we'll note the channel and stay off of it
local wtID, wtName = GetChannelName("WinterTimeGlobal")

function SendChatMessage(msg, system, language, chatnumber) 
	--DEFAULT_CHAT_FRAME:AddMessage("Channel ID: "..chatnumber.." message: "..msg.." ChannelName: "..wtID .. ", " .. wtName);
    if (Dwarven_talk_on == 1 and msg ~= "" and (string.find(msg, "%[") == nil)) then 
	if ( string.find(msg, "^%/") == nil ) and (chatnumber ~= wtID) then
          msg = DwarvenChat(msg);
	end
    end
    DwarvenChat_SendChatMessage(msg, system, language, chatnumber);
end 


function prepend_Dwarven(inputString)
	local phrase_array = speakDB["DwarvenChat_PrependDB"]
	if (Dwarven_strict_on == 0) then
		inputString = phrase_array[math.random(table.getn(phrase_array))]..inputString
	end
	return inputString
end

function append_Dwarven(inputString)
 	local phrase_array = speakDB["DwarvenChat_AppendDB"]
	if (Dwarven_strict_on == 0) then
		inputString = string.gsub(inputString, '([%.%!%?])', phrase_array[math.random(table.getn(phrase_array))].."%1",1)
	end 
	return inputString
end

function sub_Dwarven(inputString)

	local cur_sub = {}
	local sub_array = speakDB["DwarvenChat_ReplaceDB"]
	
	inputString = string.gsub(inputString, "(%s)", inject_Dwarven)

	for i = 1, table.getn( sub_array ) do
		cur_sub['o']=sub_array[i]['o']
		cur_sub['r']=sub_array[i]['r']
		for y = 1, table.getn(cur_sub.o) do
			local searchPtn = cur_sub.o[y]
			inputString = string.gsub(inputString, searchPtn, cur_sub.r[math.random(table.getn(cur_sub.r))])
			if ( string.find(searchPtn, "%%") == nil ) then 
				inputString = string.gsub(inputString, string.gsub(searchPtn, "%l", string.upper,1), string.gsub(cur_sub.r[math.random(table.getn(cur_sub.r))], "%l", string.upper,1))
			end
			if ( string.find(searchPtn, "%%") == nil ) then 
				inputString = string.gsub(inputString, string.gsub(searchPtn, "%l", string.upper), string.gsub(cur_sub.r[math.random(table.getn(cur_sub.r))], '%l', string.upper))
			end
		end
	end
	return inputString
end

function inject_Dwarven(inputString)
	if ( math.random(100) > 98 and Dwarven_strict_on == 0) then
		inputString = ", yarrr, "
	end
	return inputString
end

-- function DwarvenChat(x)
-- 	x = sub_Dwarven(x)
-- 	if (math.random(100) > 75 ) then
-- 		x = append_Dwarven(x)
-- 	else
-- 		if(math.random(100) > 50 and Dwarven_strict_on == 0) then
-- 			x = x .. " Bwaha!"
-- 		end
-- 	end
-- 	if ( math.random(100) > 75 ) then
-- 		x = prepend_Dwarven(x)
-- 	end
-- 	return x;
-- end

function Dwarven_toggle(toggle)
	if ( toggle == "on" ) then
		Dwarven_talk_on = 1
		psBroker.text = "|c0000FF00ON|r"
		DEFAULT_CHAT_FRAME:AddMessage("Dwarf Accent On")
	elseif ( toggle == "off" ) then
		Dwarven_talk_on = 0
		psBroker.text = "|c00FF0000OFF|r"
		DEFAULT_CHAT_FRAME:AddMessage("Dwarf Accent off")
	else	
		DEFAULT_CHAT_FRAME:AddMessage(Dwarven_helptext(helptext))
	end
end

function Dwarven_strict(toggle)
	if ( toggle == "on" ) then
		Dwarven_strict_on = 1
		DEFAULT_CHAT_FRAME:AddMessage("DwarvenChat append, prepend and inject phrases are off")
	elseif ( toggle == "off" ) then
		Dwarven_strict_on = 0
		DEFAULT_CHAT_FRAME:AddMessage("DwarvenChat append, prepend and inject phrases are on")
	else
		helptext = ""
		DEFAULT_CHAT_FRAME:AddMessage(Dwarven_helptext(helptext))
	end
end

function Dwarven_helptext(helptext)
	helptext = "/dchat (" 
	if (Dwarven_talk_on == 1) then
		helptext = helptext .. "|c0000FF00on|r|off)"
	else
		helptext = helptext .. "on| |c00FF0000off|r)"
	end
	helptext = helptext .. ": toggle global Dwarven talk\n/ds,/dsay: say something in Dwarven\n/dy,/dyell: yell something in Dwarven\n/dp,/dparty: party talk something in Dwarven\n/dg, /dguild: guildtalk in Dwarven\n/"
	helptext = helptext .. "dstrict ("
	if (Dwarven_strict_on == 1) then
		helptext = helptext .. "|c0000FF00on|r|off)"
	else
		helptext = helptext .. "on| |c00FF0000off|r)"
	end
	helptext = helptext .. " enables/disables prepend, apend and inject phrases\n"
	return helptext
end


function Dwarven_say(x)
	x = DwarvenChat(x)
	SendChatMessage(x);
end

function Dwarven_yell(x)
	x = DwarvenChat(x)
	SendChatMessage(x,"YELL");
end

function Dwarven_party(x)
	x = DwarvenChat(x)
	SendChatMessage(x,"PARTY");
end

function Dwarven_guild(x)
	x = DwarvenChat(x)
	SendChatMessage(x,"GUILD");
end

-- LibDataBroker Functions

-- Create the LDB tooltip
function psBroker:OnTooltipShow()
	statusLine = "DwarvenChat is "
	if (Dwarven_talk_on == 1) then
		statusLine = statusLine .. "|c0000FF00ON|r"
		if (Dwarven_strict_on == 1) then
			statusLine = statusLine .. " (strict mode)"			
		else
			statusLine = statusLine .. " (verbose mode)"
		end
	else
		statusLine = statusLine .. "|c00FF0000OFF|r"
	end 
	self:AddLine(statusLine);
	self:AddLine("Left Click toggles DwarvenChat on and off", 1, 1, 1);
    	self:AddLine("Right Click toggles betrween strict and verbose", 1, 1, 1);
    	self:AddLine(" ", 1, 1, 1);
    	self:AddLine("type: /dchat for command line options", 1, 1, 1);
   
end


-- Toggles functions based on LDB button clicks
function psBroker:OnClick(button)
	if button== "LeftButton" then
		if (Dwarven_talk_on == 1) then
			Dwarven_toggle("off")
			psBroker.text = "|c00FF0000OFF|r"
		else
			Dwarven_toggle("on")
			psBroker.text = "|c0000FF00ON |r"
		end
	elseif button== "RightButton" then
		if (Dwarven_strict_on == 1) then
			Dwarven_strict("off")
		else
			Dwarven_strict("on")
		end
	end
end

-- Create default speak tables

function CreateSpeakDB()
	-- local DwarvenChat_PrependDB = {
	-- "Aye, ",
	-- }
	-- local DwarvenChat_AppendDB = {
	-- ", Bwaha!",
	-- }
	local DwarvenChat_ReplaceDB = {
	{o={"^hello","^hiya","^hi there", "^hey"}, r={"Well met","E'llo"}},
	{o={"no", "nah"}, r={"nae"}},
	{o={"^no", "^nah"}, r={"^nae"}},
	{o={"the"}, r={"tha"}},
	{o={"^the"}, r={"^tha"}},
	{o={"you"}, r={"ye"}},
	{o={"don't", "Don't"}, r={"dinna"}},
	{o={"my"}, r={"me"}},
	{o={"^my"}, r={"^me"}},
	{o={"are"}, r={"be"}},
	{o={"^are"}, r={"^be"}},
	{o={"you"}, r={"ye"}},
	{o={"the"}, r={"tha"}},
	{o={"^the"}, r={"^tha"}},
	{o={"and"}, r={"^an"}},
	{o={"^and"}, r={"^an"}},
	{o={"can't"}, r={"kinna"}},
	{o={"not"}, r={"nae"}},
	
	}

	speakDB = {}	

	speakDB["DwarvenChat_PrependDB"] = DwarvenChat_PrependDB
	speakDB["DwarvenChat_AppendDB"] = DwarvenChat_AppendDB
	speakDB["DwarvenChat_ReplaceDB"] = DwarvenChat_ReplaceDB


	DEFAULT_CHAT_FRAME:AddMessage("speakDB initialized");
		
end