//
//  Assembler.swift
//  The-Movie-DB
//
//  Created by LEMIN DAHOVICH on 28.10.2022.
//

import Foundation

protocol AssemblerProtocol {
  associatedtype VC
  func assembly() -> VC
}