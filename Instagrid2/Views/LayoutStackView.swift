//
//  LayoutStack.swift
//  Instagrid2
//
//  Created by Naji Achkar on 29/05/2021.
//

import SwiftUI

// Layout Class is used to publish LayoutStack state and put it in the environment
////////////////////////////////////////////////////////////////////////////////////
class Layout: ObservableObject {
    @Published var selected: Int = 1
    @Published var isEmpty: Bool = true
}
////////////////////////////////////////////////////////////////////////////////////
struct LayoutStackView: View {
    @EnvironmentObject var layout: Layout
    @EnvironmentObject var device: OrientationInfo

    var body: some View {
        Group {
            ForEach(1..<4, id: \.self) { id in
                Button(action: { switchLayout(selection: id) }) {
                    Image(layout.selected == Int(id)  ? "Selected \(id)" : "Layout \(id)")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
            }
        }
    }
////////////////////////////////////////////////////////////////////////////////////
// MARK: Method - switchLayout()
////////////////////////////////////////////////////////////////////////////////////
    func switchLayout(selection: Int) {
        layout.selected = selection
        layout.isEmpty = true
    }
}
////////////////////////////////////////////////////////////////////////////////////
// MARK: Preview
////////////////////////////////////////////////////////////////////////////////////
struct LayoutStackView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LayoutStackView()
                .zIndex(1)
                .environmentObject(Layout())
        }
        HStack {
            LayoutStackView()
                .zIndex(1)
                .environmentObject(Layout())
        }
    }
}
