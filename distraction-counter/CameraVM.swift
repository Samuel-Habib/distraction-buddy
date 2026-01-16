//
//  CameraVM.swift
//  distraction-buddy
//
//  Created by Samuel Fahim on 1/15/26.
//

import SwiftUI
import AVFoundation
import AppKit


final class CameraVM: ObservableObject {
    @Published var session: AVCaptureSession?
    
    init(session: AVCaptureSession? = nil) {
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            self.session = captureSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.session = self.captureSession()
                }
            }
        case .denied:
            self.session = nil
            print("Auth denied")
            
        case .restricted:
            self.session = nil
            print("Restricted access")
        @unknown default:
            fatalError()
        }
    }
    
    func start() async {
        session?.startRunning()
    }
    
    func captureSession() -> AVCaptureSession?{
        let captureSession = AVCaptureSession()
        // Find the default video device.
        captureSession.beginConfiguration()
        
        defer { captureSession.commitConfiguration() }
        
        
        guard let videoDevice = AVCaptureDevice.default(for: .video) else{
            return nil
        }
        do{
            let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
            guard captureSession.canAddInput(videoDeviceInput) else { return nil}
            captureSession.addInput(videoDeviceInput)
            return captureSession
        } catch {
            print("\(error)")
            return nil
        }
        
        
    }
    
}




struct CameraNSView: NSViewRepresentable {
    
    
    typealias NSViewType = PreviewView
    
    var session: AVCaptureSession?
    
    func makeNSView(context: Context) -> NSViewType {
        .init()
    }
    
    func updateNSView(_ nsView: PreviewView, context: Context) {
        nsView.session = session
    }
    
    func makeCoordinator() -> () {
        
    }
    
    
    
}


//class PreviewView: NSView {
//    // Use a capture video preview layer as the view's backing layer.
//    override func makeBackingLayer() -> AVCaptureVideoPreviewLayer{
//        wantsLayer = true
//        return AVCaptureVideoPreviewLayer()
//    }
//    override func viewDidMoveToWindow() {
//        wantsLayer = true
//        layer = AVCaptureVideoPreviewLayer()
//    }
//
//    var previewLayer: AVCaptureVideoPreviewLayer {
//        layer as! AVCaptureVideoPreviewLayer
//    }
//
//    // Connect the layer to a capture session.
//    var session: AVCaptureSession? {
//        get { previewLayer.session }
//        set { previewLayer.session = newValue}
//    }
//}

final class PreviewView: NSView {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
    }
    
    override func makeBackingLayer() -> CALayer {
        AVCaptureVideoPreviewLayer()
    }
    
    var previewLayer: AVCaptureVideoPreviewLayer? {
        layer as? AVCaptureVideoPreviewLayer
    }
    
    var session: AVCaptureSession? {
        get { previewLayer?.session }
        set { previewLayer?.session = newValue }
    }
}
