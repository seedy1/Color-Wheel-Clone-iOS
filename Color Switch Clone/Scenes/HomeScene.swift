//
//  HomeScene.swift
//  Color Switch Clone
//
//  Created by Seedy on 20/11/2024.
//

import SpriteKit

class HomeScene: SKScene{
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 44/225, green: 62/225, blue: 80/225, alpha: 1.0)
        
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: frame.size.width / 4, height: frame.size.height / 4)
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height / 4)
        addChild(logo)
        
        let playLabel = SKLabelNode(text: "Tap to play")
        playLabel.fontSize = 60
        playLabel.fontColor = UIColor.white
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let highScoreLabel = SKLabelNode(text: "High Score:" + "\(UserDefaults.standard.integer(forKey: "highScore"))")
        highScoreLabel.fontSize = 50
        highScoreLabel.fontColor = UIColor.white
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLabel.frame.size.height * 4)
        
        let recentScoreLabel = SKLabelNode(text: "Last Score:" + "\(UserDefaults.standard.integer(forKey: "score"))")
        recentScoreLabel.fontSize = 50
        recentScoreLabel.fontColor = UIColor.white
        recentScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - recentScoreLabel.frame.size.height * 6)
        
        addChild(playLabel)
        addChild(highScoreLabel)
        addChild(recentScoreLabel)
        
        // animations
        animate(label: playLabel)
    }
    
    func animate(label: SKLabelNode){
        let fadeOut = SKAction.fadeOut(withDuration: 0.6)
        let fadeIn = SKAction.fadeIn(withDuration: 0.4)
        let seq = SKAction.sequence([fadeOut, fadeIn])
//        label.run(seq)
        label.run(SKAction.repeatForever(seq))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view!.presentScene(gameScene)
    }

}
