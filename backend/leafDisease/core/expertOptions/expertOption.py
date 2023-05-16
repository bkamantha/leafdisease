import facebook

app_id = "561867056093423"
app_secret = "16d61a01ae22b07fcc90ae896b6c8ea2"
access_token = "EAAWqItKEIi0BABfrNvcOPdfmHBOvhuIwPZC9c1YXoWMiOH2OFuzV5HtpmMHHVkHYBvWZBE35XePA0bZC5cYdZCqCO6fTDPVdFsz8r70arJkrA0XX5SqNXbOdHUWSwosxEaIUvbobCrmr3xFuHRBTh2zLZAUn0IHXDt1jo4qMUAG6ZCX1HCMpmpd0jp6RmPDWDfVt8hPZCv0nredZBzGj42jpwTGKqY9laSJd0nTGQjZAg7uCd483XJF6xa4iHUZAqAr7zUCXZBllZB8v5AZDZD"
group_id = "CropDetective"

group_url = "https://www.facebook.com/CropDetective/"

graph = facebook.GraphAPI(access_token=access_token, version="3.0")

group_id = graph.get_object(group_url, fields="id")["id"]
print("Group ID:", group_id)

# Fetch only the post IDs
posts = graph.get_connections(group_id, "feed", fields="id")

for post in posts["data"]:
    post_id = post["id"]
    comments = graph.get_connections(post_id, "comments")

    while True:
        try:
            # Process each comment
            for comment in comments["data"]:
                print(comment["id"], comment["message"])

            # Get next page of comments
            comments = graph.get_connections(
                post_id, "comments", after=comments["paging"]["cursors"]["after"]
            )

        except KeyError:
            # No more comments
            break
