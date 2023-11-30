//
//  IPhotoActionType.swift
//  Runner
//
//  Created by Sweet Pea on 21/11/2023.
//

import Foundation


protocol IPhotoActionType {
    func takePicture(context : UIViewController, delegate : SabianPhotoPickerDelegate?, config : SabianPhotoPickerConfig)
    
    func choosePicture(context : UIViewController, delegate : SabianPhotoPickerDelegate?, config : SabianPhotoPickerConfig)
}
