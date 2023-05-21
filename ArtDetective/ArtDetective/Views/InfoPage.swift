import SwiftUI
import OpenAISwift

final class InfoPageViewModel: ObservableObject {
    private var client: OpenAISwift?

    init() {
        client = OpenAISwift(authToken: Secret.yourOpenAIAPIKey) //API key is protected, please use your own
    }

    func send(text: String, completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: text, maxTokens: 500) { result in
            switch result {
            case .success(let model):
                let output = model.choices?.first?.text ?? ""
                completion(output)
            case .failure:
                break
            }
        }
    }
}

struct InfoPage: View {
    @StateObject private var viewModel = InfoPageViewModel()
    @State private var showPOV = false
    @State private var povResponse = ""

    var body: some View {
        ZStack {
            NavigationView {
                VStack(alignment: .center) {
                    Image("logo")
                        .resizable()
                        .frame(width: 120, height: 120)

                    Spacer()

                    HStack {
                        Image(systemName: "paintbrush.pointed")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 38, height: 32)
                            .offset(x: -2)
                            .padding()
                        Text("Author:")
                            .font(.title2)
                        Text("Leonardo da Vinci")
                            .font(.title3)
                            .bold()
                    }
                    .foregroundColor(Color("LogoBlue"))
                    .padding()

                    HStack {
                        Image(systemName: "timelapse")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 38, height: 32)
                            .offset(x: -2)
                            .padding()
                        Text("Period:")
                            .font(.title2)
                        Text("1400-1412")
                            .font(.title3)
                            .bold()
                    }
                    .foregroundColor(Color("LogoYellow"))
                    .padding()

                    HStack {
                        Image(systemName: "clipboard")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 38, height: 32)
                            .offset(x: -2)
                            .padding()
                        Text("Story:")
                            .font(.title2)
                        Text("Long story short")
                            .font(.title3)
                            .bold()
                    }
                    .foregroundColor(Color("LogoRed"))
                    .padding()

                    Button(action: {
                        fetchPOV()
                    }) {
                        HStack {
                            Text("See POV")
                                .font(.title)
                                .bold()
                        }
                    }
                    .buttonStyle(CreateBgStyle())
                    .padding()
                }
            }
            if showPOV {
                GeometryReader { _ in
                    POVView(povText: povResponse)
                }
                .background(Color.black.opacity(0.65))
                .onTapGesture {
                    withAnimation {
                        showPOV.toggle()
                    }
                }
            }
        }
    }

    private func fetchPOV() {
        viewModel.send(text: "What is the POV of the author?") { response in
            DispatchQueue.main.async {
                povResponse = response
                showPOV.toggle()
            }
        }
    }
}

struct InfoPage_Previews: PreviewProvider {
    static var previews: some View {
        InfoPage()
    }
}

struct POVView: View {
    let povText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 12) {
                Text("Author's POV:")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
            }
            HStack(spacing: 12) {
                Text(povText)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
    }
}
