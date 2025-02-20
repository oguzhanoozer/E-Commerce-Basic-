//
//  LikedPage.swift
//  EcommerceAppKit (iOS)
//
//  Created by oguzhan on 25/11/24.
//

import SwiftUI

struct LikedPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    
    // Delete Option...
    @State var showDeleteOption: Bool = false
    
   
    
    var body: some View {
        
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    HStack{
                        
                        Text(AppTitleConstants.favorites)
                            .font(.custom(customFont, size: 28).bold())
                        
                        Spacer()
                        
                        Button {
                            withAnimation{
                                showDeleteOption.toggle()
                            }
                        } label: {
                            Image(AppTitleConstants.delete)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }
                        .opacity(sharedData.likedProducts.isEmpty ? 0 : 1)

                    }
                    
                    // checking if liked products are empty...
                    if sharedData.likedProducts.isEmpty{
                        
                        NoLikedProducts()
                    }
                    else{
                     
                        DisplayingProducts()
                    }
                }
                .padding()
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
    fileprivate func DisplayingProducts() -> some View {
         // Displaying Products...
        VStack(spacing: 15){
            
            // For Designing...
            ForEach(sharedData.likedProducts){product in
                
                HStack(spacing: 0){
                    
                    if showDeleteOption{
                        
                        Button {
                            deleteProduct(product: product)
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.red)
                        }
                        .padding(.trailing)
                        
                    }
                    
                    CardView(product: product)
                }
            }
        }
        .padding(.top,25)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    fileprivate func NoLikedProducts() -> some View {
         Group{
            Image(AppTitleConstants.noLiked)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .padding(.top,35)
            
            Text(AppTitleConstants.noFavorites)
                .font(.custom(customFont, size: 25))
                .fontWeight(.semibold)
            
            Text(AppTitleConstants.hitTHeLikeButtonSaveFavorite)
                .font(.custom(customFont, size: 18))
                .foregroundColor(.gray)
                .padding(.horizontal)
                .padding(.top,10)
                .multilineTextAlignment(.center)
        }
    }
    
    @ViewBuilder
    func CardView(product: Product)->some View{
        
        HStack(spacing: 15){
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(product.title)
                    .font(.custom(customFont, size: 18).bold())
                    .lineLimit(1)
                
                Text(product.subtitle)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(AppColor.purple)
                
                Text("\(AppTitleConstants.type): \(product.type.rawValue)")
                    .font(.custom(customFont, size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(
        
            Color.white
                .cornerRadius(10)
        )
    }
    
    func deleteProduct(product: Product){
        
        if let index = sharedData.likedProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
            
            let _ = withAnimation{
                // removing...
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())
    }
}
