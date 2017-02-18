import Foundation

class APIRequestManager {
    
    static let manager = APIRequestManager()
    private init() {}
    
    func getElections(endPoint: String = "https://www.googleapis.com/civicinfo/v2/elections?key=AIzaSyBU0xkqxzxgDJfcSabEFYMXD9M-i8ugdGo", callback: @escaping ([Election]?) -> Void) {
        guard let myURL = URL(string: endPoint) else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error durring session: \(error)")
            }
            guard let validData = data else { return }
            var elections: [Election]? = nil
            do {
                let json = try JSONSerialization.jsonObject(with: validData, options: [])
                if let jsonDict = json as? [String: AnyObject],
                    let electionDicts = jsonDict["elections"] as? [[String: AnyObject]] {
                    elections = []
                    for electionDict in electionDicts {
                        if let election = Election(dict: electionDict) {
                            print("valid election")
                            elections?.append(election)
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            
            callback(elections)
        }.resume()
    }
    
    func getVoterInfo(endPoint: String, callback: @escaping (VoterInfo?) -> Void) {
        
        guard let myURL = URL(string: endPoint) else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: myURL) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            guard let validData = data else { return }
            var voterInfo: VoterInfo? = nil
            do {
                let json = try JSONSerialization.jsonObject(with: validData, options: [])
                if let jsonDict = json as? [String: AnyObject], let validVoterInfo = VoterInfo(dict: jsonDict) {
                    voterInfo = validVoterInfo
                }
            } catch {
                print(error.localizedDescription)
            }
            
            callback(voterInfo)
        }.resume()
    }
}
