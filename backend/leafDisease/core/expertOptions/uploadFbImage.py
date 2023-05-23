import facebook
from PIL import Image

app_id = "561867056093423"
app_secret = "16d61a01ae22b07fcc90ae896b6c8ea2"
access_token = "EAAWqItKEIi0BABpcJCw84HHVqPZCxjvPF6zxvvdX75lScZB0LYLHth4bFLQDnXpH4ED3dNduimgbWxieTMrZBCfKlZCqmdkrOI0k26oaia4yVlqjOocImL4CAmhxUMjD8pwJ3CycFRFrdwnf01dZAwz3Q1ZAvn5sWNwedkwogTJ7Fs2ZA4o1frRsWMEmkHeb3E2j7ZAtJROH0vai1uC5YDZCA9ZBj9SDPVCrrfHMqaouhahszuVol1ZApE17kUQNHtAo7sZD"


group_id = "259384986463276"

graph = facebook.GraphAPI(access_token=access_token, version="3.0")


# image_path = "backend\\leafDisease\\core\\saveImg\\1408.png"


def uploadToFb(image_path):
    with open(image_path, "rb") as image_file:
        image_data = image_file.read()

    response = graph.put_photo(
        image=image_data, album_path=group_id + "/photos", message="This is my image"
    )

    if response["id"]:
        print("Image uploaded successfully")
    else:
        print("Error uploading image")


# uploadToFb(image_path)
