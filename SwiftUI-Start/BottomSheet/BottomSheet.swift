//
//  BottomSheet.swift
//  SwiftUI-Start
//
//  Created by 최최광현 on 2/1/24.
//

import SwiftUI

struct BottomSheet<Content>: View where Content: View {
    
    @ViewBuilder
    var contentBuilder: () -> Content
    
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .frame(height: 100)
                .clipShape(
                    UnevenRoundedRectangle(topLeadingRadius: 10, topTrailingRadius: 10)
                )
                .overlay(
                    contentBuilder()
                )
        }
    }
}
