//
//  IntentHandler.swift
//  MyWidgetIntents
//
//  Created by 高田 朋輝 on 2021/02/14.
//

import Intents
import SwiftUI

class IntentHandler: INExtension, ConfigurationIntentHandling {
    
    func provideBackgroundColorOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {
        let colorItems: [NSString] = ["白", "赤", "青", "黄"]
        let colorCollection = INObjectCollection(items: colorItems)
        completion(colorCollection, nil)
    }
    
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }

}
