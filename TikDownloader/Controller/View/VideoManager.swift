//
//  VideoManager.swift
//  TikDownloader
//
//  Created by fe on 30.09.2022.
//

import Foundation

protocol VideoManagerDelegate {
    func didUpdateVideo(_ videoManager: VideoManager, video: VideoModel)
    func didFailedWithError(_ error: Error)
}

struct VideoManager {
    let headers = [
        "X-RapidAPI-Key": apiKey,
        "X-RapidAPI-Host": "tiktok-downloader-download-videos-without-watermark1.p.rapidapi.com"
    ]

    var delegate: VideoManagerDelegate?
    var videoModel: VideoModel?

    let url = "https://tiktok-downloader-download-videos-without-watermark1.p.rapidapi.com/media-info/"

    func performRequest(with videoUrl: String, completion: @escaping () -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://tiktok-downloader-download-videos-without-watermark1.p.rapidapi.com/media-info/?link=\(videoUrl)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, _, error in
            if error != nil {
                self.delegate?.didFailedWithError(error!)
            }
            if let safeData = data {
                if let video = self.parseJSON(safeData) {
                    self.delegate?.didUpdateVideo(self, video: video)
                }
            }
            completion()
        })
        dataTask.resume()
    }

    func parseJSON(_ videoData: Data) -> VideoModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(VideoData.self, from: videoData)
            let urlString = decodedData.result.video.url_list[1]
            let description = decodedData.result.aweme_detail.desc
            let video = VideoModel(urlString: urlString, description: description)
            return video

        } catch {
            delegate?.didFailedWithError(error)
            return nil
        }
    }
}
