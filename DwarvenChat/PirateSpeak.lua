-- PirateSpeak by Blaquen - Black DragonFlight - lkraven@gmail.com
-- Currently maintained and updated by Imyself <Savvy> - Echo Isles (www.savvyguild.com)

-- Create our LibDataBroker Object
local ldb = LibStub:GetLibrary("LibDataBroker-1.1");
local psBroker = ldb:NewDataObject("PirateSpeak", { 
	type = "data source",
	label = "Pirate Speak", 
	icon = "Interface\\AddOns\\PirateSpeak\\icon",
	text = "--"
	}
	)


-- Event Handler
local function OnEvent(self, event, addOnName)
	if event == "ADDON_LOADED" and addOnName:lower() == "piratespeak" then

		-- Build our slash commands
		PirateSpeak_OnLoad()

		-- set saved variables for first time users		
		if pirate_talk_on == nil then
   			pirate_talk_on = 1;
  		end
  		if pirate_strict_on == nil then
   			pirate_strict_on = 0; 
  		end

		--  Get our speak tables
		if speakDB == nil then
			CreateSpeakDB()
		end 
			

		-- set the status text of our LDB object
		if (pirate_talk_on == 1) then
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
local psFrame = CreateFrame("FRAME", "PirateSpeak");
psFrame:RegisterEvent("ADDON_LOADED");
psFrame:RegisterEvent("PLAYER_LOGOUT"); 
psFrame:SetScript("OnEvent", OnEvent);


function PirateSpeak_OnLoad()

	-- Create our slash commands
	SlashCmdList["PIRATESPEAKTOGGLE"] = pirate_toggle;
	SLASH_PIRATESPEAKTOGGLE1 = "/dwarfspeak";
	SLASH_PIRATESPEAKTOGGLE2 = "/dpeak";
	SlashCmdList["PSAY"] = pirate_say;
	SLASH_PSAY1 = "/ds";
	SLASH_PSAY2 = "/dsay";
	SlashCmdList["DYELL"] = pirate_yell;
	SLASH_PYELL1 = "/dy";
	SLASH_PYELL2 = "/dyell";
	SlashCmdList["DPARTY"] = pirate_party;
	SLASH_PPARTY1 = "/dp";
	SLASH_PPARTY2 = "/dparty";
	SlashCmdList["DGUILD"] = pirate_guild;
	SLASH_PGUILD1 = "/dg";
	SLASH_PGUILD2 = "/dguild";
	SlashCmdList["DSTRICTTOGGLE"] = pirate_strict;
	SLASH_PSTRICTTOGGLE1 = "/dstrict";

	-- announce addon load
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("Dwarven Accent loaded!");
	end
end


-- Blizzard function to be hooked
local PirateSpeak_SendChatMessage = SendChatMessage;

-- Wintertime and Dwarf Accent conflict.
-- If we detect Wintertime we'll note the channel and stay off of it
local wtID, wtName = GetChannelName("WinterTimeGlobal")

function SendChatMessage(msg, system, language, chatnumber) 
	--DEFAULT_CHAT_FRAME:AddMessage("Channel ID: "..chatnumber.." message: "..msg.." ChannelName: "..wtID .. ", " .. wtName);
    if (pirate_talk_on == 1 and msg ~= "" and (string.find(msg, "%[") == nil)) then 
	if ( string.find(msg, "^%/") == nil ) and (chatnumber ~= wtID) then
          msg = piratespeak(msg);
	end
    end
    PirateSpeak_SendChatMessage(msg, system, language, chatnumber);
end 


function prepend_pirate(inputString)
	local phrase_array = speakDB["pirateSpeak_PrependDB"]
	if (pirate_strict_on == 0) then
		inputString = phrase_array[math.random(table.getn(phrase_array))]..inputString
	end
	return inputString
end

function append_pirate(inputString)
 	local phrase_array = speakDB["pirateSpeak_AppendDB"]
	if (pirate_strict_on == 0) then
		inputString = string.gsub(inputString, '([%.%!%?])', phrase_array[math.random(table.getn(phrase_array))].."%1",1)
	end 
	return inputString
end

function sub_pirate(inputString)

	local cur_sub = {}
	local sub_array = speakDB["pirateSpeak_ReplaceDB"]
	
	inputString = string.gsub(inputString, "(%s)", inject_pirate)

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

function inject_pirate(inputString)
	if ( math.random(100) > 98 and pirate_strict_on == 0) then
		inputString = ", yarrr, "
	end
	return inputString
end

-- function piratespeak(x)
-- 	x = sub_pirate(x)
-- 	if (math.random(100) > 75 ) then
-- 		x = append_pirate(x)
-- 	else
-- 		if(math.random(100) > 50 and pirate_strict_on == 0) then
-- 			x = x .. " Bwaha!"
-- 		end
-- 	end
-- 	if ( math.random(100) > 75 ) then
-- 		x = prepend_pirate(x)
-- 	end
-- 	return x;
-- end

function pirate_toggle(toggle)
	if ( toggle == "on" ) then
		pirate_talk_on = 1
		psBroker.text = "|c0000FF00ON|r"
		DEFAULT_CHAT_FRAME:AddMessage("Dwarf Accent On")
	elseif ( toggle == "off" ) then
		pirate_talk_on = 0
		psBroker.text = "|c00FF0000OFF|r"
		DEFAULT_CHAT_FRAME:AddMessage("Dwarf Accent off")
	else	
		DEFAULT_CHAT_FRAME:AddMessage(pirate_helptext(helptext))
	end
end

function pirate_strict(toggle)
	if ( toggle == "on" ) then
		pirate_strict_on = 1
		DEFAULT_CHAT_FRAME:AddMessage("Pirate Speak append, prepend and inject phrases are off")
	elseif ( toggle == "off" ) then
		pirate_strict_on = 0
		DEFAULT_CHAT_FRAME:AddMessage("Pirate Speak append, prepend and inject phrases are on")
	else
		helptext = ""
		DEFAULT_CHAT_FRAME:AddMessage(pirate_helptext(helptext))
	end
end

function pirate_helptext(helptext)
	helptext = "/pspeak (" 
	if (pirate_talk_on == 1) then
		helptext = helptext .. "|c0000FF00on|r|off)"
	else
		helptext = helptext .. "on| |c00FF0000off|r)"
	end
	helptext = helptext .. ": toggle global pirate talk\n/ps,/psay: say something in pirate\n/py,/pyell: yell something in pirate\n/pp,/pparty: party talk something in pirate\n/pg, /pguild: guildtalk in pirate\n/"
	helptext = helptext .. "pstrict ("
	if (pirate_strict_on == 1) then
		helptext = helptext .. "|c0000FF00on|r|off)"
	else
		helptext = helptext .. "on| |c00FF0000off|r)"
	end
	helptext = helptext .. " enables/disables prepend, apend and inject phrases\n"
	return helptext
end


function pirate_say(x)
	x = piratespeak(x)
	SendChatMessage(x);
end

function pirate_yell(x)
	x = piratespeak(x)
	SendChatMessage(x,"YELL");
end

function pirate_party(x)
	x = piratespeak(x)
	SendChatMessage(x,"PARTY");
end

function pirate_guild(x)
	x = piratespeak(x)
	SendChatMessage(x,"GUILD");
end

-- LibDataBroker Functions

-- Create the LDB tooltip
function psBroker:OnTooltipShow()
	statusLine = "Pirate Speak is "
	if (pirate_talk_on == 1) then
		statusLine = statusLine .. "|c0000FF00ON|r"
		if (pirate_strict_on == 1) then
			statusLine = statusLine .. " (strict mode)"			
		else
			statusLine = statusLine .. " (verbose mode)"
		end
	else
		statusLine = statusLine .. "|c00FF0000OFF|r"
	end 
	self:AddLine(statusLine);
	self:AddLine("Left Click toggles Pirate Speak on and off", 1, 1, 1);
    	self:AddLine("Right Click toggles betrween strict and verbose", 1, 1, 1);
    	self:AddLine(" ", 1, 1, 1);
    	self:AddLine("type: /pspeak for command line options", 1, 1, 1);
   
end


-- Toggles functions based on LDB button clicks
function psBroker:OnClick(button)
	if button== "LeftButton" then
		if (pirate_talk_on == 1) then
			pirate_toggle("off")
			psBroker.text = "|c00FF0000OFF|r"
		else
			pirate_toggle("on")
			psBroker.text = "|c0000FF00ON |r"
		end
	elseif button== "RightButton" then
		if (pirate_strict_on == 1) then
			pirate_strict("off")
		else
			pirate_strict("on")
		end
	end
end

-- Create default speak tables

function CreateSpeakDB()
	-- local pirateSpeak_PrependDB = {
	-- "Aye, ",
	-- }
	-- local pirateSpeak_AppendDB = {
	-- ", ye scurvy dog",
	-- ", matey",
	-- ", or I not be a pirate.  Arrr",
	-- ", by the briny deep",
	-- ", arrrr",
	-- ", landlubber",
	-- ", arrr",
	-- ", arr",
	-- ", yarrr",
	-- ", yarr",
	-- ", thar she blows",
	-- ", scurvy scum",
	-- ", swabby",
	-- ", ye old dog",
	-- ", ye dog",
	-- ", salty dog"
	-- }
	local pirateSpeak_ReplaceDB = {
	{o={"^hello","^hiya","^hi there", "^hey"}, r={"Well met","E'llo","ahoy thar"}},
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

	speakDB["pirateSpeak_PrependDB"] = pirateSpeak_PrependDB
	speakDB["pirateSpeak_AppendDB"] = pirateSpeak_AppendDB
	speakDB["pirateSpeak_ReplaceDB"] = pirateSpeak_ReplaceDB


	DEFAULT_CHAT_FRAME:AddMessage("speakDB initialized");
		
end