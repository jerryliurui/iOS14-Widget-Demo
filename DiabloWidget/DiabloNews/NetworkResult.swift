//
//  NetworkResult.swift
//  DiabloWidget
//
//  Created by JerryLiu on 2020/8/3.
//

import Foundation

struct NetworkResult : Codable {
    let code: Int?
    let message: String?
    let data: DataModel?
}
