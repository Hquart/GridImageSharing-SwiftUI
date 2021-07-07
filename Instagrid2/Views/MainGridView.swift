//
//  MainGridView.swift
//  Instagrid2
//
//  Created by Naji Achkar on 17/02/2021.
//

import SwiftUI

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: Notes:
// This struct is used to generate the main Grid according to the layout selected
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct MainGridView: View {
    
    @EnvironmentObject var layout: Layout
    @State private var imageSize: CGRect = .zero
    
    var body: some View {
        ZStack {
            switch layout.selected {
            case 1:
                VStack {
                    GridButton(buttonWidth: 300)
                    HStack {
                        GridButton(buttonWidth: 150)
                        GridButton(buttonWidth: 150)
                    }   }
            case 2:
                VStack {
                    HStack {
                        GridButton(buttonWidth: 150)
                        GridButton(buttonWidth: 150)
                    }
                    GridButton(buttonWidth: 300)
                }
            default:
                VStack {
                    HStack { GridButton(buttonWidth: 150)
                        GridButton(buttonWidth: 150) }
                    HStack { GridButton(buttonWidth: 150)
                        GridButton(buttonWidth: 150) }
                }
            }
        }
        .background(RectGetter(size: $imageSize))    // the background modifier gets the size of the mainGrid to make an Image same size
    }
}
///////////////////////////////////////////////////////////////////////////////////////
// MARK: RECT GETTER
///////////////////////////////////////////////////////////////////////////////////////
// This struct is used to return a View the size of the mainGridView so we can share it as an image
struct RectGetter: View {
    @Binding var size: CGRect
    
    var body: some View {
        GeometryReader { proxy in
            self.createView(proxy: proxy)
        }
    }
    func createView(proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.size = proxy.frame(in: .global)
        }
        return Rectangle().fill(Color.clear)
    }
}
///////////////////////////////////////////////////////////////////////////////////////
// MARK: PREVIEW
///////////////////////////////////////////////////////////////////////////////////////
struct MainGridView_Previews: PreviewProvider {
    static var previews: some View {
        MainGridView()
            .environmentObject(Layout())
    }
}



