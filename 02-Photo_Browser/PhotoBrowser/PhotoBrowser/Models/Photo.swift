//
//  Photo.swift
//  PhotoBrowser
//
//  Created by Kevin Topollaj on 11.4.21.
//

import Foundation

struct Photo: Codable {
  let id: Int
  let photographer: String
  let photographer_url: String
  var photographer_tag: String {
    return photographer_url.replacingOccurrences(of: "https://www.pexels.com/", with: "")
  }
  let src: PhotoSize
}
