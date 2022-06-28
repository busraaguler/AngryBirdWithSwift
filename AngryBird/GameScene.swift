//
//  GameScene.swift
//  AngryBird
//
//  Created by busraguler on 21.06.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene , SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    // var bird2 = SKSpriteNode()
    var bird = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    
    var gameStarted = false
    var originalPosition :CGPoint?
    
    enum ColliderType : UInt32 {
        case Bird = 1
        case box = 2
    }
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    
    override func didMove(to view: SKView) {  //çalış
        /*let texture = SKTexture(imageNamed: "bird")
        bird2 = SKSpriteNode(texture: texture)
        bird2.size = CGSize(width: self.frame.width / 16, height: 100)
        bird2.position = CGPoint(x: 0.0, y: 0.0)
        self.addChild(bird2)*/
        
        //physicsBody
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        
        self.physicsWorld.contactDelegate = self
        //bird
    
        bird = childNode(withName: "bird") as! SKSpriteNode
        let birdtexture = SKTexture(imageNamed: "bird")
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdtexture.size().height / 13) //Yuvarlak bi şekil ve
        bird.physicsBody?.affectedByGravity = false //yer çekiminden etkilensin mi
        bird.physicsBody?.isDynamic = true //fiziksel similasyonlardan etkilenecek mi
        bird.physicsBody?.mass = 0.25
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        originalPosition = bird.position
        
        bird.physicsBody?.collisionBitMask = ColliderType.box.rawValue
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue

        //boxs

        let boxtexture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: boxtexture.size().width / 5, height: boxtexture.size().height / 6)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)
        box1.physicsBody?.affectedByGravity = true  //yer çekimi
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.allowsRotation = true //boxların sağa sola savrulması
        box1.physicsBody?.mass = 0.4
        
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.affectedByGravity = true  //yer çekimi
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.allowsRotation = true //boxların sağa sola savrulması
        box2.physicsBody?.mass = 0.4
        
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.affectedByGravity = true  //yer çekimi
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.allowsRotation = true //boxların sağa sola savrulması
        box3.physicsBody?.mass = 0.4
        
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.affectedByGravity = true  //yer çekimi
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.allowsRotation = true //boxların sağa sola savrulması
        box4.physicsBody?.mass = 0.4
        
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.affectedByGravity = true  //yer çekimi
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.allowsRotation = true //boxların sağa sola savrulması
        box5.physicsBody?.mass = 0.4
        
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.zPosition = 2
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        self.addChild(scoreLabel)

    }

    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { //dokunmaya başladı
       /* bird.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 100))
        bird.physicsBody?.affectedByGravity = true */
        
        if gameStarted == false{
            if let touch = touches.first{
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation) //touchLocation node'u
                
                if touchNodes.isEmpty == false { //gerçekten dokunjulan bir node varsa
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode{
                            
                            if sprite == bird {  //sprite (dokunulan node) kuş ile aynıysa kuşun yeni pozisyonu toucLocation
                                bird.position = touchLocation
                            }
                            
                        }
                    }
                }
                
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { //elini oynattı //dokunmaya devam ediyor
        if gameStarted == false{
            if let touch = touches.first{
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation) //touchLocation node'u
                
                if touchNodes.isEmpty == false { //gerçekten dokunjulan bir node varsa
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode{
                            
                            if sprite == bird {  //sprite (dokunulan node) kuş ile aynıysa kuşun yeni pozisyonu toucLocation
                                bird.position = touchLocation
                            }
                            
                        }
                    }
                }
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { //dokunmayı bitirdi
        //Kuşu fırlatma // az çekerse az fırlatma çok çekerse çok fırlatma
        //kuşun ilk nerde olduğunu ve dokunulan yerin neresi olduğunu ayni aralarındaki mesafeyi bilmemiz gerekli
        if gameStarted == false{
            if let touch = touches.first{
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation) //touchLocation node'u
                
                if touchNodes.isEmpty == false { //gerçekten dokunjulan bir node varsa
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode{
                            
                            if sprite == bird {  //sprite (dokunulan node) kuş ile aynıysa kuşun yeni pozisyonu toucLocation
                                
                                let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y - originalPosition!.y)
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.affectedByGravity = true  //yer çekimini etkin yapar.
                                bird.physicsBody?.applyImpulse(impulse) //impulse u ekler.
                      
                                gameStarted = true
                                
                            }
                            
                        }
                    }
                }
                
            }
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) { //dokunmaktan vazgeçti
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {  //  render yapıldığında ekran çağırılır.
        // Called before each frame is rendered
        
        if let birdPhysicalBody = bird.physicsBody {
            if birdPhysicalBody.velocity.dx <= 0.1 && birdPhysicalBody.velocity.dy <= 0.1 && birdPhysicalBody.angularVelocity <= 0.1 && gameStarted == true{
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.angularVelocity = 0
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.zPosition = 1
                bird.position = originalPosition!
                
                score = 0
                scoreLabel.text = String(score)
                gameStarted = false
                
                
                
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            score += 1
            scoreLabel.text = String(score)
        }
    }
}
