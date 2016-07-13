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
    
    /// A handle on each player. When a player is playing, it must be kept in scope our else the sound won't be heard. So, the players are stored here, and then referenced for future plays. Should be cleared when a scene changes.
    private var cachedPlayers = Dictionary<String, AVAudioPlayer>()
    
    /// The distance increment where the volume will lower.
    private let distanceMarker : Float = 200
    
    /// A data structure to hold douns groupings. Groupings allow a file with different variations to be randomly played. Can also adjust frequency so that sometimes nothing is played. Conveniently provides the utility that would allow a bow to make different sounds when firing, or a unit to **sometimes** say something when selected.
    public struct SoundGrouping {
        
        public var fileName : String
        
        public var fileType : String
        
        public var filePrefix : String
        
        public var count : Int
        
        public var frequency : Int
        
        public var volumeModifier : Float
        
        public var lastPlayed : Int = -1
        
        public init(filename:String, fileType:String, filePrefix:String, count:Int, frequency:Int, volumeModifier:Float = 0) {
            self.fileName = filename
            self.fileType = fileType
            self.filePrefix = filePrefix
            self.count = count
            self.frequency = frequency
            self.volumeModifier = volumeModifier
        }
        
        public mutating func updateLastPlayed(newIndex:Int) {
            self.lastPlayed = newIndex
        }
        
    }
    
    /// Local storage of registered sound groups. String is the lookup key
    public var soundGroups = Dictionary<String, PBSound.SoundGrouping>()
    
    // MARK: Initialization
    
    /// Shared instance and only way to properly access the class.
    public static let sharedInstance = PBSound()
    
    // MARK: Playback
    
    /// Utility function to play a sound
    public func playSoundOnNode(node:SKNode, fileName:String) {
        node.run(self.getSKActionForSound(fileName: fileName))
    }
    
    /// Main call to play a sound. Returns the SKAction, which you can later run on the node of your choice. Optionally pass in distance arguments
    /// to have the volume dynamicly changed. If volume is so low it wouldn't be heard, returns an empty action to save resources
    public func getSKActionForSound(fileName:String, distanceFromCamera:Float? = nil, cameraZoom:CGFloat? = nil, volumeModifier:Float = 0) -> SKAction {
        var volume = self.getVolume()
        if let _ = distanceFromCamera {
            volume = self.adjustVolumeByDistanceAndZoom(distance: distanceFromCamera!, zoom: cameraZoom!)
        }
        if(volume == 0) {
            return SKAction.run({})
        }
        else {
            return SKAction.run({
                DispatchQueue.global(attributes: .qosUserInitiated).async { [weak self] in
                    if let player = self?.loadAVAudioPlayer(fileName: fileName) {
                        player.volume = volume + volumeModifier
                        player.numberOfLoops = 0
                        player.play()
                        ///self?.players.append(player)
                    }
                }
            })
        }
    }
    
    /// Instead of playing a specific file, this will look for any loaded sound groups and play a random file from that group. Example would be playing a random bow string, or random sword clank.
    public func getSKActionForSoundGroup(key:String, distanceFromCamera:Float? = nil, cameraZoom:CGFloat? = nil) -> SKAction {
        var volume = self.getVolume()
        if let _ = distanceFromCamera {
            volume = self.adjustVolumeByDistanceAndZoom(distance: distanceFromCamera!, zoom: cameraZoom!)
        }
        if(volume == 0) {
            return SKAction.run({})
        }
        else {
            if let fileName = self.getRandomFileFromSoundGroup(key: key) {
                volume += (self.soundGroups[key]?.volumeModifier)!

                if let player = self.cachedPlayers[fileName] {
                    return SKAction.run({
                        player.volume = volume
                        player.numberOfLoops = 0
                        player.prepareToPlay()
                        player.play()
                    })
                }
                else if let player = self.loadAVAudioPlayer(fileName: fileName) {
                    self.cachedPlayers[fileName] = player
                    return SKAction.run({
                            player.volume = volume
                            player.numberOfLoops = 0
                            player.prepareToPlay()
                            player.play()
                    })
                }
            }
        }
        return SKAction.run({})
    }

    
    // MARK: Volume Control
    
    /// Change volume to amount. Final volume must be between 1 and 10
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
    
    /// Takes a look at distance form center of screen and camera zoom and returns the adjust volume
    private func adjustVolumeByDistanceAndZoom(distance:Float, zoom:CGFloat) -> Float {
        var volume = self.adjustVolumeByDistance(distance: distance)
        return self.adjustVolumeByZoom(zoom: zoom, volume: volume)
    }
    
    /// Every `self.distanceMarker` increments decrease the volume by 10%
    private func adjustVolumeByDistance(distance:Float) -> Float {
        var volume = self.getVolume()
        let offset = floor(distance / self.distanceMarker)
        let percentage = offset / 10
        if offset > 0 {
            volume = volume * (1 - percentage)
        }
        if(volume < 0.02) {
            return 0
        }
        return volume
    }
    
    /// Adjust volume by inverse scale of the camera. So, a camera of 1.3 scale would be volume * 0.7
    private func adjustVolumeByZoom(zoom:CGFloat, volume:Float) -> Float {
        return volume * Float((1 + (1 - zoom)))
    }
    
    // MARK: Utility
    
    /// Reusable function to load an AVPlayer with a file
    private func loadAVAudioPlayer(fileName:String) -> AVAudioPlayer? {
        let ret : AVAudioPlayer
        let url = Bundle.main.urlForResource(fileName, withExtension: nil)
        if (url == nil) {
            print("Could not find file: \(fileName)")
            return nil
        }
        
        do {
            ret = try AVAudioPlayer(contentsOf: url!)
            ret.prepareToPlay()
            ret.delegate = self
        } catch _ as NSError {
            return nil
        }
        return ret
    }
    
    /// Randomzies soundgroup variations and returns a filename
    private func getRandomFileFromSoundGroup(key:String) -> String? {
        if let soundGroup = self.soundGroups[key] {
            if self.shouldPlayBasedOnFrequency(key: key) {
                var variation = 1
                if soundGroup.count != 1 {
                    var newIndex = -1
                    while newIndex < 0 {
                        let temp = Int.random(min: 1, max: soundGroup.count)
                        if temp != soundGroup.lastPlayed {
                            newIndex = temp
                            self.soundGroups[key]?.updateLastPlayed(newIndex: temp)
                        }
                    }
                    variation = newIndex
                }
                let fileName = "\(soundGroup.filePrefix)\(soundGroup.fileName)\(variation).\(soundGroup.fileType)"
                return fileName
            }
        }
        return nil
    }
    
    /// If a frequency is set, run a random generator to see if a sound hsould be played
    private func shouldPlayBasedOnFrequency(key:String) -> Bool {
        if let soundGroup = self.soundGroups[key] {
            if soundGroup.frequency > 1 {
                let chance = Int.random(min: 1, max: soundGroup.frequency)
                if chance != 1 {
                    return false
                }
            }
        }
        return true
    }
    
    // MARK: AVAudioPlayer Delegate
    
    /// Delegate to call when sound is finished so we can remove it from local storage array
    @objc public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        /*for (i, existingPlayer) in self.players.enumerated() {
            if existingPlayer == player {
                self.players.remove(at: i)
            }
        }*/
    }
    
    @objc public func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: NSError?) {
        print("error decoding")
    }
    
}

