#!/usr/bin/env python
import requests
import json
from requests.auth import HTTPBasicAuth

BASE = "https://gerrit.int.esrlabs.com/a/"
PROJECTS = [
    "add",
    "your",
    "projects",
    "here",
]
USER = ""
PASSWD = ""

def auth():
    return HTTPBasicAuth(USER, PASSWD)

def find_rebase_changes(project):
    query = "+".join([
        "project:{}".format(project),
        "is:open",
        "-is:mergeable",
        "label:Code-Review=2",
        "-label:Code-Review-2",
    ])
    url = "{}changes/?q={}".format(BASE,query)
    r = requests.get(url, auth=auth())
    print(url)
    print(r.text)
    changes = json.loads(r.text.split("\n",1)[1])
    return changes

def find_submit_change(project):
    print(project)
    url = "{}changes/?q=project:{}+is:open+is:mergeable".format(BASE,project)
    print(url)
    r = requests.get(url, auth=auth())
    if r.status_code != 200:
        return None
    changes = json.loads(r.text.split("\n",1)[1])
    print(changes)
    for change in changes:
        if change["submittable"]:
            return change
    return None

def rebase_change(change):
    url = "{}changes/{}/rebase".format(BASE,change["id"])
    print(url)
    r = requests.post(url, auth=auth())
    print(r)

def submit_change(change):
    url = "{}changes/{}/submit".format(BASE,change["id"])
    print(url)
    r = requests.post(url, auth=auth())
    print(r)

if __name__ == "__main__":
    for project in PROJECTS:
        print("submitting", project)
        change = find_submit_change(project)
        print(change)
        if change:
            submit_change(change)

        print("rebasing", project)
        for change in find_rebase_changes(project):
            print(change)
            rebase_change(change)
