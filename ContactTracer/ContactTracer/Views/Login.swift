//
//  Login.swift
//  ContactTracer
//
//  Created by dibs on 10/14/20.
//  Copyright © 2020 NoCap. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct Login: View {
    
    @ObservedObject var user: User

    var body: some View {
        
        ZStack{
            Rectangle()
                .foregroundColor(Color( red: 0/255, green: 128/255, blue: 255/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(Color( red: 102/255, green: 153/255, blue: 255/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
            VStack{
 
                Text("Login")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                Image("whiteMask").resizable()
                                   .frame(width: 200.0, height: 200.0)
                
                Spacer()
                Image(systemName:  "faceid" )
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                
                Text("Please enable faceID ")
                    .foregroundColor(.white)
  
            }
        }.onAppear(perform: initilize)
        
    }
    func initilize(){
        
        getUserData()
        
        if (!user.initilized){
            
            print("posting")
            postUserHash()
            user.initilized = true
        }
    }
    
    // POST
    func postUserHash(){
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        print("fire post" )
        let hashnodash = user.hash.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
        print(hashnodash)
        let parameters: [String: String] = ["hash": String("hello world")]
        //create the url with URL
        guard let url = URL(string: "http://192.168.1.64:8000/user")else{return} //change the url
        //create the session object
        let session = URLSession.shared
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    } // END POST
    
    func getUserData(){
        // initilizes user data
    }
    
}



struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(user: User())
    }
}
