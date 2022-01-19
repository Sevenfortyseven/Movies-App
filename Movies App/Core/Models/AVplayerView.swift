//
//  playerView.swift
//  Movies App
//
//  Created by aleksandre on 19.01.22.
//

import AVKit
import UIKit

class PlayerView: UIView {
    
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    var player: AVPlayer {
        get {
            return playerLayer.player!
        }
        set {
            playerLayer.player = newValue
        }
        
    }
}
