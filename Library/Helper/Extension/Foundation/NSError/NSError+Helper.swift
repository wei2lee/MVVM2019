//
//  NSError+Extension.swift
//  theera
//
//  Created by lee yee chuan on 4/6/17.
//  Copyright © 2017 infradesign. All rights reserved.
//

import Foundation

extension NSError {
    func underlyingKey<T>(key:String) -> T? {
        var e:NSError? = self
        repeat {
            if let ret = e?.userInfo[key] as? T {
                return ret
            }
            e = e?.underlyingError
        } while(e != nil)
        return nil
    }
    
    func withUserInfo(key:String, value:Any?) -> NSError {
        var userInfo = self.userInfo
        userInfo[key] = value
        return NSError(domain: self.domain, code: self.code, userInfo: userInfo)
    }
    
    func with(apiResponseDictionary:NSDictionary?) -> NSError {
        return self.withUserInfo(key: NSErrorUserInfoKey.ApiResponseDictionary, value: apiResponseDictionary)
    }
    
    func with(apiResponseObject:Any?) -> NSError {
        return self.withUserInfo(key: NSErrorUserInfoKey.ApiResponseObject, value: apiResponseObject)
    }

    var apiResponseDictionary:NSDictionary? {
        var err:NSError? = self
        repeat {
            if let ret = err?.userInfo[NSErrorUserInfoKey.ApiResponseDictionary] as? NSDictionary {
                return ret
            }
            err = err?.underlyingError
        } while(err != nil)
        return nil
    }
    var apiResponseObject:Any? {
        var err:NSError? = self
        repeat {
            if let ret = err?.userInfo[NSErrorUserInfoKey.ApiResponseObject] {
                return ret
            }
            err = err?.underlyingError
        } while(err != nil)
        return nil
    }
    func with(underlyingError:Error) -> NSError {
        return with(underlyingError: underlyingError as NSError)
    }
    func with(underlyingError:NSError) -> NSError {
        return self.withUserInfo(key: NSErrorUserInfoKey.UnderlyingError, value: underlyingError)
    }
    var underlyingError : NSError? {
        return self.userInfo[NSErrorUserInfoKey.UnderlyingError] as? NSError
    }
    func with(localizedDescription:String) -> NSError {
        return self.withUserInfo(key: NSLocalizedDescriptionKey, value: localizedDescription)
    }
    func with(localizedTitle:String) -> NSError {
        return self.withUserInfo(key: NSErrorUserInfoKey.LocalizedTitle, value: localizedTitle)
    }
    
    var localizedTitle: String? {
        return error.userInfo[NSErrorUserInfoKey.LocalizedTitle] as? String
    }
}

extension NSError {
    convenience init(
        domain: String = "",
        code: Int = 0,
        localizedTitle:String? = nil,
        localizedDescription:String? = nil
        ) {
        self.init(domain: "",
                  code: 0,
                  userInfo: [
                    NSErrorUserInfoKey.LocalizedTitle:localizedTitle as Any,
                    NSErrorUserInfoKey.LocalizedDescription:localizedDescription as Any
            ])
    }
}
