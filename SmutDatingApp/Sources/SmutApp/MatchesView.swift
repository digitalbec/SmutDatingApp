import SwiftUI

struct Match: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    var lastMessage: String
}

struct MatchesView: View {
    // Example static data for matches
    @State private var matches = [
        Match(name: "Alex", imageName: "alex", lastMessage: "Hey there!"),
        Match(name: "Jamie", imageName: "jamie", lastMessage: "How's your day?"),
        Match(name: "Sam", imageName: "sam", lastMessage: "Let's chat!")
    ]
    @State private var selectedMatch: Match? = nil

    var body: some View {
        NavigationView {
            List(matches) { match in
                Button(action: {
                    selectedMatch = match
                }) {
                    HStack {
                        Image(match.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text(match.name).font(.headline)
                            Text(match.lastMessage)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                .sheet(item: $selectedMatch) { match in
                    ChatView(match: match)
                }
            }
            .navigationTitle("Matches")
        }
    }
}

struct ChatView: View {
    let match: Match
    @State private var message = ""
    @State private var messages: [String] = [
        "Hi! 👋", "How are you?"
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(messages, id: \.self) { msg in
                        Text(msg)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
            }
            HStack {
                TextField("Type a message...", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Send") {
                    if !message.isEmpty {
                        messages.append(message)
                        message = ""
                    }
                }
                .padding(.leading, 8)
            }
            .padding()
        }
        .navigationTitle(match.name)
    }
}