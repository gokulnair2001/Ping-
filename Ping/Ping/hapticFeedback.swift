//
//  hapticFeedback.swift
//  Ping
//
//  Created by Gokul Nair on 26/11/20.
//

import Foundation
import AVKit

class haptic{
    
    static let hapticTouch = haptic()
    
    func haptiFeedbackSucess() {
  let generator = UINotificationFeedbackGenerator()
  generator.notificationOccurred(.success)
  }
  
 func haptiFeedbackWarning() {
  let generator = UINotificationFeedbackGenerator()
      generator.notificationOccurred(.warning)
  }
}
