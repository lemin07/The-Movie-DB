//
//  MovieCreditsViewSection.swift
//  UpcomingMovies
//
//  Created by LEMIN DAHOVICH on 15.12.2022.
//

import Foundation
import Common

struct MovieCreditsCollapsibleSection {
    let type: MovieCreditsViewSection
    var opened: Bool
}

enum MovieCreditsViewSection {
    case cast, crew

    var title: String {
        switch self {
        case .cast:
            return Localized.cast()
        case .crew:
            return Localized.crew()
        }
    }

}
