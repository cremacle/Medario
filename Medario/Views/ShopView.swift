//
//  ShopView.swift
//  Medario
//
//  Created by Lilly on 2021-11-02.
//

import SwiftUI
import SpriteKit

//Launch Game Screen - SpriteKit
var scene : SKScene{
    let scene = GameScene()
    scene.size = CGSize(width: 1000, height: 750)
    scene.scaleMode = .aspectFit
    scene.anchorPoint = CGPoint(x: 0, y: 0)
        return scene
}

//getting the initial scene to load
class GameScene: SKScene{
    override func didMove(to view: SKView){
        
    }
    
}
struct ShopView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
    }
}
