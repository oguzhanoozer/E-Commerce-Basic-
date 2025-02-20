//
//  CartPage.swift
//  EcommerceAppKit (iOS)
//
//  Created by oguzhan on 25/11/24.
//

import SwiftUI

// Since both of the views are mostly identical....
struct CartPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    
    // Delete Option...
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        
        NavigationView{
            
            VStack(spacing: 10){
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack{
                        
                        HStack{
                            
                            Text(AppTitleConstants.basketTitle)
                                .font(.custom(customFont, size: 28).bold())
                            
                            Spacer()
                            
                            Button {
                                withAnimation{
                                    showDeleteOption.toggle()
                                }
                            } label: {
                                Image(AppTitleConstants.deleteTitle)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                            }
                            .opacity(sharedData.cartProducts.isEmpty ? 0 : 1)

                        }
                        
                        // checking if liked products are empty...
                        if sharedData.cartProducts.isEmpty{
                            
                            Group{
                                Image(AppTitleConstants.basketTitle)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                                    .padding(.top,35)
                                
                                Text(AppTitleConstants.noItemsAddedtitle)
                                    .font(.custom(customFont, size: 25))
                                    .fontWeight(.semibold)
                                
                                Text(AppTitleConstants.hitThePlusButtontitle)
                                    .font(.custom(customFont, size: 18))
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                    .padding(.top,10)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        else{
                         
                            // Displaying Products...
                            VStack(spacing: 15){
                                
                                // For Designing...
                                ForEach($sharedData.cartProducts){$product in
                                    
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
                                        
                                        CardView(product: $product)
                                    }
                                }
                            }
                            .padding(.top,25)
                            .padding(.horizontal,10)
                        }
                    }
                    .padding()
                }
                
                // Showing Total and check out Button...
                if !sharedData.cartProducts.isEmpty{
                    
                    Group{
                        
                        HStack{
                            
                            Text(AppTitleConstants.totalTitle)
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(sharedData.getTotalPrice())
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundColor(AppColor.purple)
                        }
                        
                        Button {
                            
                        } label: {
                            
                            Text(AppTitleConstants.checkoutTitle)
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundColor(.white)
                                .padding(.vertical,18)
                                .frame(maxWidth: .infinity)
                                .background(AppColor.purple)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal,25)
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            
                AppColor.homeBG
                .ignoresSafeArea()
            )
        }
    }
    
    func deleteProduct(product: Product){
        
        if let index = sharedData.cartProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
            
            let _ = withAnimation{
                // removing...
                sharedData.cartProducts.remove(at: index)
            }
        }
    }
}

struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
    }
}

struct CardView: View{
    
    // Making Product as Binding so as to update in Real time...
    @Binding var product: Product
    
    
    var body: some View{
        
        HStack(spacing: 15){
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(product.title)
                    .font(.custom(customFont, size: 18).bold())
                    .lineLimit(1)
                
                Text(product.price)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(AppColor.purple)
                
                QuantityButtons()
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
    
    @ViewBuilder
    fileprivate func QuantityButtons() -> some View {
         // Quantity Buttons...
        HStack(spacing: 10){
            
            Text(AppTitleConstants.quantityTitle)
                .font(.custom(customFont, size: 14))
                .foregroundColor(.gray)
            
            Button {
                product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
            } label: {
                Image(systemName: "minus")
                    .font(.caption)
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
                    .background(AppColor.quantity)
                    .cornerRadius(4)
            }
            
            Text("\(product.quantity)")
                .font(.custom(customFont, size: 14))
                .fontWeight(.semibold)
                .foregroundColor(.black)
            
            Button {
                product.quantity += 1
            } label: {
                Image(systemName: "plus")
                    .font(.caption)
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
                    .background(AppColor.quantity)
                    .cornerRadius(4)
            }
        }
    }
}
