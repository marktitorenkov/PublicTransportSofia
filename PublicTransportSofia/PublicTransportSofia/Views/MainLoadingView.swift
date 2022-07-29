//
//  LoadingView.swift
//  PublicTransportSofia
//
//  Created by Ognyan Stoimenov on 29.07.22.
//

import SwiftUI

struct MainLoadingView: View {
    var body: some View {
        VStack {
            Image(systemName: "bus.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()
            ProgressView()
                .padding()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        MainLoadingView()
    }
}
