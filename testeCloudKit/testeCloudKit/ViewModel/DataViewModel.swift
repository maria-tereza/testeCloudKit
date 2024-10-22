//
//  DataViewModel.swift
//  testeCloudKit
//
//  Created by Maria Tereza Martins Pérez on 22/10/24.
//
import Foundation
import CloudKit

class DataViewModel: ObservableObject {
    var container: CKContainer = CKContainer.default()
    var publicDatabase: CKDatabase { container.publicCloudDatabase }

    @Published var messages: [Message] = []

    func fetchMessages() {
        let query = CKQuery(recordType: "Message", predicate: NSPredicate(value: true))
        publicDatabase.perform(query, inZoneWith: nil) { [weak self] records, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Erro ao buscar mensagens: \(error.localizedDescription)")
                } else if let records = records {
                    self?.messages = records.compactMap { record in
                        guard let content = record["text"] as? String else { return nil }
                        return Message(id: record.recordID, text: content)
                    }
                    print("Mensagens recebidas: \(self?.messages.count ?? 0)")
                }
            }
        }
    }
}
