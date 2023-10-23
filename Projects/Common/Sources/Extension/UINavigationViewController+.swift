//
//  UINavigationViewController+.swift
//  Common
//
//  Created by Ha Jong Myeong on 10/23/23.
//

import SwiftUI

// 네비게이션 바 투명도 설정을 위한 extension
extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = blurEffect
        navigationBar.isTranslucent = true
    }
}
