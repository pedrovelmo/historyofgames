//
//  AudioManager.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 12/09/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import AVFoundation
import SpriteKit

public enum BackgroundMusic: String {
    
    case HappyFunk = "HappyFunk.mp3"
    case CarminaBurana = "CarminaBurana.mp3"
    case SpaceGroove = "SpaceGroove.mp3"
    case AdventureTune = "AdventureTune.mp3"
    case BobbleBits = "BobbleBits.mp3"
}

public enum ExplosionSound: String {
    
    case AwesomeExplosion = "AwesomeExplosion"
    case WilhemScream = "WilhemScream"
    case SuperSlapSound = "SuperSlapSound"
}

let audioManager = AudioManager()

class AudioManager{
    
    class var sharedInstance: AudioManager{
        return audioManager
    }
    
    private var musicPlayer = AVAudioPlayer()
    
    internal let explosionSound = SKAction.playSoundFileNamed(ExplosionSound.WilhemScream.rawValue, waitForCompletion: false)
    
    internal let jumpSound = SKAction.playSoundFileNamed("Jump.wav", waitForCompletion: false)
    
    internal let coinSound = SKAction.playSoundFileNamed("Coin.mp3", waitForCompletion: false)
    
    func playBackgroundMusicMenu(){
        
         var backgroundMusic: String? = BackgroundMusic.AdventureTune.rawValue
        
        
        do{
            try musicPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: backgroundMusic, ofType: nil)!))
            
        } catch{
            
        }
        
        musicPlayer.prepareToPlay()
        musicPlayer.numberOfLoops = -1
        musicPlayer.play()
    }
    
    func playBackgroundMusic(){
        
        var backgroundMusic: String? = BackgroundMusic.BobbleBits.rawValue
            

        
        do{
            try musicPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: backgroundMusic, ofType: nil)!))
            
        } catch{
            
        }
        
        musicPlayer.prepareToPlay()
        musicPlayer.numberOfLoops = -1
        musicPlayer.play()
    }
    
    func stopBackgroundMusic() {
        if self.musicPlayer.isPlaying {
            self.musicPlayer.stop()
            
        }
    }
}
