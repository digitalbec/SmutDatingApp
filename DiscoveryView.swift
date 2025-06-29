import SwiftUI

struct UserProfile: Identifiable {
    let id: UUID
    let name: String
    let age: Int
    let imageName: String
}

struct DiscoveryView: View {
    @State private var profiles = [
        UserProfile(id: UUID(), name: "Alex", age: 25, imageName: "alex"),
        UserProfile(id: UUID(), name: "Jamie", age: 28, imageName: "jamie"),
        UserProfile(id: UUID(), name: "Sam", age: 22, imageName: "sam")
    ]
    
    @State private var likedProfiles: [UUID] = []
    @State private var passedProfiles: [UUID] = []
    
    var body: some View {
        VStack {
            if let profile = profiles.first(where: { !likedProfiles.contains($0.id) && !passedProfiles.contains($0.id) }) {
                VStack {
                    Image(profile.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Text("\(profile.name), \(profile.age)")
                        .font(.title)
                        .padding()
                    HStack {
                        Button(action: {
                            passedProfiles.append(profile.id)
                        }) {
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.red)
                        }
                        Spacer()
                        Button(action: {
                            likedProfiles.append(profile.id)
                        }) {
                            Image(systemName: "heart.circle")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.green)
                        }
                    }
                    .padding(.horizontal, 50)
                }
            } else {
                Text("No more profiles nearby!")
                    .font(.headline)
            }
        }
        .padding()
    }
}