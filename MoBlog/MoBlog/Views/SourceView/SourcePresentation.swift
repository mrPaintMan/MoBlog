//
//  SourcePresentation.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-11-22.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI
import CoreData

struct SourcePresentation: View {
    @ObservedObject var source: Source
    @EnvironmentObject var followingInfo: FollowingInfo
    var viewContext: NSManagedObjectContext
    var dismissFunc: () -> Void
    
    var body: some View {
        VStack {
            source.getImage(size: CGSize(width: UIScreen.main.bounds.size.width, height: 10), alternative: true)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.size.width, height: 250, alignment: .center)
                .padding(.bottom, -85)
                .overlay(
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(
                            ZStack {
                                VStack {
                                    LinearGradient(gradient: Gradient(colors: [Color(.black).opacity(0), Color(.black)]), startPoint: .bottom, endPoint: .top)
                                        .frame(height: 225)
                                    
                                        Spacer()
                                }
                                HStack {
                                    Button(action: {
                                        dismissFunc()
                                    }, label: {
                                        HStack {
                                            Image(systemName: "chevron.left")
                                            Text("Back")
                                        }
                                    })
                                    .foregroundColor(.white)
                                    .padding()
                                    
                                    Spacer()
                                }
                            }
                        )
                )
            
            ProfileImage(source: source, width: 150, height: 150)
            
            Text(source.name)
                .font(.title)
            
            Text(source.description)
                .padding()
            
            HStack(spacing: 0) {
                Spacer()
                
                SourceFollowingButton(viewContext: viewContext)
                
                VStack {
                    if followingInfo.following && followingInfo.notification {
                        Color.blue.opacity(0.5)
                    }
                    
                    else {
                        Color.moBlogRed.opacity(0.5)
                    }
                }
                .frame(width: 3, height: 40)
                
                SourceNotificationButton(viewContext: viewContext)
                
                Spacer()
            }
            
            Spacer()
        }.ignoresSafeArea(.all)
    }
}

struct SourcePresentation_Previews: PreviewProvider {
    static let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static var previews: some View {
        
        SourcePresentation(source: SourceData[0], viewContext: viewContext, dismissFunc: { print("hej") })
    }
}
