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
        let sw = NSScreen.main?.frame.width ?? 200
        let sh = NSScreen.main?.frame.height ?? 200
        // let sx = NSScreen.main?.frame.origin.x ?? 0
        // let sy = NSScreen.main?.frame.origin.y ?? 0

        let window = self.view.window!

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
            window.setFrameOrigin(
                NSPoint(
                    x: (sw - window.frame.width) / 2,
                    y: (sh - window.frame.height) / 2
                )
            )
        }
        else {
            // The window is placed exactly in the center horizontally and
            // somewhat above center vertically.
            window.center()
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

