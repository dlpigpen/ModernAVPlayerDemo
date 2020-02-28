//
//  ViewController.swift
//  ModernMusicDemo
//
//  Created by Duc Nguyen on 2/18/20.
//  Copyright © 2020 ModernMusicDemo. All rights reserved.
//

import UIKit
import ModernAVPlayer

class ViewController: UIViewController {
    
    @IBOutlet weak var txtLink: UITextField!
    @IBOutlet weak var swtRepeat: UISwitch!
    @IBOutlet weak var swtAutostart: UISwitch!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    let player = ModernAVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getURLMedia() -> URL? {
        let urlString = self.txtLink.text ?? ""
        return  URL(string: urlString)
    }
    
    @IBAction func playPressed(_ sender: Any) {
        // Valid URL entered
        guard let url = getURLMedia() else {
            self.lblState.text = "The link is invalid"
            return
        }
        
        // genrate media for modern avplayer
        let media = ModernAVPlayerMedia(url: url, type: .clip)
        
        // assign delegate
        player.delegate = self
       
        // determine looping
        player.loopMode = swtRepeat.isOn
        
        // load media into the player
        player.load(media: media, autostart: swtAutostart.isOn)
        
        // play
        player.play()
        
    }
    
    @IBAction func btnRepeatChanged(_ sender: Any) {
        let switchBtn = sender as! UISwitch
        self.player.loopMode = switchBtn.isOn
    }
    
    @IBAction func autoStartChanged(_ sender: Any) {
        let switchBtn = sender as! UISwitch
        guard let url = getURLMedia() else { return }
        
        let media = ModernAVPlayerMedia(url: url, type: .clip)
        self.player.load(media: media, autostart: switchBtn.isOn)
    }
    
}


extension ViewController: ModernAVPlayerDelegate {
    func modernAVPlayer(_ player: ModernAVPlayer, didStateChange state: ModernAVPlayer.State) {
         DispatchQueue.main.async {
            self.lblState.text = "State: " + state.description
        }
    }
}
