////
////  ContentView.swift
////  testeCloudKit
////
////  Created by Maria Tereza Martins Pérez on 22/10/24.
////
//import SwiftUI
//
//struct ContentView: View {
//    
//    @StateObject var pairingVM = PairingViewModel()
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Status: \(pairingVM.statusMessage)")
//                    .foregroundColor(.red)
//                    .padding()
//                
//                NavigationLink(destination: PairingView(pairingVM: pairingVM)) {
//                    Text("Ir para emparelhamento")
//                }
//                
//                NavigationLink(destination: MessagingView(messagingVM: MessagingViewModel(), pairingVM: pairingVM)) {
//                    Text("Ir para mensagens")
//                }
//            }
//            .navigationTitle("Menu")
//        }
//    }
//}
