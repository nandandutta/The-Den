from facepy import GraphAPI
import configparser
import os
import random
from configparser import ConfigParser
from time import sleep
config = configparser.ConfigParser()
parser = ConfigParser()
parser.read("settings.cfg")  #Get config file from the executing directory.
config.read(os.path.join(os.path.dirname(__file__),"settings.cfg")) # Reads from the config file.
ACCESS_TOKEN=config.get('settings','ACCESS_TOKEN') # Pulls the token from the file and uses it in the code.
sleep_time = int(config.get("settings", "SLEEP")) # sleep for 1 second by default

while True:
	graph = GraphAPI(ACCESS_TOKEN)
	graph.post('me/feed', message=(random.choice(list(open('text.txt'))))) # Chooses a random text option to post to the facebook wall.


	print("Your post was posted!"); # Tells you that your post was posted via console.
	sleep(sleep_time)