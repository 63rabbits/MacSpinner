//
//  ViewController.swift
//  MacSpinner
//
//  Created by rabbit on 2025/05/02.
//

import Cocoa

class ViewController: NSViewController {


    override func viewDidAppear() {
        moveWindowToCenter()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }




    // MARK: -

    @IBAction func startButtonPushed(_ sender: Any) {
        centerSpinnerOnMac(centerSpinner, show: true)
    }
    
    @IBAction func stopButtonPushed(_ sender: Any) {
        centerSpinnerOnMac(centerSpinner, show: false)
    }




    // MARK: - Move the Window to Centr

    let trueCenter = true
    let windowScale = 0.5
    let windowMinWidth = CGFloat(200)
    let windowMinHeight = CGFloat(100)

    func moveWindowToCenter() {
        let screenFrame = NSScreen.main?.frame
        let window = self.view.window!

        let sw = screenFrame?.width ?? 200
        let sh = screenFrame?.height ?? 200
        let sx = screenFrame?.origin.x ?? 0
        let sy = screenFrame?.origin.y ?? 0

        // Set window size
        window.minSize = NSSize(width: windowMinWidth, height: windowMinHeight)
        let ww = CGFloat(sw * windowScale)
        let wh = CGFloat(sh * windowScale)
        window.setFrame(
            NSRect(x: 0, y: 0,
                   width: (ww > windowMinWidth ? ww : windowMinWidth),
                   height: (wh > windowMinHeight ? wh : windowMinHeight)
                  ),
            display: true
        )

        if trueCenter {
            // Center window
            // ^ Screen Y          | Window
            // |            Origin *-----
            // +-> Screen X
            let x = (sw - window.frame.width) / 2
            let y = (sh - window.frame.height) / 2
            let origin = NSPoint(x: sx + x, y: sy + y)
            window.setFrameOrigin(origin)

//            print("window-x= \(window.frame.origin.x), " +
//                  "window-y = \(window.frame.origin.y), " + "\n" +
//                  "windw-width= \(window.frame.width), " +
//                  "window-height= \(window.frame.size.height), " + "\n" +
//                  "screen-with= \(sw), " +
//                  "screen-height= \(sh)"
//            )
        }
        else {
            // The window is placed exactly in the center horizontally and
            // somewhat above center vertically.
            view.window?.center()
        }
        // Moves the window to the front of the screen list
        view.window?.makeKeyAndOrderFront(self)
    }




    // MARK: - Spinner

    var centerSpinner = NSProgressIndicator()

    func centerSpinnerOnMac(_ spinner: NSProgressIndicator, show: Bool = false, size: Int = 70) {
        if show {
            spinner.style = .spinning
            self.view.addSubview(spinner)

            // Centering
            let superView = spinner.superview!
            spinner.translatesAutoresizingMaskIntoConstraints = false
            spinner.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
            spinner.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
            spinner.widthAnchor.constraint(equalToConstant: CGFloat(size)).isActive = true
            spinner.heightAnchor.constraint(equalToConstant: CGFloat(size)).isActive = true

            spinner.startAnimation(nil)
        }
        else {
            spinner.stopAnimation(nil)
            spinner.removeFromSuperview()
        }
    }

}

