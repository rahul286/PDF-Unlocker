import SwiftUI
import LaunchAtLogin
import FileWatcher
import PDFKit

@main
struct PDFUnlockerApp: App {
    // check if LaunchAtLogin.isEnabled is true
    init(){
        if LaunchAtLogin.isEnabled {
            print("Started PDF monitoring")
            let filewatcher = FileWatcher([NSString(string: "~/Downloads").expandingTildeInPath])

            filewatcher.callback = {
                event in
                if event.fileCreated {
                    let fileName = event.path
                    if fileName.hasSuffix(".pdf") {
                        print("File created: \(fileName)")
                        processPDF(fileName: fileName)
                    }
                }
            }

            filewatcher.start() // start monitoring
        }
        else {
            print("Launch at login is disabled")
        }
    }
    
    var body: some Scene {
        
        MenuBarExtra("PDF Unlocker", systemImage: "lock.open.rotation")  {
            
            SettingsLink{
                Text("Settings")
            }.keyboardShortcut(",", modifiers: .command)
            
            Divider()

            Button("Quit") {
                NSApplication.shared.terminate(self)
            }
            .padding()            
        }
        
        // Add a new settings scene
        Settings {
            SettingsView()
        }
    }
}

func processPDF(fileName: String){
    print("Processing PDF: \(fileName)")
    
    let passwordList = UserDefaults.standard.string(forKey: "passwordList") ?? ""
    let passwords = passwordList.components(separatedBy: "\n")

    for password in passwords {
        if let pdfDocument = openLockedPDF(fileName: fileName, password: password) {
            print("Opened the PDF with password: \(password)")
            print("Number of pages: \(pdfDocument.pageCount)")

            // Save the unlocked PDF to overwrite the original file
            let fileURL = URL(fileURLWithPath: fileName)
            if saveUnlockedPDF(originalURL: fileURL, unlockedDocument: pdfDocument) {
                print("Successfully wrote unlocked PDF to file: \(fileURL.path)")
                // Open the PDF in Preview
                NSWorkspace.shared.open(fileURL)
            } else {
                print("Failed to write unlocked PDF to file")
            }
            break
        }
    }
}

func openLockedPDF(fileName: String, password: String) -> PDFDocument? {
    let fileManager = FileManager.default
    let fileURL = URL(fileURLWithPath: fileName)
    
    guard fileManager.fileExists(atPath: fileURL.path) else {
        print("File does not exist at path: \(fileURL.path)")
        return nil
    }
    
    guard let pdfDocument = PDFDocument(url: fileURL) else {
        print("Could not open PDF document at: \(fileURL.path)")
        return nil
    }
    
    if pdfDocument.isEncrypted {
        if pdfDocument.unlock(withPassword: password) {
            print("Successfully unlocked the PDF.")
            return pdfDocument
        }
    }
    return nil
}

func saveUnlockedPDF(originalURL: URL, unlockedDocument: PDFDocument) -> Bool {
    let newDocument = PDFDocument()
    
    for pageIndex in 0..<unlockedDocument.pageCount {
        if let page = unlockedDocument.page(at: pageIndex) {
            newDocument.insert(page, at: pageIndex)
        }
    }
    
    return newDocument.write(to: originalURL)
}
