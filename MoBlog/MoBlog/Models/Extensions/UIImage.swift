//
//  UIImage.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-08-23.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import Foundation
import SwiftUI

extension UIImage {
    
    enum DownsamplingError: Error {
        case unableToCreateImageSource
        case unableToCreateData
        case unableToCreateThumbnail
        case invalidScale
        case invalidSize
    }
    
    private func assertPreconditions(size: CGSize, scale: CGFloat) throws {
        assert(scale > 0)
        guard scale > 0 else { throw DownsamplingError.invalidScale }

        assert(size.width > 0)
        assert(size.height > 0)
        guard size.height > 0, size.width > 0 else { throw DownsamplingError.invalidSize }
    }
    
    //To downsample local images
    public func downsample(imageAt imageURL: URL, to size: CGSize, scale: CGFloat) throws -> UIImage {
        try assertPreconditions(size: size, scale: scale)

        //Tells CG to not go ahead and decode the image immediately. We will use this thumbnail object to fetch information from.
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions) else {
            throw DownsamplingError.unableToCreateImageSource
        }

        return try createThumbnail(from: imageSource, size: size, scale: scale)
    }

    //To downsample images loaded from HTTP responses
    public func downsample(imageData: Data, to frameSize: CGSize, scale: CGFloat) throws -> UIImage {
        try assertPreconditions(size: frameSize, scale: scale)

        //Tells CG to not go ahead and decode the image immediately. We will use this thumbnail object to fetch information from.
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary

        return try imageData.withUnsafeBytes{ (unsafeRawBufferPointer: UnsafeRawBufferPointer) -> UIImage in
            let unsafeBufferPointer = unsafeRawBufferPointer.bindMemory(to: UInt8.self)
            guard let unsafePointer = unsafeBufferPointer.baseAddress else {throw DownsamplingError.unableToCreateData}

            let dataPtr = CFDataCreate(kCFAllocatorDefault, unsafePointer, imageData.count)
            guard let data = dataPtr else { throw DownsamplingError.unableToCreateData }
            guard let imageSource = CGImageSourceCreateWithData(data, imageSourceOptions) else {
                throw DownsamplingError.unableToCreateImageSource
            }

            return try createThumbnail(from: imageSource, size: frameSize, scale: scale)
        }
    }

    /// - Parameters:
    ///     - imageSource the source that will be rendered as thumbnail
    ///     - size: this is the size the resulting image will have if everythig goes well.
    ///     - scale: use this multiplier (0..1] to alter the content. 0.1 will result in a very pixelated image. 1 will result in the original image
    ///
    /// - Return value: throw an Error if something went wrong, or the UIImage if the downsampling was possible
    private func createThumbnail(from imageSource: CGImageSource, size: CGSize, scale:CGFloat) throws -> UIImage {
        let maxDimensionInPixels = max(size.width, size.height) * scale
        let options = [
            //kCGImageSourceShouldCacheImmediately is the most important option.
            //Tell CG that to decode the thumbnail it immediately.
            //At that exact moment, the decoded image buffer is created and the cpu hit for decoding is received.
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
        guard let thumbnail = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options) else {
            throw DownsamplingError.unableToCreateThumbnail
        }
        
        return UIImage(cgImage: thumbnail)
    }
}
