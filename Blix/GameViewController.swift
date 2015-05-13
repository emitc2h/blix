//
//  GameViewController.swift
//  Blix
//
//  Created by Michel Trottier-McDonald on 5/3/15.
//  Copyright (c) 2015 Michel Trottier-McDonald. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
