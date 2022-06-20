//
//  SwiftUISampleView.swift
//  JamitFoundationExample
//
//  Created by Murat Yilmaz on 20.06.22.
//  Copyright © 2022 Jamit Labs GmbH. All rights reserved.
//

import Foundation
import JamitFoundation
import SwiftUI
import SwiftUISupport
import UIKit

@available(iOS 13.0, *)
struct SwiftUISampleView: View {
    @State private var images: [URL] = []

    var body: some View {
        ScrollView {
            VStack {
                StatefulSwiftUIView<ActionView<ListItemView>>(
                    model: .constant(
                        ActionViewModel(
                            content: ListItemViewModel(title: "Add"),
                            action: {
                                images.append(URL(string: "https://picsum.photos/200")!)
                            }
                        )
                    )
                )
                .frame(height: 44)

                ForEach(images, id: \.self) { url in
                    StatefulSwiftUIView<ImageView>(model: .constant(.url(url)))
                        .frame(height: 200)
                }
            }
        }
    }
}
