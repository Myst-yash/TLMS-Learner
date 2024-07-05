import SwiftUI

// Custom Image struct
struct PNGImageView: View {
    var imageName: String
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        // Load the image and apply constraints
        if let uiImage = UIImage(named: imageName),
           uiImage.isPNG() {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
        } else {
            // Placeholder or error handling for non-PNG images or image not found
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .foregroundColor(.red)
        }
    }
}

// UIImage extension to check for PNG format
extension UIImage {
    func isPNG() -> Bool {
        guard let data = self.pngData() else { return false }
        return UIImage(data: data) != nil
    }
}
