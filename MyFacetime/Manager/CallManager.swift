//
//  CallManager.swift
//  MyFacetime
//
//  Created by gael on 19/07/2024.
//

import Foundation
import StreamVideo
import StreamVideoUIKit
import StreamVideoSwiftUI

class CallManager {
    static let shared = CallManager()
    
    struct Constants {
        static let userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiWnVja3VzcyIsImlzcyI6Imh0dHBzOi8vcHJvbnRvLmdldHN0cmVhbS5pbyIsInN1YiI6InVzZXIvWnVja3VzcyIsImlhdCI6MTcyMTM5NDgzMCwiZXhwIjoxNzIxOTk5NjM1fQ.xTobJFEw9W_rLrgZ9sDWv_pr0CAO2pyKmDwLNF-6lQU"
    }
    
    private var video: StreamVideo?
    private var videoUI: StreamVideoUI?
    public private(set) var callViewModel: CallViewModel?
    
    struct userCredentials {
        let user: User
        let token: UserToken
    }
    
    func setUp(email: String) {
        setUpCallViewModel()
        
        // User Credentials
        let credential = userCredentials(
            user: .guest(email),
            token: UserToken(rawValue: Constants.userToken)
        )
        
        // StreamVideo
        let video = StreamVideo(
            apiKey: "",
            user: credential.user,
            token: credential.token) { result in
                // Refresh token
                result(.success(credential.token))
            }
        
        // StreamVideoUI
        let videoUI = StreamVideoUI(streamVideo: video)
        
        self.video = video
        self.videoUI = videoUI
        
    }
    
    private func setUpCallViewModel() {
        guard callViewModel == nil else { return }
        DispatchQueue.main.async {
            self.callViewModel = CallViewModel()
        }
    }
}
