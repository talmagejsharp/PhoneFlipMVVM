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
        gameSession.$refreshable.assign(to: &$refreshable)

    }

    
    func startGame(){
        print("Start game")
        self.gameSession.isRunning = true
        print("Debug Values:")
            print("ViewModel Score: \(self.score), GameSession Score: \(self.gameSession.score)")
            print("ViewModel IsRunning: \(self.isRunning), GameSession IsRunning: \(self.gameSession.isRunning)")
            print("ViewModel LastFlip: \(self.lastFlip), GameSession LastFlip: \(self.gameSession.lastFlip)")
            print("ViewModel Refreshable: \(self.refreshable), GameSession Refreshable: \(self.gameSession.refreshable)")

        timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { [weak self] _ in
            self?.gameSession.timeLeft -= 0.001
            if self?.gameSession.timeLeft ?? 0 <= 0.001{
                self?.endGame()
            }
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
    
    func refreshGame() {
        print("Refresh Game")
        timer?.invalidate()
        timer = nil
        self.gameSession.isRunning = false
        self.gameSession.refreshable = false
        self.gameSession.lastFlip = .notSet
        gameSession.timeLeft = gameSession.defaultTimeLeft
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
    /*
    func startDetecting() {
        motionManager.startGyroUpdates(to: OperationQueue.current!){(data, error)in
            if let trueData = data{
//                self.gameSession.score = "Score: \(self.scoreNum)"
                self.xRotation += Int(trueData.rotationRate.x)
                self.yRotation += Int(trueData.rotationRate.y)
                self.zRotation += Int(trueData.rotationRate.z)
                if ((self.xRotation > 5 || self.yRotation > 5 || self.zRotation > 5) && !self.isFlipping) {
                    self.isFlipping = true
                }
                if (self.isFlipping){
                    self.flipMetrics.append([self.xRotation, self.yRotation, self.zRotation])
                }
                if (self.isFlipping && self.xRotation == 0 && self.yRotation == 0 && self.zRotation == 0){
                    if (self.gameSession.isRunning) {
                        self.CheckTrick(trickStats: self.flipMetrics)
                    }
                    self.isFlipping = false
                }
                if self.xRotation != 0 || self.yRotation != 0 || self.zRotation != 0 {
                    //print("x: \(self.xRotation)" + "  y: \(self.yRotation)" + "   z\(self.zRotation)")
                }
                if trueData.rotationRate.x < 1 && trueData.rotationRate.y < 1 && trueData.rotationRate.z < 1 {
                   self.xRotation = 0
                   self.yRotation = 0
                   self.zRotation = 0
                }
            }
            
        }
    }
    */
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
        }
        
        self.flipMetrics.removeAll()
    }
}
