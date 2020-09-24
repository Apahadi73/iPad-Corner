//
//  CheckoutView.swift
//  iPadCorner
//
//  Created by Amir Pahadi on 9/23/20.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order : Order
    @State private var confirmationMessage = ""
    @State private var alertTitle = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                VStack{
                    Image(order.iPadImage)
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(width: geometry.size.width)
                        
                    Text("Your total is $\(order.total)")
                    Button("Place order") {
                        placeOrder()
                    }
                    .padding()
                }
            }
            
        }
        .navigationBarTitle("Checkout",displayMode: .inline)
        .alert(isPresented: $showingConfirmation, content: {
            Alert(title: Text((alertTitle)), message: Text("\(confirmationMessage)"), dismissButton: .default(Text("OK")))
        })
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else{
            print("Failed to encode order")
            return
        }

        
        let url = URL(string:"https://reqres.in/api/products")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod="POST"
        request.httpBody = encoded

        URLSession.shared.dataTask(with: request){data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown Error" )")
                confirmationMessage="Failed to place an order.Please try again later"
                alertTitle = ("Order Failed")
                showingConfirmation = true
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data){

                confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type]) is on its way"
                alertTitle="Order Placed"

                self.showingConfirmation = true
            }else{
                print("Invalid response from the server")
                
            }
            
        }.resume()
    }
    
   
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
