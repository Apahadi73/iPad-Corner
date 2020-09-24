//
//  AddressView.swift
//  iPadCorner
//
//  Created by Amir Pahadi on 9/23/20.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order : Order
    
    var body: some View {
        Form{
            Section{
                TextField("Name",text:$order.name)
                TextField("Street Address",text:$order.streetAddress)
                TextField("City",text:$order.city)
                TextField("Zip",text:$order.zip)
            }
            Section{
                NavigationLink(
                    destination: CheckoutView(order: order),
                    label: {
                        Text("Checkout").foregroundColor(.blue)
                    })
            }.disabled(order.hasValidAddress==false)
        }
        .navigationBarTitle("Address Information",displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order:Order())
    }
}
