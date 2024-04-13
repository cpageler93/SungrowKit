//
//  SungrowPowerFlow.swift
//  SungrowKit
//
//  Created by Christoph Pageler on 13.04.24.
//

import Foundation

public struct SungrowPowerFlow {
    public let input: Input
    public let output: Output

    public struct Input {
        public let load: Double
        public let grid: Double
        public let solar: Double
        public let battery: Double
        public let runningState: SungrowRunningState
    }

    public struct Output {
        public let solarToBattery: Double
        public let solarToLoad: Double
        public let solarToGrid: Double

        public let batteryToLoad: Double
        public let batteryToGrid: Double

        public let gridToBattery: Double
        public let gridToLoad: Double
    }

    static func calculate(input: Input) -> SungrowPowerFlow {
        // Calculate Solar
        var solarToBattery = 0.0
        var solarToLoad = 0.0
        var solarToGrid = 0.0
        var loadRemaining = input.load
        if (input.runningState.isPowerGeneratedFromPV) {
            var remaining = input.solar
            if remaining > loadRemaining {
                solarToLoad = loadRemaining
                remaining -= input.load
                loadRemaining = 0
            } else {
                solarToLoad = remaining
                loadRemaining = input.load - remaining
                remaining = 0
            }

            if input.runningState.isBatteryCharging {
                if remaining > input.battery {
                    solarToBattery = input.battery
                    remaining -= input.battery
                } else {
                    solarToBattery = remaining
                    remaining = 0
                }
            }

            if input.grid > 0 {
                solarToGrid = min(input.grid, remaining)
            }
        }

        // Calculate Battery
        var batteryToLoad = 0.0
        var batteryToGrid = 0.0
        if input.runningState.isBatteryDischarging {
            var remaining = input.battery
            if remaining > loadRemaining {
                batteryToLoad = loadRemaining
                remaining -= loadRemaining
                loadRemaining = 0
            } else {
                batteryToLoad = remaining
                loadRemaining -= remaining
                remaining = 0
            }

            if input.runningState.isPowerFeedInTheGrid {
                batteryToGrid = min(input.grid, remaining)
            }
        }

        // Calculate grid
        var gridToBattery = 0.0
        var gridToLoad = 0.0
        if input.grid < 0 {
            var remaining = abs(input.grid)
            if remaining > loadRemaining {
                gridToLoad = loadRemaining
                remaining -= loadRemaining
                loadRemaining = 0
            } else {
                gridToLoad = remaining
                loadRemaining -= remaining
                remaining = 0
            }

            if input.runningState.isBatteryCharging {
                gridToBattery = min(input.battery, remaining)
            }
        }

        return .init(
            input: input,
            output: .init(
                solarToBattery: solarToBattery,
                solarToLoad: solarToLoad,
                solarToGrid: solarToGrid,
                batteryToLoad: batteryToLoad,
                batteryToGrid: batteryToGrid,
                gridToBattery: gridToBattery,
                gridToLoad: gridToLoad
            )
        )
    }
}
