//
//  MessagingView.swift
//  testeCloudKit
//
//  Created by Maria Tereza Martins Pérez on 22/10/24.
//
import SwiftUI

struct MessagingView: View {
    @ObservedObject var messagingVM = MessagingViewModel()

    var body: some View {
        VStack {
            List {
                ForEach(messagingVM.messages, id: \.id) { message in
                    Text(message.text)
                }
            }

            TextField("Mensagem", text: $messagingVM.messageText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Enviar Mensagem") {
                messagingVM.sendMessage()
            }
            .disabled(messagingVM.messageText.isEmpty)

            Button("Buscar Mensagens") {
                messagingVM.fetchMessages()
            }
        }
        .padding()
    }
}

