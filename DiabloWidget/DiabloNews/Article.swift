//
//  Article.swift
//  DiabloWidget
//
//  Created by JerryLiu on 2020/8/3.
//

import Foundation
import UIKit

struct Article : Hashable, Codable {
    
    var docId: String?
    var title: String?
    var comment: Float?
    var imageUrl: String?
    var tagList : articleTag?
    var clientUrl: String?//跳转链接
    var videoInfo: VideoInfo?//视频相关信息
    var imageData: Data?
    
    struct articleTag: Hashable, Codable {
        let text : String?
        let type : String?
    }
    
    struct VideoInfo: Hashable, Codable {
        let length : Float?
    }
    
    enum CodingKeys: String, CodingKey {
        case docId
        case title
        case comment = "replyCount"
        case imageUrl = "imgsrc"
        case clientUrl
        case tagList = "tagInfo"
        case videoInfo
    }
    
    /**
     将视频时长转换成时间格式的字符串
     */
    func transVideoLengthToHourMinSec() -> String {
        let allTime: Int = Int(videoInfo?.length ?? 0.0)
        var hours = 0
        var minutes = 0
        var seconds = 0
        var hoursText = ""
        var minutesText = ""
        var secondsText = ""
        
        hours = allTime / 3600
        hoursText = hours > 9 ? "\(hours)" : "0\(hours)"
        
        minutes = allTime % 3600 / 60
        minutesText = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        seconds = allTime % 3600 % 60
        secondsText = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        return "\(hoursText):\(minutesText):\(secondsText)"
    }
    
    /**
     将跟贴数转换成字符串
     */
    func transCommentToString() -> String {
        if comment ?? 0.0 > 9999 {
            let displayNum = comment! / 10000.0
            let resultString = String(format: "%0.1f%@", displayNum, "万跟贴")
            return resultString
        } else if comment == 0.0 {
            return ""
        } else {
            let displayNum = comment!
            let resultString = String(format: "%i%@", Int(displayNum), "跟贴")
            return resultString
        }
    }
    
    func configTagTextColor() -> String {
        if ((tagList?.type) != nil) {
            var resultString = "black99"
            
            switch tagList?.type {
            case "Blue-F":
                resultString = "nbblue"
            case "Red-F":
                resultString = "nbred"
            default:
                resultString = "black99"
            }
            
            return resultString
        } else {
            return "black99"
        }
    }
}

extension Article {
    
    static let placeHolderData = Article (
        docId: "",
        title: "",
        comment: 0,
        imageUrl: "",
        tagList: articleTag(text: "", type: "Red-F"),
        clientUrl: "newsapp://",
        imageData: nil
    )
    
    static let demoData = Article (
        docId: "demo",
        title: "从起飞到撞墙-容易凑飞得稳的上帝僧",
        comment: 26541,
        imageUrl: "",
        tagList: articleTag(text: "天空寺院", type: "Red-FBG"),
        imageData: UIImage(named: "7")?.pngData()
    )
    
    static let demoData1 = Article (
        docId: "demoData1",
        title: "窜逃无益，21赛季国服单人天梯周报",
        comment: 666,
        imageUrl: "",
        tagList: articleTag(text: "新崔斯特姆", type: "Red-FBG"),
        imageData: UIImage(named: "2")?.pngData()
    )
    
    static let demoData2 = Article (
        docId: "demoData2",
        title: "2.6.9暗影三刀国家队杀王攻略-虎牙小柒",
        comment: 0,
        imageUrl: "",
        tagList: articleTag(text: "", type: "Red-FBG"),
        imageData: UIImage(named: "5")?.pngData()
    )
    
    static let demoData3 = Article (
        docId: "demoData3",
        title: "2.6.9辅助猎魔人:萌新组队第一步",
        comment: 1599,
        imageUrl: "",
        tagList: articleTag(text: "复仇者营地", type: "Red-FBG"),
        imageData: UIImage(named: "4")?.pngData()
    )
    
    
    public func fetchImageData(imageUrlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard !imageUrlString.isEmpty else {
            completion(nil, nil)
            return
        }
        
        let urlBaseString = imageUrlString
        
        let imageURL = URL(string: urlBaseString)!
        
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            completion(data, nil)
        }
        task.resume()
    }
}
