# alterative implementation using watchdog library
import os
import subprocess
import time

from watchdog.events import FileSystemEventHandler
from watchdog.observers import Observer

from unlock_pdf import unlock_pdf


class MyHandler(FileSystemEventHandler):
    def on_created(self, event):
        if event.src_path.endswith(".pdf"):
            print(f"File {event.src_path} has been created")
            unlock_pdf(event.src_path)
            subprocess.run(["open", event.src_path], check=True)


if __name__ == "__main__":
    event_handler = MyHandler()
    observer = Observer()

    downloads_path = os.path.expanduser("~/Downloads")
    observer.schedule(event_handler, path=downloads_path, recursive=False)
    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
