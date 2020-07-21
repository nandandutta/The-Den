# The Den

This repo is full of projects I have taken on personally or as a request for people.
Below is a quick summary of the projects and snippits of their features.



# Dwarven Chat v1.0.5

### What is it?
This addon auto translates your input text and outputs modified text that resembles a dwarven accent.
#### For example:
``` What are you saying? I can't hear you! ``` <br/>
becomes <br/>
``` What're ye sayin'? I cannae hear ye! ``` <br/>
This happens as soon as you press enter. It is very fast, and fluid.

### How does it work?
It creates the in game slash function on load. It creates local databases to pull and replace predefined text from.
#### Creating the slash command for ingame use.
```lua
function DwarvenChat_OnLoad()

	
	SlashCmdList["DWARVENCHATTOGGLE"] = dwarven_toggle;
	SLASH_DWARVENCHATTOGGLE1 = "/dwarvenchat";
	SLASH_DWARVENCHATTOGGLE2 = "/dchat";
	SlashCmdList["DSAY"] = dwarven_say;
 ```

#### Local Dwarven chat database creation for replacing words.
```lua
	local dwarvenChat_ReplaceDB = {
	{o={"^hello","^hiya","^hi there", "^hey"}, r={"Well met","E'llo"}},
	{o={"no", "nah"}, r={"nae"}},
	{o={"^no", "^nah"}, r={"^nae"}},
	{o={"the"}, r={"tha"}},
	}
```
#### Hooking of blizzard function
```lua
local dwarvenChat_SendChatMessage = SendChatMessage;
```

# IOS Pythonista dropbox sync scripts.

### What is it?
It is a set of scripts used to sync to and from Pythonista on IOS.
#### How does it work?
It uses your credentials from your dropbox API and then makes sure you can actually upload to it. After doing that, it will check your dropbox for any conflicts. If there is any, it will ask you how you want to handle it. Then it will push your file sto you drop box.
It will run through the same thing on the way back when you sync from your drop box.
#### Comparing of files locally and in the dropbox.
```python
for file in folder_metadata['contents']:
		dropbox_path = file['path'][1:]
		file_name = file['path'].split('/')[-1]
		
		file_ext = os.path.splitext(file_name)[1]
		
		if file['is_dir'] == False and (file_ext in config['file_extensions'] or [m.group(0) for l in config['file_extensions'] for m in [re.match('[\.]?\*',l)] if m]):

			if not os.path.exists(os.path.join(PYTHONISTA_DOC_DIR, dropbox_path)):
 ```
#### Creation of dropbox config.
```python
def setup_configuration():
	
	if not os.path.exists(SYNC_STATE_FOLDER):
		os.mkdir(SYNC_STATE_FOLDER)
	if os.path.exists(CONFIG_FILEPATH):
		with open(CONFIG_FILEPATH, 'r') as config_file:
			config = json.load(config_file)
	else:
		logging.log(FINE, 'Configuration file missing')
		config = {}
		
		logging.info('Get your app key and secret from the Dropbox developer website')
		
		config['APP_KEY'] = input('''Enter your app key
''')
		config['APP_SECRET'] = input('''Enter your app secret
''')
		
		# ACCESS_TYPE can be 'dropbox' or 'app_folder' as configured for your app
		config['ACCESS_TYPE'] = 'app_folder'
		
		
		# Write the config file back
		write_configuration(config)
			
	return config
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
