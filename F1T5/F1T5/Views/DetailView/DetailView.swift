//
//  DetailView.swift
//  F1T5
//
//  Created by Enoch on 6/3/25.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var backBtn : some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            
        }
        .navigationTitle("상세보기")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backBtn)
    }
}

#Preview {
    DetailView()
}
