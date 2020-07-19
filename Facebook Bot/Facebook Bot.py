from facepy import GraphAPI
import configparser
import os
import random
from configparser import ConfigParser
from time import sleep
config = configparser.ConfigParser()
parser = ConfigParser()
parser.read("settings.cfg")
#Get config file from the executing directory.
config.read(os.path.join(os.path.dirname(__file__),"settings.cfg"))
ACCESS_TOKEN=config.get('settings','ACCESS_TOKEN')
sleep_time = int(config.get("settings", "SLEEP")) # sleep for 1 second by default

while True:
	graph = GraphAPI(ACCESS_TOKEN)
	graph.post('me/feed', message=(random.choice(list(open('text.txt')))))


	print("Your post was posted!");
	sleep(sleep_time)