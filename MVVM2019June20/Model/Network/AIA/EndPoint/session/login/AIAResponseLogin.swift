//
//  AIAResponseLogin.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension AIA {
    public class ResponseLogin : AIA.ResponseTokenBase {
        public var userId:String = ""
        public var name:String = ""
        public var token:String = ""
        public var revalidationToken:String = ""
        public var termCond1:Bool = false
        public var agentRank: String = ""
        public var staffRank: String = ""
        public var accessLevel: String = ""
        public var region: String = ""
        public var subRegion: String = ""
        public var branch: String = ""
    }
}
