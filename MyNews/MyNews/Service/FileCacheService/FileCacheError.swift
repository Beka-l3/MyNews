//
//  FileCacheError.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//

import Foundation


public enum FileCacheError: String, Error {
    case itemNotFound = "Error: There is no item with such key in UserDefaults"
}
