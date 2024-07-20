# PDF Unlocker

A simple launch agent that monitors `~/Downloads` folder, automatically unlock PDF files with known passwords.

You are expected to supply passwords PDF files commonly used by your banks, credit cards and other companies.

## Installation

Change permission

```
chmod +x /Users/rahul286/Developer/pdf-unlock/pdf.py
```

## Configuration

Add PDF passwords in plain-text. One password on each line.

```
~/.config/pdf-unlocker/passwords.txt
```

## Start PDF unlocker

````
cp com.rahul286.pdfunlock.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.rahul286.pdfunlock.plist
````

## Stop PDF unlocker

````
launchctl unload ~/Library/LaunchAgents/com.rahul286.pdfunlock.plist
````

## Cleanup

If you don't want to use again:

```
rm ~/Library/LaunchAgents/com.rahul286.pdfunlock.plist
```