//
//  LoginView.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 4/15/25.
//

import SwiftUI
import LocalAuthentication
import MapKit

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showMap = false
   

    var body: some View {
        
       VStack(spacing: 16) {
         //   ClusterBottomSheetMap()
//            ReusableComponent(component: .email(text: $email))
//            ReusableComponent(component: .password(text: $password, faceIDAction: authenticateWithFaceID))
//            ReusableComponent(component: .loginButton(action: handleLogin))
        //}
        //.padding()
        
//        .fullScreenCover(isPresented: $showMap) {
//            ClusterBottomSheetMap()
             }
    }
    
    func handleLogin() {
        // login logic
        showMap = true
        
    }
    
    func authenticateWithFaceID() {
        //faceid logic
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

