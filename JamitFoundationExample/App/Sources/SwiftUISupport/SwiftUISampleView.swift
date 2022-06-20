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
    @State private var model: ListItemViewModel = .default

    var body: some View {
        ZStack {
            StatefulSwiftUIView

        }
    }
}
