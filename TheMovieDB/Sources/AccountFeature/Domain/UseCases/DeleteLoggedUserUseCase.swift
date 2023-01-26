//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 26.01.2023.
//

import Foundation
import Common

protocol DeleteLoggedUserUseCase {
  func execute()
}

final class DefaultDeleteLoggedUserUseCase: DeleteLoggedUserUseCase {
  private let loggedRepository: LoggedUserRepositoryProtocol

  init(loggedRepository: LoggedUserRepositoryProtocol) {
    self.loggedRepository = loggedRepository
  }

  func execute() {
    loggedRepository.deleteUser()
  }
}
