//
//  WidgetManager.swift
//  DiabloWidget
//
//  Widget 管理类
//
//  Created by JerryLiu on 2020/8/4.
//

import Foundation
import WidgetKit

public func reloadMyWidget() {
    WidgetCenter.shared.reloadAllTimelines()
}

public func trackMyWidget() {
    WidgetCenter.shared.getCurrentConfigurations { result in
        guard case .success(let widgets) = result else { return }
        
        for widgetInfo in widgets {
            var familyString = ""
            switch widgetInfo.family {
            case .systemSmall:
                familyString = "systemSmall"
            case .systemMedium:
                familyString = "systemMedium"
            case .systemLarge:
                familyString = "systemLarge"
            default:
                familyString = "unknown"
            }
            
            let kindString = widgetInfo.kind
            
            //配置信息
            widgetInfo.configuration
            
            print(familyString,kindString)
        }
    }
}
