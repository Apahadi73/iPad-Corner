//
//  ContentView.swift
//  iPadCorner
//
//  Created by Amir Pahadi on 9/23/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    init() {
            //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.purple]

            //Use this if NavigationBarTitle is with displayMode = .inline
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.purple]
        }
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Choose the ipad: ",
                           selection:$order.type){
                        ForEach(0..<Order.types.count){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value: $order.quantity,in:1...20){
                        Text("Number of iPads: \(order.quantity)")
                    }
                    
                }
                Section{
                    Toggle(isOn: $order.configureRequestEnabled.animation(), label: {
                        Text("Do you want to configure \(Order.types[order.type])?")
                    })
                    if order.configureRequestEnabled{
                        Picker("Finish: ",
                               selection:$order.finish){
                            ForEach(0..<Order.finishColor.count){
                                Text(Order.finishColor[$0])
                            }
                        }
                        Picker("Storage: ",
                               selection:$order.storage){
                            ForEach(0..<Order.storages.count){
                                Text(Order.storages[$0])
                            }
                        }
                        Picker("Connectivity ",
                               selection:$order.connectivity){
                            ForEach(0..<Order.connectivityTypes.count){
                                Text(Order.connectivityTypes[$0])
                            }
                        }
                    }
                }
                Section{
                    NavigationLink(destination:
                                    AddressView(order:order)){
                        Text("Address Information").foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("iPad Corner")
            .navigationBarHidden(false)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
