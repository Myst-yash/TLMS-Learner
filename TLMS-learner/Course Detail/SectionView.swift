import SwiftUI

struct SectionView: View {
    let title: String
    let items: [String]
    let iconNames: [String?]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.bottom, 4)
            
            ForEach(items.indices, id: \.self) { index in
                HStack(spacing: 10) {
                    if let iconName = iconNames[index] {
                        Image(systemName: iconName)
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                    }
                    Text(items[index])
                }
                .padding(.vertical, 2)
                .padding(.horizontal, 5)
            }
        }
        .padding(.bottom)
    }
}
