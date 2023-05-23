import facebook

from .processcomments import commentProcess

app_id = "561867056093423"
app_secret = "16d61a01ae22b07fcc90ae896b6c8ea2"
access_token = "EAAWqItKEIi0BAO6WRWIZBBu28AZAptKZAf8ZAUB65z8n4eLxA3zgNhwGV3ZBi8o5nE1MkKwErclF8LJgweA9pcoX2mDyLxgmc3IijPabe9ahA6TSdbW2N9Yu8JkpLFmn3sqKAAZBCvIqMsuyiYNvWK6hEjWh41ilZBZAtYYq5128gOEVbvXV1GHq8LojovAZAlcygR5qaZCnWeGTf86BGEDwEHC9aKW1lztx6ft85WWYI73l6tmoMGrGyaAot4p2j0qP0XSiCthWLREAZDZD"

group_id = "259384986463276"

group_url = "https://www.facebook.com/groups/259384986463276"

allcomments = []


def fbcomment(post_id):
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
