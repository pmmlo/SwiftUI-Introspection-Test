//
//  ContentView.swift
//  Test
//

import SwiftUI
import Introspect

struct ContentView: View {
    @State var data: String = ""
    @State var data2: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
					TextField("Type here one", text: $data).font(.title).padding(.all, 20).modifier(ClearButton(text: $data)).introspectTextField { textField in
                        textField.becomeFirstResponder()
                    }

                    TextField("Type here two", text: $data2).font(.title).padding(.all, 20).modifier(ClearButton(text: $data2))
				}
            }.navigationBarTitle("Your code")
        }.modifier(DismissingKeyboard())
    }
}

struct ClearButton: ViewModifier {
    @Binding var text: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content

            if !text.isEmpty {
                Button(action:
                {
                    self.text = ""
                }) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(Color(UIColor.opaqueSeparator)).font(.system(size: 24, weight: .light))
                }.padding(.trailing, 4)
            }
        }
    }
}

struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}

func dismissKeyboard() {
    UIApplication.shared.endEditing()
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
