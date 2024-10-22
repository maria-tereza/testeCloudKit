//
//  MessagingViewModel.swift
//  testeCloudKit
//
//  Created by Maria Tereza Martins Pérez on 22/10/24.
//
import Foundation
import CloudKit

class MessagingViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var messageText: String = ""

    private var container: CKContainer = CKContainer.default()
    private var publicDatabase: CKDatabase { container.publicCloudDatabase }

    func sendMessage() {
        let messageRecord = CKRecord(recordType: "Message")
        messageRecord["text"] = messageText
        
        publicDatabase.save(messageRecord) { [weak self] record, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Erro ao enviar mensagem: \(error.localizedDescription)")
                } else {
                    self?.messages.append(Message(id: record!.recordID, text: self?.messageText ?? ""))
                    self?.messageText = ""
                    print("Mensagem enviada: \(self?.messageText ?? "")")
                }
            }
        }
    }

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
