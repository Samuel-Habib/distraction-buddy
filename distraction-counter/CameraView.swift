//
//  CameraView.swift
//  distraction-buddy
//
//  Created by Samuel Fahim on 1/15/26.
//

import SwiftUI

struct CameraView: View {
    @StateObject var cameraVM = CameraVM()
    var body: some View {
        ZStack {
            CameraNSView(session: cameraVM.session)
        }.task {
            await cameraVM.start()
        }
    }
}


#Preview {
    CameraView()
}
