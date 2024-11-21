//
//  GameScene.swift
//  Color Switch Clone
//
//  Created by Seedy on 03/11/2024.
//

import SpriteKit

enum PlayColors {
//    static let colors = [
//        UIColor(named: "red"),
//        UIColor(named: "yellow"),
//        UIColor(named: "green"),
//        UIColor(named: "blue")
//    ]
    static let colors = [
        UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1),
        UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1),
        UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1),
        UIColor(red: 52/255, green: 154/255, blue: 92/255, alpha: 1)
    ]
}

enum SwitchState: Int{
    case red, yellow, green, blue
}


class GameScene: SKScene, SKPhysicsContactDelegate{

    var colorSwitch: SKSpriteNode!
    var switchState = SwitchState.red
    var currentColorIndex: Int?
    var score = 0
    var scoreLbel = SKLabelNode(text: "0")
    
    override func didMove(to view: SKView){
        setupPhysics()
        layoutScene()
    }
    
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.5)
        physicsWorld.contactDelegate = self
    }
    
    func layoutScene(){
        backgroundColor = UIColor(red: 44/225, green: 62/225, blue: 80/225, alpha: 1.0)
        colorSwitch = SKSpriteNode(imageNamed: "ColorCircle")
        colorSwitch.size = CGSize(width: 132, height: 132)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY+colorSwitch.size.height)
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width/2)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory
        colorSwitch.physicsBody?.isDynamic = false
        colorSwitch.zPosition = ZPositions.colorSwitch
        addChild(colorSwitch)
        
        scoreLbel.fontSize = 66.6
        scoreLbel.fontColor = UIColor.white
        scoreLbel.position = CGPoint(x: frame.midX, y: frame.midY)
        scoreLbel.zPosition = ZPositions.label
        addChild(scoreLbel)
        
        spawnBall()
    }
    
    func updateScoreLable(){
        scoreLbel.text = "\(score)"
    }
    
    func spawnBall(){
        currentColorIndex = Int(arc4random_uniform(UInt32(4)))
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: PlayColors.colors[currentColorIndex!], size: CGSize(width: 40, height: 50))
        ball.colorBlendFactor = 1.0
        ball.name = "Ball"
        ball.position = CGPoint(x: frame.midX, y: frame.maxY)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none
        ball.zPosition = ZPositions.ball
        addChild(ball)
    }
    
    func turnColorWheel(){
        if let newState = SwitchState(rawValue: switchState.rawValue+1){
            switchState = newState
        }else{
            switchState = .red
        }
        
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.26))
    }
    
    func gameOver(){
        // save score before popping view
        UserDefaults.standard.set(score, forKey: "score")
        if score > UserDefaults.standard.integer(forKey: "highScore"){
            UserDefaults.standard.set(score, forKey: "highScore")
        }
        let homeScene = HomeScene(size: view!.bounds.size)
        view!.presentScene(homeScene)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnColorWheel()
    }
    
    // MARK: -
    func didBegin(_ contact: SKPhysicsContact){
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory {
            if let ball = contact.bodyA.node?.name == "ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode{
                if currentColorIndex == switchState.rawValue{
                    score += 1
                    updateScoreLable()
                    ball.run(SKAction.fadeOut(withDuration: 0.26)) {
                        ball.removeFromParent()
                        self.spawnBall()
                    }
                }else{
                    gameOver()
                }
            }
        }
    }
    
}
