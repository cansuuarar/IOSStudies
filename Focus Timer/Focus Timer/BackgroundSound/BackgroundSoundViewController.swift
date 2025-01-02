//
//  BackgroundSoundViewController.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 27.12.2024.
//

import UIKit

final class BackgroundSoundViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private weak var volumeSlider: UISlider!
    @IBOutlet private weak var tableView: UITableView!
    private var backgroundViewModel = BackgroundSoundViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction private func okButtonPressed(_ sender: Any) {
        guard let savedSound =  SoundManager.shared.sound else { return }
        backgroundViewModel.saveToUserdefaults(soundName: savedSound)
        backgroundViewModel.stopSound()
        self.tabBarController?.selectedIndex = 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Sound.allSounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "soundListCell") as? BackgroundSoundTableViewCell else { fatalError() }
        cell.soundLabel.text = Sound.allSounds[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         SoundManager.shared.sound = Sound.allSounds[indexPath.row].name
        guard let savedSound = SoundManager.shared.sound else { return }
        backgroundViewModel.playSound(name: savedSound)
    
         */}
}








/*Sound Effect by <a href="https://pixabay.com/users/freesound_community-46691455/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=6159">freesound_community</a> from <a href="https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=6159">Pixabay</a>
 */
