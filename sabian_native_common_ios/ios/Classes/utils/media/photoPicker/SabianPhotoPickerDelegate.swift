//
//  SabianPhotoPickerDelegate.swift
//  Runner
//
//  Created by bryosabian on 21/11/2023.
//

import Foundation


protocol SabianPhotoPickerDelegate : AnyObject {
    func onPhotoSuccess(_ images : [UIImage])
    func onPhotoError(_ error : Error)
}
