//
//  URLHelper.swift
//  AIAAgent
//
//  Created by lee yee chuan on 14/03/2018.
//  Copyright © 2018 lee yee chuan. All rights reserved.
//

import Foundation
/*
extension URL {
    static func createURLFrom(string: String, query: String = "") -> URL? {
        if var urlComp = URLComponents(string: string) {
            if !query.isEmpty {
                urlComp.query = query
            }
            return urlComp.url
        } else {
            return nil
        }
    }
    
    static func createURLFrom(phone:String?) -> URL? {
        guard let urlStringNotNil = phone else {
            return nil
        }
        
        let newPhoneNumber = urlStringNotNil.replacingOccurrences(of: "+", with: "00")
            .replacingOccurrences(of: " ", with: "")
        return URL(string: "tel://\(newPhoneNumber)")
    }
    
    static func createURLFrom(urlString:String?) -> URL? {
        guard let urlStringNotNil = urlString else {
            return nil
        }
        
        func verify(encodedURLString: String) -> URL? {
            if let url:URL = URL(string: encodedURLString) {
                if url.host != nil {
                    if UIApplication.shared.canOpenURL(url) {
                        return url
                    }
                    return nil
                    return url
                }
                return nil
            }
            return nil
        }
        
        func encodeStringToURL(urlString:String) -> URL? {
            let characterSetTobeAllowed = (CharacterSet(charactersIn: "!*'();@+$,#[] ").inverted)

            if let encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: characterSetTobeAllowed) {
                if let url = verify(encodedURLString: encodedURLString) {
                    return url
                }
                return nil
            }
            return nil
        }
        
        func transformURLFrom(urlString:String) -> URL?{
            if urlString.hasPrefix("https://") || urlString.hasPrefix("http://"){
                if let validURL = encodeStringToURL(urlString: urlString){
                    return validURL
                }
                return nil
            } else { // do not have "http://"
                let device = DIContainer.resolve(Device.self)!
                if device.urlSchemes.filter({ o  in urlString.hasPrefix(o) }).count == 0 {
                    var correctedURL = ""
                    let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
                    let matches = detector.matches(in: urlString, options: [], range: NSRange(location: 0, length: urlString.utf16.count))
                    
                    let match:NSTextCheckingResult? = matches.filter{ $0.numberOfRanges != 0 }.first{ match in
                        guard let range = Range(match.range, in: urlString) else { return false }
                        correctedURL = "http://\(urlString[range])"
                        return true
                    }
                    
                    if let _ = match?.url{
                        if let validURL = encodeStringToURL(urlString: correctedURL){
                            return validURL
                        }
                        return nil
                    }
                    return nil
                } else {
                    if let validURL = encodeStringToURL(urlString: urlString){
                        return validURL
                    }
                    return nil
                }
            }
            return nil
        }
        
        if !urlStringNotNil.isNilOrEmptyReplacementOrEmptyString{
            if let url = transformURLFrom(urlString: urlStringNotNil) {
                return url
            }
            return nil
        }
        return nil
    }
    
    func createURL(wildString:String) -> URL? {
        let httpString:String
        if wildString.starts(with: "http") || wildString.starts(with: "https") {
            httpString = wildString
        } else {
            httpString = "http://" + wildString
        }
        if let u = URL(string: httpString) {
            return u
        } else {
            if let index = httpString.index(of:"&") {
                let hostname = httpString.substring(to: index)
                let query = httpString.substring(from: index)
                if let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
                    return URL(string:hostname + encodedQuery)
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }
    }
}
*/
