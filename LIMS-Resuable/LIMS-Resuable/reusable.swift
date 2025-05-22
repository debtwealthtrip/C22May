//
//  reusable.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 4/9/25.
//

import SwiftUI

struct ReusableComponent: View {
    let component: ComponentType

    var body: some View {
        switch component {
        case .email(let text):
            return AnyView(
                HStack {
                    Image(systemName: "person.circle")
                        .foregroundColor(AppColors.primaryColor)
                    TextField("", text: text, prompt: Text("E-mail").foregroundColor(AppColors.primaryColor.opacity(0.6)))
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .foregroundColor(AppColors.primaryColor) // For entered text color.
                }
                    .inputFieldStyle()
            )
        case .password(let text, let faceIDAction):
            return AnyView(
                HStack{
                    Image(systemName: "key")
                        .foregroundColor(AppColors.primaryColor)
                    SecureField("", text: text, prompt: Text("Password").foregroundColor(AppColors.primaryColor.opacity(0.6)))
                    Button(action: faceIDAction) {
                                            Image(systemName: "faceid")
                            .foregroundColor(AppColors.primaryColor)
                                        }
                }
                    .inputFieldStyle()
                
            )
        case .loginButton(let action):
            return AnyView(
                Button(action: action) {
                    Text("Log In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColors.primaryColor)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
            )
            
            
        }
    }
}
