//
//  ContentView.swift
//  ColorSlidersSwiftUI
//
//  Created by Andrey Khakimov on 24.01.2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var redColorValue: Double = 70
    @State private var greenColorValue: Double = 160
    @State private var blueColorValue: Double = 220
    
    var body: some View {
        VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 350, height: 150)
                .padding()
                .foregroundColor(
                    Color(red: redColorValue / 255,
                          green: greenColorValue / 255,
                          blue: blueColorValue / 255)
                )
            ColorSliderView(value: $redColorValue, color: .red)
            ColorSliderView(value: $greenColorValue, color: .green)
            ColorSliderView(value: $blueColorValue, color: .blue)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorSliderView: View {
    @Binding var value: Double
    let color: Color
    
    var body: some View {
        HStack {
            Text("\(value.formatted(.number))").foregroundColor(color)
                .frame(width: 40)
            Slider(value: $value, in: 0...255, step: 1)
                .tint(color)
            TextField("", value: $value, format: .number)
                .frame(width: 40)
                .keyboardType(.numberPad)
                .onReceive(Just(self.value)) { inputValue in
                    if inputValue > 255 {
                        self.value = 255
                    }
                }
//            Button("Submit") {
                //                self.enteredNumber = self.someNumber
                //                self.someNumber = ""
//                UIApplication.shared.endEditing()
//            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
        .padding()
    }
}

extension ContentView {
    func checkTextField(text: String) -> Bool {
        if text.count > 3 {
            return false
        }
        if let value = Double(text), value >= 0 {
            return true
        }
        return false
    }
}

//extension UIApplication {
//    func endEditing() {
//        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}


