//
//  StatRowView.swift
//  PokemonSearch
//
//  Created by Cascade on 2025-07-15.
//

import SwiftUI

struct StatRowView: View {
    let statName: String
    let statValue: Int
    
    // Maximum stat value for progress calculation (typical Pokemon stats range)
    private let maxStatValue: Double = 150.0
    
    var body: some View {
        HStack {
            // Stat name
            Text(formattedStatName)
                .font(.body)
                .frame(width: 100, alignment: .leading)
            
            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background bar
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 8)
                    
                    // Progress bar
                    RoundedRectangle(cornerRadius: 4)
                        .fill(colorForStat)
                        .frame(width: geometry.size.width * progressPercentage, height: 8)
                }
            }
            .frame(height: 8)
            
            // Stat value
            Text("\(statValue)")
                .font(.body)
                .fontWeight(.semibold)
                .frame(width: 40, alignment: .trailing)
        }
    }
    
    // Format stat names to be more readable
    private var formattedStatName: String {
        switch statName.lowercased() {
        case "hp": return "Hp"
        case "attack": return "Attack"
        case "defense": return "Defense"
        case "special-attack": return "Special Attack"
        case "special-defense": return "Special Defense"
        case "speed": return "Speed"
        default: return statName.capitalized
        }
    }
    
    // Calculate progress percentage
    private var progressPercentage: Double {
        min(Double(statValue) / maxStatValue, 1.0)
    }
    
    // Color based on stat value
    private var colorForStat: Color {
        let percentage = progressPercentage
        if percentage >= 0.8 {
            return .green
        } else if percentage >= 0.6 {
            return .yellow
        } else if percentage >= 0.4 {
            return .orange
        } else {
            return .red
        }
    }
}

struct StatRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 12) {
            StatRowView(statName: "hp", statValue: 60)
            StatRowView(statName: "attack", statValue: 62)
            StatRowView(statName: "defense", statValue: 63)
            StatRowView(statName: "special-attack", statValue: 80)
            StatRowView(statName: "special-defense", statValue: 80)
            StatRowView(statName: "speed", statValue: 60)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
