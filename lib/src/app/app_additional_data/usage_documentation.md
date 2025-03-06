1. As a developer you must create application in your developer console: https://dev.twitch.tv/console/apps;
2. Than create additional_data folder inside root directrory (example: streamer_dashboard/additional_data/);
3. Create twitch_app_data.json file inside additional_data folder and add simple json structure:

```json
{  
	"client_id": "your_twitch_client_id",  
	"client_secret": "your_twitch_client_secret",
	"redirect_url": "your_twitch_auth_redirect_url"
}
```

It's all done!
