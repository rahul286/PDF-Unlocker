//import Foundation
//
//class PasswordList: ObservableObject {
//    @Published var passwords: [String] = [] {
//        didSet {
//            savePasswords()
//        }
//    }
//
//    private let userDefaultsKey = "passwordList"
//
//    init() {
//        loadPasswords()
//    }
//
//    private func loadPasswords() {
//        if let savedPasswords = UserDefaults.standard.stringArray(forKey: userDefaultsKey) {
//            passwords = savedPasswords
//        }
//    }
//
//    private func savePasswords() {
//        UserDefaults.standard.set(passwords, forKey: userDefaultsKey)
//    }
//}
