//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class MyScrollViewController: StatefulViewController<MyScrollViewControllerViewModel>{
    @IBOutlet private var textLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "MyScrollViewController"
    }

    override func didChangeModel() {
        super.didChangeModel()

        textLabel.text = model.text
    }
}
