//
//  PairingView.swift
//  testeCloudKit
//
//  Created by Maria Tereza Martins Pérez on 22/10/24.
//
import SwiftUI

struct PairingView: View {
    @ObservedObject var pairingVM = PairingViewModel()

    var body: some View {
        VStack {
            TextField("Código de Pareamento", text: $pairingVM.pairingCode)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Gerar Código") {
                pairingVM.generatePairingCode()
            }

            Button("Parear Dispositivo") {
                pairingVM.pairDevice(with: pairingVM.pairingCode)
            }
            .disabled(pairingVM.pairingCode.isEmpty)

            Text(pairingVM.message)
                .padding()
        }
        .padding()
    }
}
