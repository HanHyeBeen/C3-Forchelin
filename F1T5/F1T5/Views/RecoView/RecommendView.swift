//
//  RecommendView.swift
//  F1T5
//
//  Created by 진아현 on 5/30/25.
//

import Foundation
import SwiftUI
import SwiftData
import SwiftUIPager
import UniformTypeIdentifiers
//import MarqueeText

struct RecommendView: View {
    @Query var restaurants: [Restaurant]
    var recommendations: [Restaurant] {
        recommendBasedOnUserRatings(from: restaurants)
    }
    
    @State private var sharedImages: [Int: UIImage] = [:]
    @State private var sharedImage: UIImage? = nil
    @State private var page: Page = .first()
    @State private var isSharing = false
    @State private var shareURL: URL? = nil
    @State private var sharedImageURL: URL? = nil
    @State private var textoffset = 300.0
    
    static let gradientStart = Color.black
    static let gradientEnd = Color.clear
    
    var body: some View {
        GeometryReader { geometry in
            Pager(page: page, data: recommendations, id: \.id) { restaurant in
                recommendItem(restaurant/*, size: geometry.size*/)
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
                
                    .onAppear {
                        if sharedImages[restaurant.id] == nil {
                            captureView(of: recommendItem(restaurant), scale: UIScreen.main.scale, size: geometry.size) { image in
                                if let image = image {
                                    sharedImages[restaurant.id] = image
                                }
                            }
                        }
                    }
            }
            .vertical()
            .interactive(scale: 0.95)
            .itemSpacing(5)
            .padding(.vertical, 10)
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func recommendItem(_ restaurant: Restaurant/*, size: CGSize*/) -> some View {
        ZStack {
            Image("recobackground")
                .resizable()
                .frame(height: 900)
            
            VStack {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 420, height: 230)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.16, green: 0.16, blue: 0.2).opacity(0), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.1, green: 0.06, blue: 0), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 1.08),
                                endPoint: UnitPoint(x: 0.5, y: 0.28)
                            )
                        )
                        .blur(radius: 5)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("포슐랭")
                                .font(
                                    Font.custom("Apple SD Gothic Neo", size: 32)
                                        .weight(.bold)
                                )
                                .foregroundColor(Color.postechOrange)
                            
                            Text("의")
                                .font(
                                    Font.custom("Apple SD Gothic Neo", size: 22)
                                        .weight(.bold)
                                )
                                .foregroundColor(Color.white)
                        }
                        .padding(.top, 50)
                        
                        Text("성준님을 위한 추천 식당이에요!")
                            .font(
                                Font.custom("Apple SD Gothic Neo", size: 22)
                                    .weight(.bold)
                            )
                            .foregroundColor(Color.white)
                    }
                    .padding(30)
                    
                }
                
                Spacer()
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 420, height: 421)
                        .background(
                            LinearGradient(
                                stops: [
                                Gradient.Stop(color: Color(red: 0.16, green: 0.16, blue: 0.2).opacity(0), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.06, green: 0.04, blue: 0), location: 0.57),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: -0.1),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                        )
                    
                    HStack(alignment: .bottom){
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("\(restaurant.area) • \(restaurant.category.rawValue)")
                                .font(
                                    Font.custom("Apple SD Gothic Neo", size: 17)
                                        .weight(.bold)
                                )
                                .foregroundColor(.white)
                                .padding(.top, 50)
                            HStack {
                                if restaurant.label.rawValue == "RED" {
                                    Image("redLabel")
                                        .resizable()
                                        .frame(width: 28, height: 35)
                                } else if restaurant.label.rawValue == "BLUE" {
                                    Image("blueLabel")
                                        .resizable()
                                        .frame(width: 28, height: 35)
                                } else if restaurant.label.rawValue == "GREEN" {
                                    Image("greenLabel")
                                        .resizable()
                                        .frame(width: 28, height: 35)
                                } else if restaurant.label.rawValue == "YELLOW" {
                                    Image("yellowLabel")
                                        .resizable()
                                        .frame(width: 28, height: 35)
                                } else if restaurant.label.rawValue == "PURPLE" {
                                    Image("purpleLabel")
                                        .resizable()
                                        .frame(width: 28, height: 35)
                                }
                                Text(restaurant.name)
                                    .font(
                                        Font.custom("Apple SD Gothic Neo", size: 28)
                                            .weight(.heavy)
                                    )
                                    .foregroundColor(Color.white)
                            }
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
//                                    Color.clear
//                                        .frame(width: 300, height: 30)
//                                        .overlay (
//                                            Text(restaurant.restaurantDescription)
//                                                .foregroundColor(.white)
//                                                .fixedSize()
//                                                .offset(x: textoffset, y: 0)
//                                        )
//                                        .animation(.linear(duration: 10)
//                                                    .repeatForever(autoreverses: false), value: textoffset)
//                                        .clipped()
//                                        .onAppear {
//                                            textoffset = -300.0
//                                        }
                                    Text(restaurant.restaurantDescription)
                                        .font(Font.custom("Apple SD Gothic Neo", size: 17))
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                    
                                    if isWeekend() {
                                        Text("영업시간 \(restaurant.weekendHours) (주말)")
                                            .font(Font.custom("Apple SD Gothic Neo", size: 13))
                                            .foregroundColor(.white)

                                    } else {
                                        Text("영업시간 \(restaurant.weekdayHours) (주중)")
                                            .font(Font.custom("Apple SD Gothic Neo", size: 13))
                                            .foregroundColor(.white)
                                    }
                                    
                                    Button {
                                        
                                    } label: {
                                        Text("상세보기")
                                            .fontWeight(.bold)
                                    }
                                    .buttonStyle(CustomDetailButtonStyle())
                                    .padding(.top, 5)
                                    
                                }
                                
                                Spacer()
                                
                                VStack {
                                    if restaurant.isFavorite {
                                        Button {
                                            restaurant.isFavorite.toggle()
                                        } label: {
                                            Image(systemName: "heart.fill")
                                                .foregroundColor(Color.white)
                                        }
                                        .buttonStyle(CustomMainTrueButtonStyle())
                                    } else {
                                        Button {
                                            restaurant.isFavorite.toggle()
                                        } label: {
                                            Image(systemName: "heart")
                                                .foregroundColor(.white)
                                        }
                                        .buttonStyle(CustomMainFalseButtonStyle())
                                    }
                                    
                                    if let image = sharedImages[restaurant.id],
                                       let url = saveImageToTemporaryDirectory(image) {
                                        ShareLink(item: url) {
                                            Text(Image(systemName: "arrowshape.turn.up.right.fill"))
                                                .foregroundColor(.white)
                                        }
                                        .buttonStyle(CustomMainFalseButtonStyle())
                                    }
                                }
                            }
                            
                            
                        }
                        .padding(30)
                    }
                    .padding(.bottom, 70)
                }
            }
        }
    }
}

func isWeekend() -> Bool {
    let today = Date()
    let calendar = Calendar.current
    let weekday = calendar.component(.weekday, from: today)
    // 일요일 = 1, 토요일 = 7 (기본적으로 일요일이 1)
    return weekday == 1 || weekday == 7
}

struct CustomDetailButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Rectangle()
                .frame(width: 90, height: 38)
                .cornerRadius(10)
                .foregroundColor(configuration.isPressed ? Color.postechOrange : Color.gray)

            configuration.label
                .font(Font.custom("Apple SD Gothic Neo", size: 15))
                .foregroundColor(Color.white)
        }
        .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct CustomMainFalseButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Rectangle()
                .frame(width: 40, height: 40)
                .cornerRadius(12)
                .foregroundColor(Color.gray)
            
            configuration.label
                .font(Font.custom("Apple SD Gothic Neo", size: 15))
        }
    }
}

struct CustomMainTrueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Rectangle()
                .frame(width: 40, height: 40)
                .cornerRadius(12)
                .foregroundColor(Color.postechOrange)
            
            configuration.label
                .font(Font.custom("Apple SD Gothic Neo", size: 15))
        }
    }
}

func saveImageToTemporaryDirectory(_ image: UIImage) -> URL? {
    guard let data = image.pngData() else { return nil }
    let tempDirectory = FileManager.default.temporaryDirectory
    let fileURL = tempDirectory.appendingPathComponent("sharedImage.png")
    
    do {
        try data.write(to: fileURL)
        return fileURL
    } catch {
        print("Error saving image: \(error)")
        return nil
    }
}

@MainActor
func captureView(
        of view: some View,
        scale: CGFloat = 1.0,
        size: CGSize? = nil,
        completion: @escaping (UIImage?) -> Void
    ) {
    let renderer = ImageRenderer(content: view)
    renderer.scale = scale

    if let size = size {
      renderer.proposedSize = .init(size)
    }

    completion(renderer.uiImage)
}
    
struct RecommendView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendView()
    }
}
