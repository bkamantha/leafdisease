import facebook

from .processcomments import commentProcess

app_id = "561867056093423"
app_secret = "16d61a01ae22b07fcc90ae896b6c8ea2"
access_token = "EAAWqItKEIi0BANbjrIsWZBlegOKFOANKQTRev5vPXKusZB5XT7RIEGfiioJTtCyVq1XiXVupq0NZCbaEBq4cm8V7h7OVvbrNsqa2LXZBWhFamJHuhSsGWX54j2T54fVH02TZB8ZC8rZCOypvOzcOMAHyofTdcg5cKrABcHWD18nboJvCSMqJUvngl7duyJnticqFdTSCWldFVfzYjd2uOlZC65dfQQnpxcMZD"

group_id = "259384986463276"

group_url = "https://www.facebook.com/groups/259384986463276"




def fbcomment(post_id):
    allcomments = []
    graph = facebook.GraphAPI(access_token=access_token, version="3.0")

    post_id = "6179812755466992"

    comments = graph.get_connections(post_id, "comments")

    for comment in comments["data"]:
        # print(comment["id"], comment["message"])

        # print(comment["message"])
        allcomments.append(comment["message"])
        # Process the comment
        processed_comment = commentProcess(comment["message"])

    return allcomments


# print(fbcomment(6179812755466992))
