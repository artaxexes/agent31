//
//  TestCityGameLayer.swift
//  Agent 31
//
//  Created by Julio Xavier on 30/10/15.
//  Copyright © 2015 Agent31. All rights reserved.
//

import SpriteKit

@available(iOS 9.0, *)
class TestCityGameLayer: SKNode, EnemyDelegate {
    
    var agent31 : Agent?
    
    override init(){
        
        super.init()
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    
    func putGameLayer(){
        self.putGround()
        self.putAgent()
        self.putTestEnemy()
        
        createBlock(CGPointMake(middleOfTheScreenPoint.x/2, middleOfTheScreenPoint.y))
        createBlock(CGPointMake(middleOfTheScreenPoint.x*2, middleOfTheScreenPoint.y*2))
    }
    
    func putGround(){
        let ground = Ground(imageName: "testCityGround", position: CGPointMake(middleOfTheScreenPoint.x, 0), zPosition: 1)
        self.addChild(ground)
    }
    
    func createBlock(position: CGPoint){
        let block = GameObject(imageName: "testCityBlock", position: position, zPosition: 1)
        block.physicsBody?.categoryBitMask = ColliderType.Ground.rawValue
        block.physicsBody?.collisionBitMask = ColliderType.Agent.rawValue
        block.physicsBody?.dynamic = false
        block.physicsBody?.affectedByGravity = false
        block.yScale = (block.yScale)/2
        self.addChild(block)
    }
    
    func putAgent(){
        agent31 = Agent(position: CGPointMake(middleOfTheScreenPoint.x, yPositionFloor))
        self.addChild(agent31!)
    }
    
    func putTestEnemy(){
        let testEnemy = GeneralEnemy(position: CGPointMake(middleOfTheScreenPoint.x - 200, yPositionFloor))
        let secEnemy = GeneralEnemy(position: CGPointMake(middleOfTheScreenPoint.x - 100, yPositionFloor), enemyLevel: 5)
        self.addChild(testEnemy)
        self.addChild(secEnemy)
    }
    
    func calculateDistanceToAgent( enemyPosition: CGPoint ) -> CGFloat {
        return distanceBetweenPoints( self.agent31!.position, second: enemyPosition )
    }
    
    func updateEnemy(currentTime: NSTimeInterval){
        self.enumerateChildNodesWithName("enemy", usingBlock: {
            node, stop in
            // Block below is executed if a enemy is found
            
            if let foundEnemy = node as? GeneralEnemy{
                
                foundEnemy.setDistanceToAgent( (self.agent31?.position)! )
                foundEnemy.update(currentTime)
                
            }else{
                debugPrint("Enemy isn't found")
            }
            
        })
    }

}

// MARK: CONTACT
@available(iOS 9.0, *)
extension TestCityGameLayer{
    func didBeginContact(contact: SKPhysicsContact){
        
        
        let node1: SKNode = contact.bodyA.node!
        let node2: SKNode = contact.bodyB.node!
        
        if(node1.isKindOfClass(Character)){
            self.didBeginContactWithCharacter(node1, nodeB: node2)
        }else if(node2.isKindOfClass(Character)){
            self.didBeginContactWithCharacter(node2, nodeB: node1)
        }else if(node1.isKindOfClass(Bullet)){
            (node1 as? Bullet)?.didBeginContact(node2)
        }else if(node2.isKindOfClass(Bullet)){
            (node2 as? Bullet)?.didBeginContact(node1)
        }else if(node1.isKindOfClass(Metal)){
            (node1 as? Metal)?.didBeginContact(node2)
        }else if(node2.isKindOfClass(Metal)){
            (node2 as? Metal)?.didBeginContact(node1)
        }else if(node1.isKindOfClass(Coin)){
            (node1 as? Coin)?.didBeginContact(node2)
        }else if(node2.isKindOfClass(Coin)){
            (node2 as? Coin)?.didBeginContact(node1)
        }
        
    }
    
    func didEndContact(contact: SKPhysicsContact){
        
//        let node1: SKNode = contact.bodyA.node!
//        let node2: SKNode = contact.bodyB.node!
    }
    
    func didBeginContactWithCharacter(charac: SKNode, nodeB: SKNode){
        
        if charac.isKindOfClass(Agent){
            let passHP = self.agent31?.HP
            (charac as? Agent)?.didBeginContact(nodeB)
            if(self.agent31?.HP < passHP){
                let scene = (self.parent as? TestCityScene)!
                scene.cam.runAction(scene.trembleCameraAction())
                scene.addGotHitHud()
            }
        }else{
            (charac as? Character)?.didBeginContact(nodeB)
        }
    }
    
}
