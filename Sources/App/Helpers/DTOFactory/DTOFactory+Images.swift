//
//  DTOFactory+Images.swift
//
//
//  Created by Artem Mayer on 06.08.2024.
//

import Vapor

extension DTOFactory {

    static func makeImages(from images: [Image]?, needsDimension: Bool = false) -> [ImageDTO]? {

        guard let images else { return nil }

        return images.compactMap { image in
            makeImage(from: image)
        }
    }

    static func makeImage(from image: Image?, needsDimension: Bool = false) -> ImageDTO? {

        guard let image, image.hasSize else { return nil }

        let dimension = needsDimension ? makeImageDimension(from: image.dimension) : nil

        return ImageDTO(small: image.small,
                        medium: image.medium,
                        large: image.large,
                        original: image.original,
                        dimension: dimension)
    }

    private static func makeImageDimension(from imageDimension: ImageDimension?) -> ImageDimensionDTO? {

        guard let imageDimension else { return nil }

        return ImageDimensionDTO(width: imageDimension.width, height: imageDimension.height)
    }

}
