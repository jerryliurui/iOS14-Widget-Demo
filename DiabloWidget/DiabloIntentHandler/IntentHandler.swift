//
//  IntentHandler.swift
//  DiabloIntentHandler
//
//  Created by JerryLiu on 2020/8/5.
//

import Intents

class IntentHandler: INExtension, DiabloHeroIntentHandling {
    
    func provideYourHeroOptionsCollection(for intent: DiabloHeroIntent, with completion: @escaping (INObjectCollection<Hero>?, Error?) -> Void) {
        DataManager.fetchHeroList { (heros, error) in
            
            let defaultHero = Hero(identifier: "1", display: "天空寺院")
            
            let collection = INObjectCollection(items: heros ?? [defaultHero])
            completion(collection, nil)
        }
    }
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
