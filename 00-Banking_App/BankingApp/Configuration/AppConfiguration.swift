//
// AppConfiguration.swift
//
// Copyright © 2022 Kevin Topollaj. All rights reserved.
//

import Foundation

// MARK: - AppConfiguration -
enum AppConfiguration {
  case live
  case mock
}

// create a condition compilation based on Configuration
#if MOCK
let appConfiguration: AppConfiguration = .mock
#else
let appConfiguration: AppConfiguration = .live
#endif
