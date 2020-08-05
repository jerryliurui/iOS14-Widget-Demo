//
//  DataModel.swift
//  DiabloWidget
//
//  Created by JerryLiu on 2020/8/3.
//

import Foundation

struct DataModel : Codable {
    //文章模型数组
    var articles : [Article]?
    //更新时间
    var updateDate : Date?
    //相关性分数，这个主要是给Siri来推断翻出我们的Widget
    var score: Float?
    
    enum CodingKeys: String, CodingKey {
        case articles = "items"
        case updateDate
        case score
    }
}

extension DataModel {
    
    static let placeHolderData = DataModel (
        articles: [Article.demoData,Article.demoData,Article.demoData],
        updateDate: Date() as Date,
        score: 0.0
    )
    
    static let demoDataSmall = DataModel (
        articles: [Article.demoData],
        updateDate: Date() as Date,
        score: 0.0
    )
    
    static let demoDataMedium = DataModel (
        articles: [Article.demoData1],
        updateDate: Date() as Date,
        score: 0.0
    )
    
    static let demoDataLarge = DataModel (
        articles: [Article.demoData, Article.demoData1, Article.demoData2],
        updateDate: Date() as Date,
        score: 0.0
    )
}
