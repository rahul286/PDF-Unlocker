//import SwiftUI
//import LaunchAtLogin
//
//struct SettingsView: View {
//    @ObservedObject var fileWatcherManager: FileWatcherManager
//    @State private var passwordList: String = UserDefaults.standard.string(forKey: "passwordList") ?? ""
//    @State private var isMonitoring: Bool = false
//    
//    var body: some View {
//        Text("Enter passwords, one on each line.")
//            .padding(.top,30)
//
//        TextEditor(text: $passwordList)
//            .border(Color.gray.opacity(0.5), width: 1) // Silver-like border
//            .frame(width: 200, height: 203)
//            .font(.system(size: 13))
//            .lineSpacing(1)
//            .padding([.top,.bottom],5)
//            .padding([.leading, .trailing],20)
//
////        Text("Duplicate passwords \n will be removed after saving")
////            .font(.system(size: 12))
////            .padding(5)
//
//        //add a button to save the password list
//        Button("Save Passwords") {
//            //remove duplicate strings from passwordList
//            let passwordList = Array(Set(self.passwordList.components(separatedBy: "\n")))
//                .filter { !$0.isEmpty }
//                .sorted()
//                .joined(separator: "\n")
//            UserDefaults.standard.set(passwordList, forKey: "passwordList")
//            //update TextEditor
//            self.passwordList = passwordList
//        }
//        .padding(.bottom,20)
//        
//        // Toggle to enable/disable PDF monitoring
//        Button(isMonitoring ? "Stop PDF Monitoring" : "Start PDF Monitoring") {
//            isMonitoring.toggle()
//            if isMonitoring {
//                startFileWatcher()
//            } else {
//                stopFileWatcher()
//            }
//        }
//        .padding(.bottom, 30)
//        
//        
//        Text(LaunchAtLogin.isEnabled
//             ? "PDF Monitoring is enabled"
//             : "PDF Monitoring is disabled")
//        .foregroundColor(LaunchAtLogin.isEnabled ? .green : .red)
//        .padding(.bottom,5)
//        
//        LaunchAtLogin.Toggle("Launch PDF Monitoring")
//            .padding(.bottom,30)
//            .toggleStyle(SwitchToggleStyle(tint: .green))
//    }
//}
//
//#Preview {
//    SettingsView()
//}
