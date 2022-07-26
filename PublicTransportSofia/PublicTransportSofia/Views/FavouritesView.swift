//
//  SwiftUIView.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 26.07.22.
//

import SwiftUI

struct FavouritesView: View {
    var body: some View {
        NavigationView {
            Text("Favourites")
            .navigationTitle("Favourites")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
