//
//  LoginPage.swift
//  EcommerceAppKit (iOS)
//
//  Created by oguzhan on 25/11/24.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    
    
    var body: some View {
        
        VStack{
            
            // WElcome Back text for 3 half of the screen...
            Text(AppTitleConstants.welcome)
                .font(.custom(customFont, size: 55).bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,alignment: .leading)
                .frame(height: getRect().height / 3.5)
                .padding()
                .background(
                
                    Background()
                )
            
            ScrollView(.vertical, showsIndicators: false) {
                
                LoginPageView()
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                Color.white
                // Applying Custom Corners...
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColor.purple)
        
        // Clearing data when Changes...
        // Optional...
        .onChange(of: loginData.registerUser) { newValue in
            
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
        }
    }
    
    @ViewBuilder
    func CustomTextField(icon: String,title: String,hint: String,value: Binding<String>,showPassword: Binding<Bool>)->some View{
        
        VStack(alignment: .leading, spacing: 12) {
            
            Label {
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue{
                SecureField(hint, text: value)
                    .padding(.top,2)
            }
            else{
                TextField(hint, text: value)
                    .padding(.top,2)
            }
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
        // Showing Show Button for password Field...
        .overlay(
        
            Group{
                
                if title.contains("Password"){
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.custom(customFont, size: 13).bold())
                            .foregroundColor(AppColor.purple)
                    })
                    .offset(y: 8)
                }
            }
            
            ,alignment: .trailing
        )
    }
    
    @ViewBuilder
    fileprivate func LoginButton() -> some View {
         Button {
            if loginData.registerUser{
                loginData.Register()
            }
            else{
                loginData.Login()
            }
        } label: {
            
            Text( AppTitleConstants.login)
                .font(.custom(customFont, size: 17).bold())
                .padding(.vertical,20)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(AppColor.purple)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
        }
        .padding(.top,25)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    fileprivate func RegisterButton() -> some View {
         Button {
            withAnimation{
                loginData.registerUser.toggle()
            }
        } label: {
            
            VStack {
                Text(loginData.registerUser ? AppTitleConstants.backToLogin:  AppTitleConstants.createAccount)
                    .font(.custom(customFont, size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(AppColor.purple)
                
            }
        }
        .padding(.top,8)
    }
    
    @ViewBuilder
    fileprivate func ForgotPasswordButton() -> some View {
         Button {
            loginData.ForgotPassword()
        } label: {
            
            Text(AppTitleConstants.forgotPassword)
                .font(.custom(customFont, size: 14))
                .fontWeight(.semibold)
                .foregroundColor(AppColor.purple)
        }
        .padding(.top,8)
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    @ViewBuilder
    fileprivate func Background() -> some View {
         ZStack{
            
            // Gradient Circle...
            LinearGradient(colors: [
                
                AppColor.loginCircle,
                AppColor.loginCircle
                    .opacity(0.8),
                AppColor.purple
            ], startPoint: .top, endPoint: .bottom)
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(.trailing)
            .offset(y: -25)
            .ignoresSafeArea()
            
            Circle()
                .strokeBorder(Color.white.opacity(0.3),lineWidth: 3)
                .frame(width: 30, height: 30)
                .blur(radius: 2)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(30)
            
            Circle()
                .strokeBorder(Color.white.opacity(0.3),lineWidth: 3)
                .frame(width: 23, height: 23)
                .blur(radius: 2)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.leading,30)
        }
    }
    
    @ViewBuilder
    fileprivate func LoginPageView() -> some View {
         // Login Page Form....
        VStack(spacing: 15){
            
            Text(loginData.registerUser ? AppTitleConstants.register : AppTitleConstants.login)
                .font(.custom(customFont, size: 22).bold())
                .frame(maxWidth: .infinity,alignment: .leading)
            
            // Custom Text Field...
            
            CustomTextField(icon: "envelope", title: AppTitleConstants.email, hint: AppTitleConstants.emailHint, value: $loginData.email, showPassword: .constant(false))
                .padding(.top,30)
            
            CustomTextField(icon: "lock", title: AppTitleConstants.password, hint: AppTitleConstants.passwordHint, value: $loginData.password, showPassword: $loginData.showPassword)
                .padding(.top,10)
            
            // Regsiter Reenter Password
            if loginData.registerUser{
                CustomTextField(icon: "envelope", title: AppTitleConstants.reEnterPassword, hint: AppTitleConstants.passwordHint, value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterPassword)
                    .padding(.top,10)
            }
            
            // Forgot Password Button...
            ForgotPasswordButton()
            
            
            // Login Button...
            LoginButton()
            
            
            // Register User Button...
            RegisterButton()
        }
        .padding(30)
    }
    
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
            .environment(\.locale, Locale(identifier: "tr_TR"))
    }
}
