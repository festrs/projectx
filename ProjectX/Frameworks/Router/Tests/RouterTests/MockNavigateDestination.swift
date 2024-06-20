//
//  MockNavigateDestination.swift
//
//
//  Created by Felipe Dias Pereira on 20/06/24.
//

import Foundation

public enum MockNavigateDestination: Hashable {
    case navigateOne
    case navigateTwo
}

enum MockPresenter: Identifiable {
    var id: String {
        switch self {
        case .showError:
            return "showError"
        }
    }

    case showError

}
