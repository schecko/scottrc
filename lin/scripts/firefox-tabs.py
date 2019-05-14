#!/usr/bin/python3
import json
import glob
import logging

try:
    import lz4.block as lz4
except ImportError:
    import lz4

logging.basicConfig(level=logging.INFO)

session_file_glob = glob.glob("/home/scott/.mozilla/firefox/*.default/sessionstore-backups/recovery.json*")
logging.info("searching in files: {}".format(session_file_glob))
print("\n\n\n\n")
for session_file in session_file_glob:
    session_contents = open(session_file, 'rb')
    session_json = None
    if session_contents.read(8) == b'mozLz40\0':
        session_json = lz4.decompress(session_contents.read())
    else:
        continue
    session = json.loads(session_json.decode('utf-8'))
    session_contents.close()

    print("\n")
    for session_file in session_file_glob:
        for window in session.get("windows"):
            selected_tab = window.get("selected") - 1
            print("tab length {}".format(len(window.get("tabs"))))
            print("hello {}".format(window.get("tabs")[selected_tab].get("attributes")))
            #active_tab = window.get("tabs")[window.get("selected")]

    selected_window = 0
    if session["windows"][0]["selected"] is not None:
        selected_window = session["windows"][0]["selected"]
        logging.info("selected window is: {}".format(selected_window))
    else:
        logging.info("window {} did not have a selected window".format(selected_window))
else:
    logging.error("Could not find recovery file to parse, there is likely no running firefox process")


