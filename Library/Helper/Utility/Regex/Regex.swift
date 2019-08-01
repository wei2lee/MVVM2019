import Foundation
class Regex {
    let internalExpression: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        self.internalExpression = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
    }
    
    func test(_ input: String) -> Bool {
        let matches = self.internalExpression.matches(in: input, options: [], range:NSMakeRange(0, input.count))
        return matches.count > 0
    }
}

