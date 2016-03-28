//
//  ChatData.swift
//  聊天布局
//
//  Created by 梁传飞 on 16/3/28.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class ChatData: NSObject {
    var text = ""
    var time = ""
    var type: ChatType = .ME
    
    init(dict: Dictionary<String,AnyObject>){
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        if key == "type"{
            if let typeValue = value as? Int{
                
                if typeValue == 0{
                    type = .ME
                }else{
                     type = .Other
                }
            }
        }
    }
    
    
}

enum ChatType: Int{
    case Other = 0
    case ME = 1
}