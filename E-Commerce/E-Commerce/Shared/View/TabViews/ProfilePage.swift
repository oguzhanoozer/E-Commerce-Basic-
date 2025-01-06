//
//  ProfilePage.swift
//  EcommerceAppKit (iOS)
//
//  Created by oguzhan on 25/11/24.
//

import SwiftUI

struct ProfilePage: View {
    
    var body: some View {
        
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    Text(AppTitleConstants.myProfile)
                        .font(.custom(customFont, size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    UserInfo()
                    
                    // Custom Navigation Links...
                    
                    CustomNavigationLink(title: AppTitleConstants.editProfile) {
                        
                        Text("")
                            .navigationTitle(AppTitleConstants.editProfile)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(AppColor.homeBG.ignoresSafeArea())
                    }
                    
                    
                    CustomNavigationLink(title:AppTitleConstants.shopppingAddress) {
                        
                        Text("")
                            .navigationTitle(AppTitleConstants.shopppingAddress)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(AppColor.homeBG.ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: AppTitleConstants.orderHistory) {
                        
                        Text("")
                            .navigationTitle(AppTitleConstants.orderHistory)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(AppColor.homeBG.ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: AppTitleConstants.cards) {
                        
                        Text("")
                            .navigationTitle(AppTitleConstants.cards)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(AppColor.homeBG.ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: AppTitleConstants.notifications) {
                        
                        Text("")
                            .navigationTitle(AppTitleConstants.notifications)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(AppColor.homeBG.ignoresSafeArea())
                    }
                }
                .padding(.horizontal,22)
                .padding(.vertical,20)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            
                AppColor.homeBG
                    .ignoresSafeArea()
            )
        }
    }
    
    @ViewBuilder
    fileprivate func UserInfo() -> some View {
         VStack(spacing: 15){
            
            Image(ImageItems.App.profileImage.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .offset(y: -30)
                .padding(.bottom,-30)
            
            Text("Rosina Doe")
                .font(.custom(customFont, size: 16))
                .fontWeight(.semibold)
            
            HStack(alignment: .top, spacing: 10) {
                
                Image(systemName: "location.north.circle.fill")
                    .foregroundColor(.gray)
                    .rotationEffect(.init(degrees: 180))
                
                Text("Address: 43 Oxford Road\nM13 4GR\nManchester, UK")
                    .font(.custom(customFont, size: 15))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding([.horizontal,.bottom])
        .background(
            Color.white
                .cornerRadius(12)
        )
        .padding()
        .padding(.top,40)
    }
    
    // Avoiding new Structs...
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String,@ViewBuilder content: @escaping ()->Detail)->some View{
        
        
        NavigationLink {
            content()
        } label: {
            
            HStack{
                
                Text(title)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
            
                Color.white
                    .cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top,10)
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
