import SwiftUI
import LaunchAtLogin
import FileWatcher
import PDFKit

@main
struct PDFUnlockerApp: App {
    @StateObject private var fileWatcherManager = FileWatcherManager()

    var body: some Scene {
        MenuBarExtra("PDF Unlocker", systemImage: "lock.open.rotation") {
            SettingsLink {
                Text("Settings")
            }.keyboardShortcut(",", modifiers: .command)
            
            Divider()

            Button("Quit") {
                NSApplication.shared.terminate(self)
            }
            .padding()
        }
        
        Settings {
            SettingsView(fileWatcherManager: fileWatcherManager)
        }
    }
}

class FileWatcherManager: ObservableObject {
    @Published var isMonitoring: Bool {
        didSet {
            UserDefaults.standard.set(isMonitoring, forKey: "isMonitoring")
        }
    }

    private var fileWatcher: FileWatcher?

    init() {
        self.isMonitoring = UserDefaults.standard.bool(forKey: "isMonitoring")
        if isMonitoring {
            startFileWatcher()
        }
    }

    func setupFileWatcher() -> FileWatcher {
        let downloadsURL = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Downloads")
        let downloadsPath = downloadsURL.path
        print("Monitoring path: \(downloadsPath)")
        
        return FileWatcher([downloadsPath])
    }

    func startFileWatcher() {
        print("Started PDF monitoring")
        
        fileWatcher = setupFileWatcher()
        fileWatcher?.callback = { event in
            print("Callback triggered")
            if event.fileCreated {
                print("File created event detected")
                print(event.path)
                let fileName = event.path
                if fileName.lowercased().hasSuffix(".pdf") {
                    print("Processing PDF File: \(fileName)")
                    processPDF(fileName: fileName)
                }
            } else {
                print("Other event detected: \(event)")
            }
        }
        
        fileWatcher?.start()
        isMonitoring = true
        print("Filewatcher Started")
    }

    func stopFileWatcher() {
        print("Stopped PDF monitoring")
        fileWatcher?.stop()
        fileWatcher = nil
        isMonitoring = false
        print("Filewatcher Stopped")
    }
}

func processPDF(fileName: String) {
    print("Processing PDF: \(fileName)")

    let passwordList = UserDefaults.standard.string(forKey: "passwordList") ?? ""
    let passwords = passwordList.components(separatedBy: "\n")

    for password in passwords {
        if let pdfDocument = openLockedPDF(fileName: fileName, password: password) {
            print("Opened the PDF with password: \(password)")
            print("Number of pages: \(pdfDocument.pageCount)")

            let fileURL = URL(fileURLWithPath: fileName)
            if saveUnlockedPDF(originalURL: fileURL, unlockedDocument: pdfDocument) {
                print("Successfully wrote unlocked PDF to file: \(fileURL.path)")
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

struct SettingsView: View {
    @ObservedObject var fileWatcherManager: FileWatcherManager
    @State private var passwordList: String = UserDefaults.standard.string(forKey: "passwordList") ?? ""

    var body: some View {
        Text("Enter passwords, one on each line.")
            .padding(.top, 30)

        TextEditor(text: $passwordList)
            .border(Color.gray.opacity(0.5), width: 1)
            .frame(width: 200, height: 203)
            .font(.system(size: 13))
            .lineSpacing(1)
            .padding([.top, .bottom], 5)
            .padding([.leading, .trailing], 20)

        Button("Save Passwords") {
            let passwordList = Array(Set(self.passwordList.components(separatedBy: "\n")))
                .filter { !$0.isEmpty }
                .sorted()
                .joined(separator: "\n")
            UserDefaults.standard.set(passwordList, forKey: "passwordList")
            self.passwordList = passwordList
        }
        .padding(.bottom, 20)

        Button(fileWatcherManager.isMonitoring ? "Stop PDF Monitoring" : "Start PDF Monitoring") {
            if fileWatcherManager.isMonitoring {
                print("Stopping PDF Monitoring manually")
                fileWatcherManager.stopFileWatcher()
            } else {
                print("Start PDF Monitoring manually")
                fileWatcherManager.startFileWatcher()
            }
        }
        .padding(.bottom, 10)

        LaunchAtLogin.Toggle()
            .padding(20)
    }
}

#Preview {
    SettingsView(fileWatcherManager: FileWatcherManager())
}
