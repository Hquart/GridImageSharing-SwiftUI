//
//  GridButtonView.swift
//  Instagrid2
//
//  Created by Naji Achkar on 17/02/2021.
//
import SwiftUI
////////////////////////////////////////////////////////////////////////////////////
// MARK: Notes:
// Grid buttons compose the MainGridView
// Grid buttons action summon ImagePicker
////////////////////////////////////////////////////////////////////////////////////
struct GridButton: View {
    ////////////////////////////////////////////////////////////////////////////////////
    // MARK: Properties
    ////////////////////////////////////////////////////////////////////////////////////
    @EnvironmentObject var layout: Layout 
    
    @State private var hasImage = false
    @State private var showImagePicker = false
    
    @State private var pickedImage: Image?
    
    let buttonWidth: CGFloat
    ////////////////////////////////////////////////////////////////////////////////////
    // MARK: BODY
    ////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        Button(action: {  self.showImagePicker.toggle() }) {
                if hasImage {
                    pickedImage?
                        .resizable()
                        .frame(width: buttonWidth, height: 150)
                        .border(Color.bordersColor, width: 10)
                } else {
                    Image("Plus")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .frame(width: buttonWidth, height: 150)
                        .background(Color.white)
                        .border(Color.bordersColor, width: 10)
                }
        }
        .fullScreenCover(isPresented: $showImagePicker,
                          onDismiss: loadImage,
                          content: { ImagePicker(image: self.$pickedImage) })
    }
    ////////////////////////////////////////////////////////////////////////////////////
    // MARK: Method - loadImage()
    ////////////////////////////////////////////////////////////////////////////////////
    func loadImage() {
        if pickedImage != nil { // if user dismisses the picker without selecting an image, hasImage property needs to remain false
            self.hasImage = true
            layout.isEmpty = false // as soon as there is 1 single image on a button, Grid is not considered empty anymor
        }
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: PREVIEW
/////////////////////////////////////////////////////////////////////////////////////////////////////////
struct GridButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GridButton(buttonWidth: 150)
            GridButton(buttonWidth: 300)
        }
        .environmentObject(Layout())
    }
}
