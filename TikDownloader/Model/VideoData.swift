//
//  WeatherData.swift
//  TikDownloader
//
//  Created by fe on 30.09.2022.
//

import Foundation

// MARK: - Welcome

struct VideoData: Codable {
    let ok: Bool
    let result: Result
}

// MARK: - Result

struct Result: Codable {
    let video: ResultVideo
    let aweme_detail: AwemeDetail
}

// MARK: - AwemeDetail

struct AwemeDetail: Codable {
    let desc: String
}

// MARK: - ResultVideo

struct ResultVideo: Codable {
    let url_list: [String]
}
