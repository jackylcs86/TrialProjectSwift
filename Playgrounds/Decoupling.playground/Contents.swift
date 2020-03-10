import UIKit

// https://medium.com/better-programming/how-to-write-decoupled-code-in-swift-515cfd3fd8eb

//  ================ Tightly Coupled ================
class SessionManager {
    func logout() { print("Successfully logout") }
}

class LoginScreenTightlyCoupled {
    let session: SessionManager = SessionManager()
    
    func btnLogoutTapped() {
        session.logout()
    }
}

//  ================ Coupled ================
// Case 1
class LoginScreenCoupled {
    var session: SessionManager = SessionManager()
    
    func btnLogoutTapped() {
        self.session = SessionManager() // Can still swap the SessionManager here or Child class, so is Tighl
        session.logout()
    }
}

// Case 2 (Dependency Injection)
class LoginScreenCoupledDependencyInjection {
    let session: SessionManager
    
    init(session: SessionManager) {
        self.session = session
    }
    
    func btnLogoutTapped() {
        session.logout()
    }
}


//  ================ Loosely Coupled ================
protocol SessionProtocol {
    func logout()
    func login()
}

//class SessionMan: SessionProtocol {
//    func logout() { print("Logout") }
//    func login() { print("Login") }
//}

class LoginScreenLooselyCoupled {
    var session: SessionProtocol
    
    init(session: SessionProtocol) {
        self.session = session
    }
    
    func btnLogoutTapped() {
        session.logout()
    }

    func btnLoginTapped() {
        session.login()
    }
}


//  ================ Decoupled ================
class LoginScreenDecoupled {
    var logoutClosure: () -> ()

    init(logoutClosure: @escaping () -> ()) {
        self.logoutClosure = logoutClosure
    }

    func btnLogoutTapped() {
        logoutClosure()
    }

}
