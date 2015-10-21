//
//  LaboratoryGameLayer.swift
//  Agent 31
//
//  Created by Henrique Dutra on 20/10/15.
//  Copyright © 2015 Agent31. All rights reserved.
//

import SpriteKit

class LaboratoryGameLayer: SKNode {

    var agent31Lab : Agent?
    let analogStick = AnalogStick(diameter: 120)
//    var placeHolder : SKSpriteNode?

    var jumpButtonLab : SKSpriteNode?
    
    override init(){
        
        super.init()
        
        self.loadButtons()
//        self.configureAnalogStick()
        self.placeHolderPut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadButtons(){
    
        jumpButtonLab = createSpriteNode("jumpButton", position: CGPointMake(575, 375-291), zPosition: 2, name: "jumpButtonLab")
    
    }
    
    func placeHolderPut(){

//        placeHolder = createSpriteNode("placeHolderAgent", zPosition: 4, name: "placeHolderAgent")
    
    }
    
//    func configureAnalogStick(){
//
//        let jRadius = 60
//        
//        analogStick.diameter = 120
//        analogStick.position = CGPointMake(60+15, 60+15)
//        analogStick.trackingHandler = { analogStick in
//            
//            guard let aN = self.placeHolder else { return }
//            
//            aN.position = CGPointMake(aN.position.x + (analogStick.data.velocity.x * 0.12), aN.position.y + (analogStick.data.velocity.y * 0.12))
//        }
//        addChild(analogStick)
//    
//    }
    
    func putGameLayer(){
        
        agent31Lab = Agent()
        self.addChild(agent31Lab!)
        self.addChild(jumpButtonLab!)
//        self.addChild(analogStick)
//        self.addChild(placeHolder!)
    }
    
    
    
}
