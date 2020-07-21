# The Den

This repo is full of projects I have taken on personally or as a request for people.



# Projects and their descriptions.

## Dwarven Chat v1.0.5

# What is it?
This addon auto translates your input text and outputs modified text that resembles a dwarven accent.
## For example:
``` What are you saying? I can't hear you! ``` <br/>
becomes <br/>
``` What're ye sayin'? I cannae hear ye! ``` <br/>
This happens as soon as you press enter. It is very fast, and fluid.

# How does it work?
It creates the in game slash function on load. It creates local databases to pull and replace predefined text from.
### Creating the slash command for ingame use.
```lua
function DwarvenChat_OnLoad()

	
	SlashCmdList["DWARVENCHATTOGGLE"] = dwarven_toggle;
	SLASH_DWARVENCHATTOGGLE1 = "/dwarvenchat";
	SLASH_DWARVENCHATTOGGLE2 = "/dchat";
	SlashCmdList["DSAY"] = dwarven_say;
 ```

### Local Dwarven chat database creation for replacing words.
```lua
	local dwarvenChat_ReplaceDB = {
	{o={"^hello","^hiya","^hi there", "^hey"}, r={"Well met","E'llo"}},
	{o={"no", "nah"}, r={"nae"}},
	{o={"^no", "^nah"}, r={"^nae"}},
	{o={"the"}, r={"tha"}},
	}
```
### Hooking of blizzard function
```lua
local dwarvenChat_SendChatMessage = SendChatMessage;
```




 
 # Links
- [WoW Dwarven chat addon](https://github.com/Gruzzly-bear/The-Den/tree/master/DwarvenChat)
This add-on takes text input in real time and adds a dwarven accent to it.
- [IOS Pythonista Scripts](https://github.com/Gruzzly-bear/The-Den/tree/master/IOS%20Pythonista%20sync%20scripts)
These are useful scripts to sync to and from dropbox using pythonista on IOS.
- [Twitter post bot](https://github.com/Gruzzly-bear/The-Den/tree/master/TwitterBot)
This will automatically post to twitter using their API.
- [Facebook post bot](https://github.com/Gruzzly-bear/The-Den/tree/master/Facebook%20Bot)
This will automatically post text or images to your facebook wall.
- [Twitter Image Bot](https://github.com/Gruzzly-bear/The-Den/tree/master/Twitter%20Image%20Bot)
This was created before I added both images and texts into the final Twitter bot. This bot only pulls images and posts them. Great for Advertisements.
- [Websites](https://github.com/Gruzzly-bear/The-Den/tree/master/Websites)
A small repo of websites I have worked on and are still working on.
- [Python](https://github.com/Gruzzly-bear/The-Den/tree/master/python)
This is a repo consisting of random and uncategorized python scripts.
- [Telegram Bot](https://github.com/Gruzzly-bear/The-Den/tree/master/Telegram%20Bot)
This is an unfinished Telegram bot. It was to pull from a telegram chat and post to twitter.








### Contact and links
- [Github](https://github.com/Gruzzly-bear)
- [Email](mailto:MB.Bowen@outlook.com?subject=Hey%20There!)
- [Website](https://gruzzly.co)
