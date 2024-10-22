//
//  MessageModel.swift
//  testeCloudKit
//
//  Created by Maria Tereza Martins Pérez on 22/10/24.

import Foundation
import CloudKit

struct Pairing: Identifiable {
    var id: CKRecord.ID
    var code: String
}

struct Message: Identifiable {
    var id: CKRecord.ID
    var text: String
}

