## Facebook Bot 1.0.1
# Designed, Maintained and updated by Gruzzly

# 1.0.1 7/13/2020
Improved code readability

# What is it?
This small script will automatically post a line of text or an image from a folder directly onto your facebook page/wall.<br/>
It pulls credentials and settings from a config.

## How to use
- Head over to https://developers.facebook.com/
- Click on My apps at the top right. Make sure you are logged into the account you want to use.
- Create an app.
- After it's created, go into the dashboard of the app (The main page it loads.)
- Copy the App ID, and the App secret. You will need these later to convert it into a 60day token.
- Click tools and support at the top right.
- Click the graph API explorer under popular tools.
- On the right, where it says GRAPH API EXPLORER, click it and choose the app you created. (IF YOU WANT TOP USE A PAGE, CLICK THE PAGE NAME) 
- Then underneath it, click GET TOKEN. There will be a list of permissions that pop up when you click it. You need to check which ones you want. All you really need is to tick publish actions.
- It will bring up a new window asking you to verify to allow app access to publish. Verify it and it should close.
- It will generate an access token after that. Copy the access token.
- Input the credentials into the text below. Remember to delete the <>.
- Paste it into your browser. It will give you your new 60 day AUTHTOKEN.
Copy that and paste it into the settings.cfg 
- To open a .cfg you right click it and open it with notepad.
##### Example
https://graph.facebook.com/oauth/access_token?client_id=<your FB App ID >&client_secret=<your FB App secret>&grant_type=fb_exchange_token&fb_exchange_token=<your short-lived access token>






### Contact and links
- [Github](https://github.com/Gruzzly-bear)
- [Email](mailto:gruzzly-bear@outlook.com?subject=Hey%20There!)
- [Website](https://gruzzly.co)


