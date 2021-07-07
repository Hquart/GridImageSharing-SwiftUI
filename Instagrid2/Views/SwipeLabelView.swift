//
//  SwipeLabel.swift
//  Instagrid2
//
//  Created by Naji Achkar on 27/05/2021.


import SwiftUI

struct SwipeLabelView: View {
    ////////////////////////////////////////////////////////////////////////////////////
    // MARK: Properties
    ////////////////////////////////////////////////////////////////////////////////////
    @EnvironmentObject var layout: Layout
    @EnvironmentObject var device: OrientationInfo
    
    @State private var showAlert: Bool = false // triggered when user tries to share an empty grid (1 picture minimum)
    @State private var imageSize: CGRect = .zero // used in shareLayout func to get the size of the image to be shared
    
    @Binding var sharingLayout: Bool // state where the activityController is displayed, back to false will dismiss it
    
    let emptyGridAlert = Alert(title: Text("Empty Grid"),
                               message: Text("Add a picture before sharing"),
                               dismissButton: .default(Text("OK")))
    ////////////////////////////////////////////////////////////////////////////////////
    // MARK: BODY
    ////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        VStack {
            Text(device.orientation == .portrait ? "^" : "<")
            Text(device.orientation == .portrait ? "Swipe Up to Share" : "Swipe Left to Share")
        }
        .foregroundColor(.white)
        .font(.custom("Delm Medium", size: 40))
        .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local).onEnded { value in
            
            if !layout.isEmpty {
                // if Portrait Mode, we check it's a swipeUp, if landscape, check for swipeLeft
                if device.orientation == .portrait  && value.translation.height < 0 && value.translation.width < 100 && value.translation.width > -100 ||
                    device.orientation == .landscape  && value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                    // once the swipe is detected, we enter sharingLayout State
                    sharingLayout.toggle()
                    // we create a delay so that the animation finishes before triggering the func (no completion Handler available at this time)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        shareLayout()
                    }
                }
                // if layout is empty (has no pictures), alert is triggered
            } else {
                showAlert.toggle()
            }
        })
        .alert(isPresented: $showAlert) {  emptyGridAlert }
    }
    ////////////////////////////////////////////////////////////////////////////////////
    // MARK: Method - shareLayout()
    ////////////////////////////////////////////////////////////////////////////////////
    func shareLayout() {
        // Creates the UIImage to be shared and presents the Activity Controller for sharing options
        guard let imageToShare = UIApplication.shared.windows[0].rootViewController?.view.asImage(rect: imageSize) else { return }
        let activityController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityController, animated: true, completion: nil)
        
        activityController.completionWithItemsHandler =  {
            (activityType: UIActivity.ActivityType?, completed: Bool, arrayReturnedItems: [Any]?, error: Error?) in
            sharingLayout.toggle() // on dismiss, the MainGrid will be back to its initial position
        }
    }
}
////////////////////////////////////////////////////////////////////////////////////
// MARK: PREVIEW
////////////////////////////////////////////////////////////////////////////////////
struct SwipeLabelView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.appColor
                .zIndex(0)
                .edgesIgnoringSafeArea(.all)
            SwipeLabelView(sharingLayout: .constant(false))
                .environmentObject(Layout())
                .environmentObject(OrientationInfo())
        }
    }
}


