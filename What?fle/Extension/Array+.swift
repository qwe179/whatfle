//
//  Array+.swift
//  What?fle
//
//  Created by 이정환 on 4/1/24.
//

import Foundation

extension Array {
    public subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
