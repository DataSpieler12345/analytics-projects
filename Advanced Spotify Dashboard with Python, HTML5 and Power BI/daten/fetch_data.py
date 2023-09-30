# Import required libraries
import requests
import pandas as pd

# Initialize your client ID and client secret from Spotify Developer Dashboard
CLIENT_ID = 'your_client_id'
CLIENT_SECRET = 'your_spotify_client_secret'

# Fetch an access token from Spotify
auth_response = requests.post(
    'https://accounts.spotify.com/api/token',
    data={'grant_type': 'client_credentials', 'client_id': CLIENT_ID, 'client_secret': CLIENT_SECRET},
)
auth_data = auth_response.json()
access_token = auth_data['access_token']

# Prepare headers for API requests
headers = {'Authorization': f'Bearer {access_token}'}

# Load your existing CSV file into a DataFrame
# Replace with the actual path to your file
df = pd.read_csv('your-path', encoding='ISO-8859-1')


# Create an empty list to store cover URLs
cover_urls = []

# Loop through each row in the DataFrame to search for tracks on Spotify
for _, row in df.iterrows():
    track_name = row['track_name']
    artist_name = row['artist(s)_name']

    query = f"track: {track_name} artist: {artist_name}"
    search_response = requests.get(f"https://api.spotify.com/v1/search?q={query}", headers=headers)

    search_data = search_response.json()

    try:
        cover_url = search_data['tracks']['items'][0]['album']['images'][0]['url']
    except (KeyError, IndexError):
        cover_url = 'Not Found'

    cover_urls.append(cover_url)

# Add the 'cover_url' column to the DataFrame
df['cover_url'] = cover_urls

# Save the updated DataFrame to a CSV file
df.to_csv('updated_spotify_data.csv', index=False)

# Confirm that the data has been saved
print("Updated data has been saved to 'updated_spotify_data.csv'")