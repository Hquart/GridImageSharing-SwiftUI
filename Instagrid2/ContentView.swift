
//
//  ContentView.swift
//  Instagrid2
//  Created by Naji Achkar on 27/12/2020.

import UIKit
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var layout: Layout
    @EnvironmentObject var device: OrientationInfo
    @State private var showMainGrid: Bool = true
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        ZStack {
            Color.appColor // background color
                .zIndex(0)
                .edgesIgnoringSafeArea(.all)
            ////////////////////////////////////////////////////////////////////////////////////
            // MARK: Portrait Mode
            ////////////////////////////////////////////////////////////////////////////////////
            if device.orientation == .portrait {
                VStack {
                    Text("Instagrid 2.0")
                        .foregroundColor(.white)
                        .font(.custom("ThirstyScriptExtraBoldDemo", size: 40))
                    Spacer()
                    SwipeLabelView(sharingLayout: $showMainGrid)
                    if showMainGrid {
                        MainGridView()
                            .transition(AnyTransition.move(edge: .top))
                            .animation(.linear(duration: 1))
                    }
                    Spacer()
                    HStack {
                        LayoutStackView()
                    }
                }.animation(.easeInOut)
                ////////////////////////////////////////////////////////////////////////////////////
                // MARK: Landscape Mode
                ////////////////////////////////////////////////////////////////////////////////////
            } else if device.orientation == .landscape {
                HStack {
                    Spacer()
                    SwipeLabelView(sharingLayout: $showMainGrid)
                    Spacer()
                    VStack {
                        Text("Instagrid 2.0")
                            .foregroundColor(.white)
                            .font(.custom("ThirstyScriptExtraBoldDemo", size: 25))
                        if showMainGrid {
                            MainGridView()
                                .transition(.move(edge: .leading))
                                .animation(.linear(duration: 1))
                        }
                    }
                    Spacer(minLength: 150)
                    VStack {
                        LayoutStackView()
                    }
                    Spacer(minLength: 50)
                }
                .animation(.easeInOut)
            }
        }
    }
}
/////////////////////////////////////////////////////////////////////////////////////
// MARK: PREVIEWS
////////////////////////////////////////////////////////////////////////////////////

/////////////////////////// PORTRAIT ////////////////////////////
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Layout())
            .environmentObject(OrientationInfo())
    }
}
/////////////////////////// LANDSCAPE ////////////////////////////
// This struct inverts width and height to make a Landscape version of the View which we'll use for Landscape Preview
struct Landscape<Content>: View where Content: View {
    let content: () -> Content
    let height = UIScreen.main.bounds.width //toggle width height
    let width = UIScreen.main.bounds.height
    var body: some View {
        content().previewLayout(PreviewLayout.fixed(width: width, height: height))
    }
}
/////////////////////////// LANDSCAPE ////////////////////////////
//struct PreviewsDemo_Previews: PreviewProvider {
//    static var previews: some View {
//        Landscape {
//            ContentView()
//                .environmentObject(Layout())
//                .environmentObject(OrientationInfo())
//        }
//    }
//}

