//
//  PairingViewModel.swift
//  testeCloudKit
//
//  Created by Maria Tereza Martins Pérez on 22/10/24.
//
import Foundation
import CloudKit

class PairingViewModel: ObservableObject {
    @Published var pairingCode: String = ""
    @Published var isPaired: Bool = false
    @Published var message: String = ""

    private var container: CKContainer = CKContainer.default()
    private var publicDatabase: CKDatabase { container.publicCloudDatabase }

    func generatePairingCode() {
        pairingCode = String(format: "%04d", Int.random(in: 0...9999))
        print("Código de pareamento gerado: \(pairingCode)")
    }

    func pairDevice(with code: String) {
        let record = CKRecord(recordType: "Pairing")
        record["code"] = code

        publicDatabase.save(record) { [weak self] record, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.message = "Erro ao parear: \(error.localizedDescription)"
                } else {
                    self?.isPaired = true
                    self?.message = "Dispositivo pareado com sucesso!"
                    print("Dispositivo pareado com sucesso!")
                    
                    // Verificando se o código já está registrado
                    self?.checkPairingStatus(code: code)
                }
            }
        }
    }
    
    func checkPairingStatus(code: String) {
        let predicate = NSPredicate(format: "code == %@", code)
        let query = CKQuery(recordType: "Pairing", predicate: predicate)

        publicDatabase.perform(query, inZoneWith: nil) { [weak self] records, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Erro ao verificar o status de pareamento: \(error.localizedDescription)")
                } else if let records = records, !records.isEmpty {
                    self?.message = "Dispositivo conectado: \(code)"
                    print("Dispositivo conectado com o código: \(code)")
                } else {
                    self?.message = "Nenhum dispositivo pareado encontrado com esse código."
                    print("Nenhum dispositivo pareado encontrado com esse código.")
                }
            }
        }
    }
}

