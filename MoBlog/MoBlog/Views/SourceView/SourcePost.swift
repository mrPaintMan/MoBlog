//
//  SourcePost.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-10-31.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct SourcePost: View {
    private let width = 2 * UIScreen.main.bounds.size.width / 5
    @ObservedObject var post: Post
     
    var body: some View {
        ZStack {
            self.post.getImage(size: CGSize(width: width, height: width))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(Color.white.opacity(0.3))
                .blur(radius: 7)
            
            Text(self.post.title)
                .bold()
                .font(.system(size: 14))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(5)
                .frame(width: width - 20)
            
            VStack{
                Spacer()
                
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: width, height: 25)
                    .overlay (
                        HStack{
                            Spacer()
                            
                            Text(getDate(post: post))
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                                .padding(.trailing, 15)
                        }
                    )
            }
        }
        .frame(width: width, height: width)
        .cornerRadius(15)
        .padding(5)
        .contentShape(Rectangle())
    }
}

func getDate(post: Post) -> String {
    let month = post.extId.suffix(8).prefix(2)
    let day =  post.extId.suffix(6).prefix(2)
    
    let months: [String : String] = [
        "01": "jan",
        "02": "feb",
        "03": "mars",
        "04": "apr",
        "05": "may",
        "06": "jun",
        "07": "jul",
        "08": "aug",
        "09": "sep",
        "10": "okt",
        "11": "nov",
        "12": "dec"
    ]
    return day + " " + (months[String(month)] ?? "NA")
}

struct SourcePost_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            
            Color(.darkGray)
            
            HStack {
                Spacer()
                SourcePost(post: PostData[0])
                
                Spacer()
                
                SourcePost(post: PostData[0])
                Spacer()
            }
        }
    }
}
