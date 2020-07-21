## IOS Pythonista dropbox sync scripts.
# Designed, Maintained and updated by Gruzzly

# 1.0.5 7/15/2020
Created Readme

# What is it?
It is a set of scripts used to sync to and from Pythonista on IOS.
# How does it work?
It uses your credentials from your dropbox API and then makes sure you can actually upload to it. After doing that, it will check your dropbox for any conflicts. If there is any, it will ask you how you want to handle it. Then it will push your file sto you drop box.
It will run through the same thing on the way back when you sync from your drop box.
## Comparing of files locally and in the dropbox.
```python
for file in folder_metadata['contents']:
		dropbox_path = file['path'][1:]
		file_name = file['path'].split('/')[-1]
		
		file_ext = os.path.splitext(file_name)[1]
		
		if file['is_dir'] == False and (file_ext in config['file_extensions'] or [m.group(0) for l in config['file_extensions'] for m in [re.match('[\.]?\*',l)] if m]):

			if not os.path.exists(os.path.join(PYTHONISTA_DOC_DIR, dropbox_path)):
 ```
## Creation of dropbox config.
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
		
		logging.info('Insert APP key and Secret')
		
		config['APP_KEY'] = input('''Enter your app key
''')
		config['APP_SECRET'] = input('''Enter your app secret
''')
		
		config['ACCESS_TYPE'] = 'app_folder'
		

		write_configuration(config)
			
	return config
  ```



## How to use
- Edit file credentials
- Download onto your phone
- Open in pythonista
- run scripts







### Contact and links
- [Github](https://github.com/Gruzzly-bear)
- [Email](mailto:MB.Bowen@outlook.com?subject=Hey%20There!)
- [Website](https://gruzzly.co)

