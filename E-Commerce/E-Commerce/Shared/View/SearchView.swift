//
//  SearchView.swift
//  EcommerceAppKit (iOS)
//
//  Created by oguzhan on 25/11/24.
//

import SwiftUI

struct SearchView: View {
    var animation: Namespace.ID
    
    // Shared Data...
    @EnvironmentObject var sharedData: SharedDataModel
    
    @EnvironmentObject var homeData: HomeViewModel
    
    // Activating Text Field with the help of FocusState...
    @FocusState var startTF: Bool
    
    
   
    
    var body: some View {
        
        VStack(spacing: 0){
            
            // Search Bar...
            HStack(spacing: 20){
                
                // Close Button...
                Button {
                    withAnimation{
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                    // Resetting...
                    sharedData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }

                // Search Bar...
                HStack(spacing: 15){
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    // Since we need a separate view for search bar....
                    TextField(AppTitleConstants.search, text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                }
                .padding(.vertical,12)
                .padding(.horizontal)
                .background(
                
                    Capsule()
                        .strokeBorder(AppColor.purple,lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing,20)
            }
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom,10)
            
            // Showing Progress if searching...
            // else showing no results found if empty...
            if let products = homeData.searchedProducts{
                
                if products.isEmpty{
                    // No Results Found....
                    NoResultView()
                }
                else{
                    // Filter Results....
                    filterResults(products)
                }
            }
            else{
                
                ProgressView()
                    .padding(.top,30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .background(
        
            AppColor.homeBG
                .ignoresSafeArea()
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
    }


    @ViewBuilder
    fileprivate func NoResultView() -> some View {
         
        VStack(spacing: 10){
            
            Image(ImageItems.App.notFound.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top,60)
            
            Text(AppTitleConstants.itemNotFound)
                .font(.custom(customFont,size: 22).bold())
            
            Text(AppTitleConstants.tryMoreGeneric)
                .font(.custom(customFont,size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal,30)
        }
        .padding()
    }


    @ViewBuilder
    fileprivate func filterResults(_ products: [Product]) -> ScrollView<some View> {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0){
                
                // Found Text...
                Text("Found \(products.count) results")
                    .font(.custom(customFont, size: 24).bold())
                    .padding(.vertical)
                
                // Staggered Grid...
                // See my Staggered Video..
                // Link in Bio...
                StaggeredGrid(columns: 2,spacing: 20, list: products) {product in
                    
                    // Card View....
                    ProductCardView(product: product)
                }
            }
            .padding()
        }
    }
        
    @ViewBuilder
    func ProductCardView(product: Product)->some View{
        
        VStack(spacing: 10){
            
            ZStack{
                
                if sharedData.showDetailProduct{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                }
                else{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
            }
            // Moving image to top to look like its fixed at half top...
            .offset(y: -50)
            .padding(.bottom,-50)
            
            Text(product.title)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle)
                .font(.custom(customFont, size: 14))
                .foregroundColor(.gray)
            
            Text(product.price)
                .font(.custom(customFont, size: 16))
                .fontWeight(.bold)
                .foregroundColor(AppColor.purple)
                .padding(.top,5)
        }
        .padding(.horizontal,20)
        .padding(.bottom,22)
        .background(
        
            Color.white
                .cornerRadius(25)
        )
        .padding(.top,50)
        .onTapGesture {
            
            withAnimation(.easeInOut){
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {

        MainPage()
    }
}
