import UIKit


///// ============== OLD Method for API enum =============== /////
public enum AIAAPI : String {
    case login = "login"
    case logout = "logout"
    case appInfo = "appInfo"
    
    case getContacts = "getContacts"
    case getContact = "getContact"
}

var loginAPI1 = AIAAPI.login.rawValue
var getContactAPI1 = AIAAPI.getContacts.rawValue

///// =============== New Method for ALPA enum ============== /////
public enum ALPAAPI  {
    // Goal Setting
    case auth(api: AuthAPI)
    case contact(api: ContactAPI)
    
    public var apiName: String {
        switch self {
        case .auth(let api):
            return api.rawValue
        case .contact(let api):
            return api.rawValue
        }
    }
}

public enum AuthAPI: String {
    case login = "login"
    case logout = "logout"
    case appInfo = "appInfo"
}

public enum ContactAPI: String {
    case getContacts = "getContacts"
    case getContact = "getContact"
}

var loginAPI2 = ALPAAPI.auth(api: .login).apiName
var getContactAPI2 = ALPAAPI.contact(api: .getContacts).apiName


///// =============== Perfect Method for BL enum ============== /////
public struct BL {
    public struct API {
        public struct Auth { let endPoint: String }
        public struct Contact { let endPoint: String }
    }
}

// Optional if want to compare, but haven't figure out how to use generic to compare different module yet
//extension BL.API: Equatable {
//    public static func == (lhs: BL.API, rhs: BL.API) -> Bool {
//      return lhs.endPoint == rhs.endPoint
//    }
//}

public extension BL.API.Auth {
    static let appInfo = BL.API.Auth(endPoint: "appInfo")
    static let login = BL.API.Auth(endPoint: "login")
    static let logout = BL.API.Auth(endPoint: "logout")
}

public extension BL.API.Contact {
    static let getContacts = BL.API.Contact(endPoint: "getContacts")
    static let getContact = BL.API.Contact(endPoint: "getContact")
}

var loginAPI3 = BL.API.Auth.login.endPoint
var getContactAPI3 = BL.API.Contact.getContacts.endPoint
