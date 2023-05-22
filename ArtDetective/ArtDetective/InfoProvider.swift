//
//  InfoProvider.swift
//  ArtDetective
//
//  Created by Radolina on 19/05/2023.
//

import Foundation
class InfoProvider {
    
    func art(for art: String) -> String {
        switch art {
            case "Girl With A Pearl Earring, 1665":
                return "Girl With A Pearl Earring"
            case "Sunflowers, 1888", "The Starry Night, 1889":
                return "Sunflowers"
            case "The Anatomy Lesson of Dr. Nicolaes Tulp, 1632", "The Milkmaid, 1658":
                return "The Milkmaid"
            default:
                return "NA"
        }
    }
    func artistName(for artworkTitle: String) -> String {
        switch artworkTitle {
            case "Girl With A Pearl Earring, 1665":
                return "Johannes Vermeer"
            case "Sunflowers, 1888", "The Starry Night, 1889":
                return "Vincent van Gogh"
            case "The Anatomy Lesson of Dr. Nicolaes Tulp, 1632", "The Milkmaid, 1658":
                return "Johannes Vermeer"
            default:
                return "NA"
        }
    }
    func artYear(for year: String) -> String {
        switch year {
            case "Girl With A Pearl Earring, 1665":
                return "1665"
            case "Sunflowers, 1888", "The Starry Night, 1889":
                return "1889"
            case "The Anatomy Lesson of Dr. Nicolaes Tulp, 1632", "The Milkmaid, 1658":
                return "1658"
            default:
                return "NA"
        }
    }
    func style(for style: String) -> String {
        switch style {
            case "Girl With A Pearl Earring, 1665":
                return "Oil Painting"
            case "Sunflowers, 1888", "The Starry Night, 1889":
                return "Oil Painting"
            case "The Anatomy Lesson of Dr. Nicolaes Tulp, 1632", "The Milkmaid, 1658":
                return "Oil Painting"
            default:
                return "NA"
        }
    }
}
