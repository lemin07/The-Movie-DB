//
//  AuthHandler.swift
//  The-Movie-DB
//
//  Created by LEMIN DAHOVICH on 20.11.2022.
//

import Foundation

import Domain

protocol AuthenticationHandlerProtocol {

    func currentUser() -> User?
    func isUserSignedIn() -> Bool
    func deleteCurrentUser()

}
