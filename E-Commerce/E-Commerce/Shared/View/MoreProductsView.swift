//
//  MoreProductsView.swift
//  EcommerceAppKit (iOS)
//
//  Created by oguzhan on 25/11/24.
//

import SwiftUI

struct MoreProductsView: View {
    var body: some View {
        
        VStack{
            Text(AppTitleConstants.moreProducts)
                .font(.custom(customFont, size: 24).bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity,alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
        .background(AppColor.homeBG.ignoresSafeArea())
    }
}

struct MoreProductsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreProductsView()
    }
}
