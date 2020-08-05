//
//  DataManager.swift
//  DiabloWidget
//
//  Created by JerryLiu on 2020/8/3.
//

import Foundation
import UIKit

struct DataManager {
    
    /**
     获取信息流数据
     
     @param topicId 栏目ID
     @param articleNum 获取文章数量
     @param shouldLoadLogo 是否需要请求LOGO
     @param completion 完成回调
     */
    static func fetchFeedList(topicId: Int, articleNum : Int, shouldLoadLogo : Bool, articleImageSize: CGSize, completion: @escaping (DataModel?, Error?) -> Void) {

        switch articleNum {
        case 1:
            completion(DataModel.demoDataSmall,nil)
        case 2:
            //原工程根据大小尺寸来选择获取的文章数量，这里因为是demo，因此medium我也只取一条
            completion(DataModel.demoDataMedium,nil)
        case 3:
            completion(DataModel.demoDataLarge,nil)
        default:
            completion(DataModel.demoDataSmall,nil)
        }
        return;
        
        //下边是真实的网络请求，demo工程模拟了，使用的本地数据
        //特别注意的是，这里同时也可以是下载图片的地方，直接把图片数据传递给Entry
        let urlBaseString = "https://这里可以替换成真实工程URL来创建请求"
        
        let feedListContentsURL = URL(string: urlBaseString)!
        
        let task = URLSession.shared.dataTask(with: feedListContentsURL) { (data, response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard data != nil else {
                completion(nil, error)
                return
            }
        }
        task.resume()
    }

    static func getResultFromRemoteInfo(fromData data: Foundation.Data) -> NetworkResult? {
        do {
            let resultFeedModel = try JSONDecoder().decode(NetworkResult.self, from: data)
            return resultFeedModel
        } catch {
            return nil
        }
    }
    
    static func getDictionaryFromJSONString(remoteData:Data) -> NSDictionary {

        let dict = try? JSONSerialization.jsonObject(with: remoteData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    static func getArrayFromJSONString(remoteData:Data) ->NSArray {
            
        let array = try? JSONSerialization.jsonObject(with: remoteData, options: .mutableContainers)
        if array != nil {
            return array as! NSArray
        }
        return array as! NSArray
            
    }
    
    static func fetchImageData(imageUrlString: String, completion: @escaping (Data?, Error?) -> Void) {
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
    
    static func fetchHeroList(completion: @escaping ([Hero]?, Error?) -> Void) {
        var results : [Hero] = []
        
        let monk = Hero(identifier: "1", display: "天空寺院")
        let siling = Hero(identifier: "2", display: "暗影王国")
        let yemanren = Hero(identifier: "3", display: "哈洛加斯")
        let wuyi = Hero(identifier: "4", display: "无行之地")
        let dh = Hero(identifier: "5", display: "复仇者营地")
        let mofashi = Hero(identifier: "6", display: "仙塞学院")
        let shengjiaojun = Hero(identifier: "7", display: "勇者圣殿")
        
        results.append(monk)
        results.append(siling)
        results.append(yemanren)
        results.append(wuyi)
        results.append(dh)
        results.append(mofashi)
        results.append(shengjiaojun)
        
        completion(results,nil)
        
        return;
        
        let urlBaseString = "真实URL"
    
        let columnListContentsURL = URL(string: urlBaseString)!
    
        let task = URLSession.shared.dataTask(with: columnListContentsURL) { (data, response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
        
            guard data != nil else {
                completion(nil, error)
                return
            }
        
            completion(nil, nil)
        
        }
        task.resume()
    }
}
