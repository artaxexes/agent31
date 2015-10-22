//
//  Agent.swift
//  Agent 31
//
//  Created by Henrique Dutra on 20/10/15.
//  Copyright © 2015 Agent31. All rights reserved.
//

import SpriteKit

class Agent: Character {
    
    private let initialAgentImageName: String = "idleAgent1"
    
    init(position: CGPoint = middleOfTheScreenPoint, scale: CGFloat = 1.0, zPosition: CGFloat = 1.0){
        
        debugPrint("Initializing Agent")
        
        super.init(imageName: initialAgentImageName, position: position, scale: scale, zPosition: zPosition)
        
        setGeneralAttributesForAgent()
        self.runAction(SKAction.repeatActionForever(self.idleAnimation!))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setGeneralAttributesForAgent(){
        self.setScale(0.1)
        self.setAgentPhysics()
    }
    
    private func setAgentPhysics(){
        self.physicsBody?.categoryBitMask = ColliderType.Agent.rawValue
        self.physicsBody?.collisionBitMask = ColliderType.Ground.rawValue
    }
    
    override func initializeAnimations(){
        self.runningAnimation = actionWithAnimationName("RunningAgent", numberOfImages: 6, timePerTexture: 0.1)
        self.idleAnimation = actionWithAnimationName("idleAgent", numberOfImages: 2, timePerTexture: 0.2)
        self.jumpAnimation = actionWithAnimationName("jumpAgent", numberOfImages: 2, timePerTexture: 0.3)
        self.gotHitAnimation = actionWithAnimationName("GotHitAgent", numberOfImages: 1, timePerTexture: 0.2)
    }
    
}