//
//  RegistLocationComponent + Select.swift
//  What?fle
//
//  Created by 이정환 on 3/20/24.
//

import Foundation

extension RegistLocationComponent: SelectLocationDependency {
    var selectLocationBuilder: SelectLocationBuildable {
        return SelectLocationBuilder(dependency: self)
    }
}
