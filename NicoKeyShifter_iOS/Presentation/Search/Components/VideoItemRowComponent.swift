//
//
//

import SwiftUI

struct VideoItemRowComponent: View {
    let video: VideoDomainModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            AsyncImage(url: URL(string: video.thumbnailUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Image(systemName: "video.slash")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 80, height: 80)
            .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(video.title)
                    .font(.headline)
                    .lineLimit(2)
                
                Text("再生数: \(formatViewCount(video.viewCount))")
                    .font(.subheadline)
                
                Text("ID: \(video.id)")
                    .font(.caption)
            }
        }
        .padding(8)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 1)
    }
    
    private func formatViewCount(_ count: Int) -> String {
        switch count {
        case 10000...:
            return "\(count / 10000)万"
        case 1000...:
            return "\(count / 1000)千"
        default:
            return "\(count)"
        }
    }
}

struct VideoItemRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        VideoItemRowComponent(video: VideoDomainModel.ofDefault())
            .previewLayout(.sizeThatFits)
    }
}
