//
//  Helper.swift
//  DiabloWidget
//
//  Created by JerryLiu on 2020/8/3.
//

import Foundation
import WidgetKit

/**
 根据当前Widget尺寸来获取网络文章数据
 */
func fetchArticleCount(currentFamily: WidgetFamily) -> Int {
    var fetchArticleNums = 3
    
    switch currentFamily {
    case .systemSmall:
        fetchArticleNums = 1
    case .systemMedium:
        fetchArticleNums = 2
    case .systemLarge:
        fetchArticleNums = 3
    }
    
    return fetchArticleNums
}
