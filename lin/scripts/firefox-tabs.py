#!/usr/bin/python3
import json
import glob
import logging
import os
import difflib

try:
    import lz4.block as lz4
except ImportError:
    import lz4

active_urls = []
session_file_glob = glob.glob(os.path.expanduser("~") + "/.mozilla/firefox/*.default/sessionstore-backups/recovery.json*")
for session_file in session_file_glob:
    session_contents = open(session_file, 'rb')
    session_json = None
    if session_contents.read(8) == b'mozLz40\0':
        session_json = lz4.decompress(session_contents.read())
    else:
        continue
    session = json.loads(session_json.decode('utf-8'))
    session_contents.close()

    for session_file in session_file_glob:
        for window_index, window in enumerate(session.get("windows")):
            selected_tab_index = window.get("selected") - 1
            # note that the selected tab is only updated on page refresh or new page.
            selected_tab = window.get("tabs")[selected_tab_index]

            # entries represents the history for a given tab
            # the last element in the list seems to be the most recent entry
            # could be verified through the timestamp?
            history = selected_tab.get("entries")
            active_urls.append(history[-1].get("url"))

if len(active_urls) > 0:
    # choose the best url
    close_matches = difflib.get_close_matches("youtube", active_urls, n=1, cutoff=0.3)
    # TODO something better than just the first one?
    if len(close_matches) > 0:
        print(close_matches[0])
else:
    logging.error("could not find any youtube urls")



