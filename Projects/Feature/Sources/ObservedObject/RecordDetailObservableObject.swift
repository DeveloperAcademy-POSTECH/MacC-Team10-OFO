//
//  RecordDetailObservableObject.swift
//  Feature
//
//  Created by 박승찬 on 10/23/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import Foundation
import SwiftUI
import PhotosUI
import Core
import Common

protocol RecordDetailDelegate: AnyObject {
    func setRecord(record: Record, index: Int)
}

class RecordDetailObservableObject: ObservableObject {
    @Published var record: Record

    @Published var isActionSheetShowing: Bool
    @Published var showPhotoPicker: Bool

    @Published var certifyingImage: Image = Image(asset: CommonAsset._2387)

    weak var delegate: RecordDetailDelegate?
    let recordInedx: Int

    init(record: Record,
         isActionSheetShowing: Bool = false,
         showPhotoPicker: Bool = false,
         delegate: RecordDetailDelegate,
         recordIndex: Int,
         imageState: ImageState = .empty,
         imageSelection: PhotosPickerItem? = nil
    ) {
        self.record = record
        self.isActionSheetShowing = isActionSheetShowing
        self.showPhotoPicker = showPhotoPicker
        self.delegate = delegate
        self.recordInedx = recordIndex
        self.imageState = imageState
        self.imageSelection = imageSelection

        if let image = record.image {
            self.certifyingImage = image
        }
    }

    // MARK: - Image Picker

    enum ImageState {
        case empty
        case loading(Progress)
        case success(Image)
        case failure(Error)
    }

    enum TransferError: Error {
        case importFailed
    }

    struct CertifyingImage: Transferable {
        let image: Image

        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
                guard let uiImage = UIImage(data: data) else {
                    throw TransferError.importFailed
                }
                let image = Image(uiImage: uiImage)
                return CertifyingImage(image: image)
            }
        }
    }

    @Published private(set) var imageState: ImageState = .empty
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }

    @Published var mockRecord = Record(matchDate: Date(),
                                   distanceCovered: 4.5,
                                   calories: 1200,
                                   goal: PlayerGoals(goalCalories: 1500,
                                                     goalDistanceCovered: 5),
                                   playTime: Date())

    var distanceCoveredPercentage: Double {
        return record.distanceCovered / record.goal.goalDistanceCovered
    }

    var caloriesPercentage: Double {
        return record.calories / record.goal.goalCalories
    }
    func updateRecord(image: Image?) {
        var updateRecord = self.record
        updateRecord.image = image
        self.delegate?.setRecord(record: updateRecord, index: self.recordInedx)

    }

    // MARK: - Private Methods

    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: CertifyingImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let image?):
                    self.imageState = .success(image.image)
                    self.certifyingImage = image.image
                    self.updateRecord(image: image.image)
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
}
