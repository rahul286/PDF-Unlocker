# PDF Unlocker App

This is a menubar macOS app designed to unlock encrypted PDF automatically using a known list of passwords.

If you receive encrypted PDFs such as bank/credit card/investment statements, you can store a list of their passwords in this app's settings.

<img src="https://github.com/user-attachments/assets/352c1fa2-87f8-4565-b76a-32286eee7054" height="500" alt="PDF Unlocker Settings">

Once you turn on "Start PDF Monitoring", it will keep running in the background and will automatically launch on next reboot.

## Installation

1. [Download PDF-Unlocker.zip](https://github.com/rahul286/PDF-Unlocker/releases/latest/download/PDF-Unlocker.zip)
2. Unzip file. It will show `PDF Unlocker.app`.
3. Drag and drop `PDF Unlocker.app` to your `Applications` folder.
4. Double click `PDF Unlocker.app` to launch menu bar app.
5. Click menu bar app icon to access settings to store password and start PDF monitoring.

### Security Warning

Since I haven't signed the app, you may see a warning "PDF Unlocker.app" can't be opened because Apple cannot check it for malicious software."

<img src="https://github.com/user-attachments/assets/9d280282-d65c-4aca-a7e6-bdf35b1c161c" height="400" alt="First Warning">

Go to `System Settings` >> `Privacy & Security` >> `Security` section. 

You will see ""PDF Unlocker.app" was blocked from use because it is not from an identified developer."

Click "**Open Anyway**".

<img src="https://github.com/user-attachments/assets/d8336f68-f328-4bc3-aba1-f480acdc1037" height="600" alt="Privacy & Security Settings">

Launch again. This time click "**Open**".

<img src="https://github.com/user-attachments/assets/3e444675-384e-4b3a-8533-3a2a5f2c284f" height="400" alt="Second Warning">

## Known Issue

- [ ] Find a way to sign/notarize app without paying for Apple's developer account.
- [ ] You need to quit and relaunch app after saving settings to start monitoring.
- [ ] Settings window sometimes doesn't come to front. Please check all windows.
- [ ] Fix menu bar icon size. Also, set it to app icon image.

## Credits

* [LaunchAtLogin-Modern](https://github.com/sindresorhus/LaunchAtLogin-Modern) by sindresorhus
* [FileWatcher](https://github.com/eonist/FileWatcher) by eonist
* [Unlock App Icon](https://thenounproject.com/icon/unlock-89653/) by Noun Project
* ChatGPT and Gemini 🤖

