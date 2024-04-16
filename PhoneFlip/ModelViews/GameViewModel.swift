//
//  GameViewModel.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 3/12/24.
//
import CoreMotion
import Foundation
import Combine

class GameViewModel: ObservableObject {
    @Published var gameSession = GameSession(lastFlip: Flip.notSet, score: 0, timeLeft: 15, isRunning: false)
    @Published var currentMode: GameMode
    @Published var score: Int = 0
    @Published var isRunning: Bool = false
    @Published var lastFlip: Flip = .notSet
    @Published var nextFlip: Flip = .notSet
    @Published var matched: MatchState = .notSet
    @Published var refreshable: Bool = false
    @Published var timeLeft: TimeInterval = 0
    private var cancellables: Set<AnyCancellable> = []
    
    private let rotationThreshold = 5
    private let resetThreshold = 1
    
    var motionManager = CMMotionManager()
    var timer: Timer?
    var xRotation = 0
    var yRotation = 0
    var zRotation = 0
    
    var isFlipping = false
    var flipMetrics: [[Int]] = []
    
    init(currentMode: GameMode) {
        self.currentMode = currentMode
        // Observing changes to gameSession.lastFlip
        gameSession.$timeLeft.assign(to:&$timeLeft)
        gameSession.$score.assign(to: &$score)
        gameSession.$isRunning.assign(to: &$isRunning)
        gameSession.$lastFlip.assign(to: &$lastFlip)
        gameSession.$nextFlip.assign(to: &$nextFlip)
        gameSession.$refreshable.assign(to: &$refreshable)
        setGameSettings(newMode: currentMode)

    }

    
    func startGame(){
        print("Start game")
        self.gameSession.isRunning = true
        print("Debug Values:")
            print("ViewModel Score: \(self.score), GameSession Score: \(self.gameSession.score)")
            print("ViewModel IsRunning: \(self.isRunning), GameSession IsRunning: \(self.gameSession.isRunning)")
            print("ViewModel LastFlip: \(self.lastFlip), GameSession LastFlip: \(self.gameSession.lastFlip)")
            print("ViewModel Refreshable: \(self.refreshable), GameSession Refreshable: \(self.gameSession.refreshable)")
        if(currentMode == .classic){
            timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { [weak self] _ in
                self?.gameSession.timeLeft -= 0.001
                if self?.gameSession.timeLeft ?? 0 <= 0.001{
                    self?.endGame()
                }
            }
        } else if( currentMode == .followTheLeader){
            generateNewTrick()
        }
        startDetecting()
    }

    
    func endGame() {
        print("End Game")
        timer?.invalidate()
        timer = nil
        self.gameSession.isRunning = false
        self.gameSession.refreshable = true
    }
    
    private func updateScore(flip: Flip){
        self.gameSession.score += flip.score
    }
    
    func refreshGame() {
        print("Refresh Game")
        timer?.invalidate()
        timer = nil
        self.gameSession.isRunning = false
        self.gameSession.refreshable = false
        self.gameSession.lastFlip = .notSet
        gameSession.timeLeft = gameSession.defaultTimeLeft
        gameSession.score = 0
    }
    
    func startDetecting() {
            motionManager.startGyroUpdates(to: OperationQueue.current!){ [weak self] (data, error) in
                guard let self = self, let trueData = data else { return }

                self.updateRotationRates(with: trueData.rotationRate)
                self.checkForFlipStart()
                self.recordFlipMetricsIfNeeded()
                self.checkForFlipCompletion()
                self.resetRotationRatesIfNeeded(with: trueData.rotationRate)
            }
        }
    
    private func updateRotationRates(with rotationRate: CMRotationRate) {
            xRotation += Int(rotationRate.x)
            yRotation += Int(rotationRate.y)
            zRotation += Int(rotationRate.z)
        }
    
    private func checkForFlipStart() {
            if (xRotation > rotationThreshold || yRotation > rotationThreshold || zRotation > rotationThreshold) && !isFlipping {
                isFlipping = true
            }
        }
    
    private func recordFlipMetricsIfNeeded() {
            if isFlipping {
                flipMetrics.append([xRotation, yRotation, zRotation])
            }
        }
    
    private func checkForFlipCompletion() {
        if isFlipping && xRotation == 0 && yRotation == 0 && zRotation == 0 && gameSession.isRunning {
                CheckTrick(trickStats: flipMetrics)
                isFlipping = false
            }
        }
    
    private func resetRotationRatesIfNeeded(with rotationRate: CMRotationRate) {
        if abs(Int32(rotationRate.x)) < resetThreshold && abs(Int32(rotationRate.y)) < resetThreshold && abs(Int32(rotationRate.z)) < resetThreshold {
                xRotation = 0
                yRotation = 0
                zRotation = 0
            }
        }
    func CheckTrick(trickStats: [[Int]]){
        var max = [0,0,0]
        var min = [0,0,0]
        var y = 0
        for x: [Int] in trickStats {
            print(x)
            while (y<3){
                if (x[y] > max[y]){
                    max[y] = x[y]
                }
                if (x[y] < min[y]){
                    min[y] = x[y]
                }
                y+=1
            }
            y=0
            
            
        }
        print("The maximum & min rotation of this flip were: \(max) and min: \(min)")
        let newFlip = lastFlip.WhatTrick(max: max, min: min)
        if(newFlip != .notSet){
            self.gameSession.lastFlip = newFlip
            if(currentMode == .followTheLeader){
                matched = matchedFlip(newFlip: newFlip, nextFlip: nextFlip)
            }
        }
        
        self.flipMetrics.removeAll()
        updateScore(flip: newFlip)
       
    }
    
    func matchedFlip(newFlip: Flip, nextFlip: Flip) -> MatchState{
        if(newFlip == self.nextFlip){
            generateNewTrick()
            return .matched
        } else {
            return .notMatched
        }
    }
    
    func generateNewTrick() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let allFlips = Flip.allCases.filter { $0 != .notSet }
                if let randomFlip = allFlips.randomElement(){
                    self.gameSession.nextFlip = randomFlip
                }
            self.gameSession.lastFlip = .notSet
            self.matched = .notSet
        }
        
    }
    
    func setGameSettings(newMode: GameMode){
        switch newMode {
        case .classic:
            
            break
        case .followTheLeader:
            startGame()
            break
        case .freestyle:
            startGame()
            break
        }
    }
}
