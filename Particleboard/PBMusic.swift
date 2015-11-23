//
//  PBMusic.swift
//  Particleboard
//
//  Created by Ryan Campbell on 11/23/15.
//  Copyright © 2015 Phalanx Studios. All rights reserved.
//

import SpriteKit
import AVFoundation

/**
Static class to help playback of background tracks. Intended for longer music where PBSound is aimed at sound effects. The separation can allow for greater customization / performance down the road.
*/
public class PBMusic {
    
    /// AVPlayer expects a volume of 0 to 1. Making this an Int just abstracts it to something easier to read. If you set it to 6, 0.6 would be passed to AVPlayer.
    public var volume : Int = 2
    
    /// Handle on the main player.
    var player : AVAudioPlayer?
    
    /// A second player that will allow us to crossfade. Currently only supports one crossfade per instance of the class.
    /// This could be expanded by keeping  ahandle on the current player, and toggling back and forth ebtween the two.
    var crossPlayer : AVAudioPlayer?
    
    // MARK: Initialization

    /// Shared instance and only way to properly access the class.
    public static let sharedInstance = PBMusic()
    
    // MARK: Playback
    
    /// Start playing the music file on a loop.
    public func play(fileName:String) {
        if(self.player?.url!.lastPathComponent != fileName) {
            let handle = self.loadAVAudioPlayer(fileName)
            
            if handle != nil {
                self.player = handle
                self.player!.volume = self.getVolume()
                self.player!.numberOfLoops = -1
                self.player!.prepareToPlay()
                self.player!.play()
            }
        }
    }
    
    /// Sets up the second player with the new track to fade to. Call `transitionToCrossFade` to start playing.
    public func prepareCrossFade(fileName:String) {
        if(self.crossPlayer?.url!.lastPathComponent != fileName) {
            let handle = self.loadAVAudioPlayer(fileName)
            
            if handle != nil {
                self.crossPlayer = handle
                self.crossPlayer!.volume = 0
                self.crossPlayer!.numberOfLoops = -1
                self.crossPlayer!.prepareToPlay()
            }
        }
    }
    
    /// Gradually switch between tracks
    public func transitionToCrossFade() {
        if let time = self.player?.currentTime {
            self.crossPlayer?.currentTime = time
            self.crossPlayer?.play()
            self.increaseVolumeOverTime(self.crossPlayer!)
            self.fadeVolumeOverTime(self.player!)
        }
    }
    
    /// Pause the active player.
    public func pause() {
        self.player?.stop()
        self.crossPlayer?.stop()
    }
    
    // MARK: Volume Control
    
    public func changeVolumeByIncrement(increment:Int) {
        let newVolume = self.volume + increment
        if(newVolume >= 0 && newVolume <= 10) {
            self.volume = newVolume
        }
        
        // Update players.
        if let player = self.player {
            player.volume = self.getVolume()
        }
        
        if let cross = self.crossPlayer {
            cross.volume = self.getVolume()
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
    
    // MARK: Utility
    
    private func increaseVolumeOverTime(player:AVAudioPlayer){
        if player.volume < self.getVolume() {
            player.volume = player.volume + 0.01
            
            let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
            dispatch_after(dispatchTime, dispatch_get_main_queue(), { [weak self] in
                self?.increaseVolumeOverTime(player)
            })
            
        }
    }
    
    private func fadeVolumeOverTime(player:AVAudioPlayer){
        if player.volume > 0.1 {
            player.volume = player.volume - 0.01
            
            let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
            dispatch_after(dispatchTime, dispatch_get_main_queue(), { [weak self] in
                self?.fadeVolumeOverTime(player)
            })
            
        } else {
            player.pause()
            player.volume = self.getVolume()
        }
    }
    
    private func loadAVAudioPlayer(fileName:String) -> AVAudioPlayer? {
        let ret : AVAudioPlayer
        let url = NSBundle.mainBundle().URLForResource(fileName, withExtension: nil)
        if (url == nil) {
            print("Could not find file: \(fileName)")
            return nil
        }
        
        do {
            ret = try AVAudioPlayer(contentsOfURL: url!)
        } catch _ as NSError {
            return nil
        }
        return ret
    }

}
