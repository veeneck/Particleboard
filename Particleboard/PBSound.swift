//
//  PBSound.swift
//  Particleboard
//
//  Created by Ryan Campbell on 12/7/15.
//  Copyright © 2015 Phalanx Studios. All rights reserved.
//

import SpriteKit
import AVFoundation

/**
 Static class to help playback of soudn effects. Provides utility like randomizing sounds, and allowing multiple sounds to play at once.
 */
public class PBSound : NSObject, AVAudioPlayerDelegate {
    
    /// AVPlayer expects a volume of 0 to 1. Making this an Int just abstracts it to something easier to read. If you set it to 6, 0.6 would be passed to AVPlayer.
    public var volume : Int = 8
    
    private var players = [AVAudioPlayer]()
    
    
    // MARK: Initialization
    
    /// Shared instance and only way to properly access the class.
    public static let sharedInstance = PBSound()
    
    
    // MARK: Playback
    
    public func playSoundOnNode(node:SKNode, fileName:String) {
        node.runAction(self.getSKActionForSound(fileName))
    }
    
    public func getSKActionForSound(fileName:String, distanceFromCamera:Float? = nil, cameraZoom:CGFloat? = nil) -> SKAction {
        var volume = self.getVolume()
        if let _ = distanceFromCamera {
            volume = self.adjustVolumeByDistanceAndZoom(distanceFromCamera!, zoom: cameraZoom!)
        }
        if(volume == 0) {
            return SKAction.runBlock({})
        }
        else {
            return SKAction.runBlock({
                if let player = self.loadAVAudioPlayer(fileName) {
                    player.volume = volume
                    player.numberOfLoops = 0
                    player.prepareToPlay()
                    player.play()
                    self.players.append(player)
                }
            })
        }
    }
    
    // MARK: Volume Control
    
    public func changeVolumeByIncrement(increment:Int) {
        let newVolume = self.volume + increment
        if(newVolume >= 0 && newVolume <= 10) {
            self.volume = newVolume
        }
    }
    
    /// Turn our Int based voulme into the Float expected by AVPlayer
    private func getVolume() -> Float {
        if self.volume > 0 {
            return Float(self.volume) / 10
        }
        else {
            return 0
        }
    }
    
    private func adjustVolumeByDistanceAndZoom(distance:Float, zoom:CGFloat) -> Float {
        let volume = self.adjustVolumeByDistance(distance)
        return self.adjustVolumeByZoom(zoom, volume: volume)
    }
    
    private func adjustVolumeByDistance(distance:Float) -> Float {
        var volume = self.getVolume()
        let offset = floor(distance / 200)
        let percentage = offset / 10
        if offset > 0 {
            volume = volume * (1 - percentage)
        }
        if(volume < 0.1) {
            return 0
        }
        return volume
    }
    
    private func adjustVolumeByZoom(zoom:CGFloat, volume:Float) -> Float {
        return volume * Float((1 + (1 - zoom)))
    }
    
    // MARK: Utility
    
    private func loadAVAudioPlayer(fileName:String) -> AVAudioPlayer? {
        let ret : AVAudioPlayer
        let url = NSBundle.mainBundle().URLForResource(fileName, withExtension: nil)
        if (url == nil) {
            print("Could not find file: \(fileName)")
            return nil
        }
        
        do {
            ret = try AVAudioPlayer(contentsOfURL: url!)
            ret.delegate = self
        } catch _ as NSError {
            return nil
        }
        return ret
    }
    
    // MARK: AVAudioPlayer Delegate
    
    @objc public func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        for (i, existingPlayer) in self.players.enumerate() {
            if existingPlayer == player {
                self.players.removeAtIndex(i)
            }
        }
    }
    
    @objc public func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        print("error decoding")
    }
    
}

