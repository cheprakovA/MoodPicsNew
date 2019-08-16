//
//  CustomNavigationControllerViewController.swift
//  MoodPics
//
//  Created by Artemy Cheprakov on 14/08/2019.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }


}
