import SwiftUI

struct SectionView: View {
    let title: String
    let items: [String]
    let iconNames: [String?]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("Poppins-Bold", size: 20))
                .padding(.bottom, 4)
            
            ForEach(items.indices, id: \.self) { index in
                HStack(spacing: 10) {
                    if let iconName = iconNames[index] {
                        Image(systemName: iconName)
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                    }
                    Text(items[index])
                        .font(.custom("Poppins-Regular", size: 14))
                }
            }
        }
    }
}

